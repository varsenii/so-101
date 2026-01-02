#!/bin/bash

get_huggingface_username() {
    local hf_user
    hf_user=$(
        hf auth whoami \
        | sed -E 's/\x1B\[[0-9;]*[mK]//g' \
        | awk '{print $2}'
    )

    echo "$hf_user"
}