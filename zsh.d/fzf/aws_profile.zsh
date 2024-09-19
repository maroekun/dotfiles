# WHAT: set AWS_profile via fzf select

function fzf-aws_profile() {
    local AWS_CONFIG_FILE=~/.aws/config

    if [ ! -f "${AWS_CONFIG_FILE}" ]; then
        echo "AWS config file not found: ${AWS_CONFIG_FILE}"
        return 1
    fi

    local AWS_PROFILE_LIST=$(awk '/^\[/ {print $2}' "${AWS_CONFIG_FILE}" | sed -e 's/\]//' | fzf +m)
    if [ -n "${AWS_PROFILE_LIST}" ]; then
        BUFFER="export AWS_PROFILE=${AWS_PROFILE_LIST}"
    fi

    zle accept-line
}

zle -N fzf-aws_profile
bindkey '^]^a' fzf-aws_profile

# vim: ft=bash
