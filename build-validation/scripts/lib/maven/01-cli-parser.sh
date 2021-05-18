#!/usr/bin/env bash
# shellcheck disable=SC2034  # It is common for variables in this auto-generated file to go unused
# Created by argbash-init v2.10.0
# ARG_HELP([This function is overridden later on.])
# ARG_VERSION([print_version],[v],[version],[])
# ARGBASH_WRAP([common])
# ARGBASH_SET_INDENT([  ])
# ARGBASH_PREPARE()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.10.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info


die()
{
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}


begins_with_short_option()
{
  local first_option all_short_options='hvbsrpiag'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_git_branch=
_arg_gradle_enterprise_server=
_arg_git_repo=
_arg_project_dir=
_arg_interactive="off"
_arg_debug="off"
_arg_args=
_arg_goals=


print_help()
{
  printf '%s\n' "This function is overridden later on."
  printf 'Usage: %s [-h|--help] [-v|--version] [-b|--git-branch <arg>] [-s|--gradle-enterprise-server <arg>] [-r|--git-repo <arg>] [-p|--project-dir <arg>] [-i|--(no-)interactive] [--(no-)debug] [-a|--args <arg>] [-g|--goals <arg>]\n' "$0"
  printf '\t%s\n' "-h, --help: Prints help"
  printf '\t%s\n' "-v, --version: Prints version"
}


parse_commandline()
{
  while test $# -gt 0
  do
    _key="$1"
    case "$_key" in
      -h|--help)
        print_help
        exit 0
        ;;
      -h*)
        print_help
        exit 0
        ;;
      -v|--version)
        print_version
        exit 0
        ;;
      -v*)
        print_version
        exit 0
        ;;
      -b|--git-branch)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_git_branch="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --git-branch=*)
        _arg_git_branch="${_key##--git-branch=}"
        _args_common_opt+=("$_key")
        ;;
      -b*)
        _arg_git_branch="${_key##-b}"
        _args_common_opt+=("$_key")
        ;;
      -s|--gradle-enterprise-server)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_gradle_enterprise_server="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --gradle-enterprise-server=*)
        _arg_gradle_enterprise_server="${_key##--gradle-enterprise-server=}"
        _args_common_opt+=("$_key")
        ;;
      -s*)
        _arg_gradle_enterprise_server="${_key##-s}"
        _args_common_opt+=("$_key")
        ;;
      -r|--git-repo)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_git_repo="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --git-repo=*)
        _arg_git_repo="${_key##--git-repo=}"
        _args_common_opt+=("$_key")
        ;;
      -r*)
        _arg_git_repo="${_key##-r}"
        _args_common_opt+=("$_key")
        ;;
      -p|--project-dir)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_project_dir="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --project-dir=*)
        _arg_project_dir="${_key##--project-dir=}"
        _args_common_opt+=("$_key")
        ;;
      -p*)
        _arg_project_dir="${_key##-p}"
        _args_common_opt+=("$_key")
        ;;
      -i|--no-interactive|--interactive)
        _arg_interactive="on"
        _args_common_opt+=("${_key}")
        test "${1:0:5}" = "--no-" && _arg_interactive="off"
        ;;
      -i*)
        _arg_interactive="on"
        _next="${_key##-i}"
        if test -n "$_next" -a "$_next" != "$_key"
        then
          { begins_with_short_option "$_next" && shift && set -- "-i" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
        fi
        _args_common_opt+=("${_key}")
        ;;
      --no-debug|--debug)
        _arg_debug="on"
        _args_common_opt+=("${_key}")
        test "${1:0:5}" = "--no-" && _arg_debug="off"
        ;;
      -a|--args)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_args="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --args=*)
        _arg_args="${_key##--args=}"
        _args_common_opt+=("$_key")
        ;;
      -a*)
        _arg_args="${_key##-a}"
        _args_common_opt+=("$_key")
        ;;
      -g|--goals)
        test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
        _arg_goals="$2"
        _args_common_opt+=("${_key}" "$2")
        shift
        ;;
      --goals=*)
        _arg_goals="${_key##--goals=}"
        _args_common_opt+=("$_key")
        ;;
      -g*)
        _arg_goals="${_key##-g}"
        _args_common_opt+=("$_key")
        ;;
      *)
        _PRINT_HELP=yes die "FATAL ERROR: Got an unexpected argument '$1'" 1
        ;;
    esac
    shift
  done
}


# OTHER STUFF GENERATED BY Argbash
_args_common=("${_args_common_opt[@]}" "${_args_common_pos[@]}")

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash
function print_help() {
  print_version
  echo "Assists in validating that a Maven build is optimized for local build caching when invoked from the same location."
  print_bl
  print_script_usage
  print_option_usage -i
  print_option_usage -r
  print_option_usage -b
  print_option_usage -p
  print_option_usage -g
  print_option_usage -a
  print_option_usage -s
  print_option_usage -v
  print_option_usage -h
}
# ] <-- needed because of Argbash
