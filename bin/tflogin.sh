#! /usr/bin/env zsh
set -xe

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL1="Error: TF_TOKEN env var for terraform cloud in not set."
LABEL2="credentials.tfrc.json with TF_TOKEN file created."
# Check TF_TOKEN
if [ -z "$TF_TOKEN"]; then
  printf "${CYAN}==== ${LABEL1}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  exit 1
fi

# Create credentials.tfrc.json for terraform cloud auth
cat > credentials.tfrc.json << EOF
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TF_TOKEN"
    }
  }
}
EOF

printf "${CYAN}==== ${LABEL2}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"