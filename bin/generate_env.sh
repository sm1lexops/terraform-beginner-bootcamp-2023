#! /usr/bin/env zsh
set -e

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL1="Error: TF_TOKEN env var for terraform cloud is not set."
LABEL2="credentials.tfrc.json and terraform.tfvars with ENV VAR was created."
LABEL3="ENV AWS_ACCESS_KEY_ID is not set" 
LABEL4="ENV AWS_SECRET_ACCESS_KEY is not set" 
CRED_PATH="/Users/alexsmirnov/.terraform.d"
CRED_TARGET="credentials.tfrc.json"
EU_REGION="eu-central-1"
US_REGION="us-east-1"

# Check ENV VAR 
if [ -z "$TF_TOKEN" ]; then
  printf "${CYAN}==== ${LABEL1}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  printf "${CYAN}==== ${LABEL3}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  exit 1
fi  

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  printf "${CYAN}==== ${LABEL4}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  exit 1
fi  
# Create credentials.tfrc.json for terraform cloud auth
cat > $CRED_TARGET << EOF
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TF_TOKEN"
    }
  }
}
EOF

cat > terraform.tfvars << EOF
aws_secret_key = "$AWS_SECRET_ACCESS_KEY"
aws_access_key = "$AWS_ACCESS_KEY_ID"
aws_europe = "$EU_REGION"
aws_usa = "$US_REGION"
EOF

printf "${CYAN}==== ${LABEL2}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"