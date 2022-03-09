#!/bin/sh

root="$(pwd)/_jenkins_git_credential_helper"

mkdir -p "$root"

create_unix_askpass() {
    auth_script="$root/ask_pass.sh"

    echo "#!/bin/sh
case \$1 in
    Username*) echo $1 ;;
    Password*) echo $2 ;;
esac
" >"$auth_script"

    # make executable
    chmod +x "$auth_script"
}

create_windows_askpass() {
    auth_script="$root/ask_pass.bat"

    echo "@ECHO OFF
SET ARG=%~1
IF %ARG:~0,8%==Username (ECHO $1)
IF %ARG:~0,8%==Password (ECHO $2)
" >"$auth_script"
}

if [ $# -eq 2 ]; then
    CRED_USERNAME=$1
    CRED_PASSWORD=$2
elif [ "$CRED_USERNAME" = "" ]; then
    # use jenkins default env
    CRED_USERNAME=$USERNAME
    CRED_PASSWORD=$PASSWORD
fi

# platform check
case "$(git --version)" in
*windows*)
    create_windows_askpass "$CRED_USERNAME" "$CRED_PASSWORD"
    ;;
*)
    create_unix_askpass "$CRED_USERNAME" "$CRED_PASSWORD"
    ;;
esac

export GIT_ASKPASS="$auth_script"

# rm secret
trap 'rm $auth_script' EXIT
