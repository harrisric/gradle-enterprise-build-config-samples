/**
 * This Groovy script captures data about the OS, IDE, CI, and Git and stores it in build scans via custom tags, custom links, and custom values.
 *
 * Proceed as following to benefit from this script in your Maven build:
 *
 * - Copy this script to the root folder of your Maven project, renaming it to 'build-scan-user-data.groovy'
 * - Apply the Gradle Enterprise Maven extension, following https://docs.gradle.com/enterprise/maven-extension/#getting_set_up_with_the_gradle_enterprise_maven_extension
 * - Ensure the Gradle Enteprise server is correctly configured, following https://docs.gradle.com/enterprise/maven-extension/#set_the_location_of_your_gradle_enterprise_instance
 * - Use the Groovy Maven plugin to execute this script, following https://docs.gradle.com/enterprise/maven-extension/#using_the_build_scan_api_in_a_groovy_script
 * - Further customize this script to your needs
 */

def buildScan = session.lookup("com.gradle.maven.extension.api.scan.BuildScanApi")

buildScan.executeOnce('custom-data') { api ->
    tagOs(api)
    tagIde(api)
    tagCiOrLocal(api)
    addCiMetadata(api)
    addGitMetadata(api)
}

void tagOs(def api) {
    api.tag System.getProperty('os.name')
}

void tagIde(def api) {
    if (project.hasProperty('android.injected.invoked.from.ide')) {
        api.tag 'Android Studio'
    } else if (System.getProperty('idea.version')) {
        api.tag 'IntelliJ IDEA'
    } else if (System.getProperty('eclipse.buildId')) {
        api.tag 'Eclipse'
    } 
}

void tagCiOrLocal(def api) {
    api.tag(isCi() ? 'CI' : 'LOCAL')
}

void addGitMetadata(def api) {
    api.background { bck ->
        def gitCommitId = execAndGetStdout('git', 'rev-parse', '--short=8', '--verify', 'HEAD')
        def gitBranchName = execAndGetStdout('git', 'rev-parse', '--abbrev-ref', 'HEAD')
        def gitStatus = execAndGetStdout('git', 'status', '--porcelain')

        if(gitCommitId) {
            def commitIdLabel = 'Git commit id'
            bck.value commitIdLabel, gitCommitId
            bck.link 'Git commit id build scans', customValueSearchUrl(api, [(commitIdLabel): gitCommitId])
        }
        if (gitBranchName) {
            bck.tag gitBranchName
            bck.value 'Git branch', gitBranchName
        }
        if (gitStatus) {
            bck.tag 'Dirty'
            bck.value 'Git status', gitStatus
        }
    }
}

void addCiMetadata(def api) {
    // Jenkins
    if (System.getenv('BUILD_URL')) {
        api.link 'Jenkins build', System.getenv('BUILD_URL')
    }
    if (System.getenv('BUILD_NUMBER')) {
        api.value 'CI build number', System.getenv('BUILD_NUMBER')
    }
    if (System.getenv('JOB_NAME')) {
        def jobNameLabel = 'CI job'
        def jobName = System.getenv('JOB_NAME')
        api.value jobNameLabel, jobName
        api.link 'CI job build scans', customValueSearchUrl(api, [(jobNameLabel): jobName])
    }
    if (System.getenv('STAGE_NAME')) {
        def stageNameLabel = 'CI stage'
        def stageName = System.getenv('STAGE_NAME')
        api.value stageNameLabel, stageName
        api.link 'CI stage build scans', customValueSearchUrl(api, [(stageNameLabel): stageName])
    }
    
    // Team City
    if (System.getenv('CI_BUILD_URL')) {
        api.link 'TeamCity build', System.getenv('CI_BUILD_URL')
    }

    // Circle CI
    if (System.getenv('CIRCLE_BUILD_URL')) {
        api.link 'CircleCI build', System.getenv('CIRCLE_BUILD_URL')
    }

    // Bamboo
    if (System.getenv('bamboo.resultsUrl')) {
        api.link 'Bamboo build', System.getenv('bamboo.resultsUrl')
    }
}

boolean isCi() {
    System.getenv('BUILD_URL') ||        // Jenkins
    System.getenv('CI_BUILD_URL') ||     // TeamCity
    System.getenv('CIRCLE_BUILD_URL') || // CircleCI
    System.getenv('bamboo.resultsUrl')   // Bamboo
}

String execAndGetStdout(String... args) {
    def exec = args.toList().execute()
    exec.waitFor()
    return exec.text.trim()
}

String customValueSearchUrl(def api, Map<String, String> search) {
    def query = search.collect { name, value ->
        "search.names=${URLEncoder.encode(name, 'UTF-8')}&search.values=${URLEncoder.encode(value, 'UTF-8')}"
    }.join('&')

    return "${api.server}/scans?$query"
}