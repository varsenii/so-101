#!/bin/bash
set -e

REPO_ID="$1"
MODEL_PATH="$2"

if [ -z "$REPO_ID" ] || [ -z "$MODEL_PATH" ]; then
    echo "Usage: $0 <repo-id> <model-path>"
    exit 1
fi

source common/config.sh
source common/huggingface.sh

HF_USER=$(get_huggingface_username)


echo "Uploading model:"
echo "  Local path: $MODEL_PATH"
echo "  Repo id:    ${HF_USER}/${REPO_ID}"

hf upload \
  "${HF_USER}/${REPO_ID}" \
  "$MODEL_PATH" \
  --repo-type model \
