#! /usr/bin/env bash
set -e
# Regular Colors
#Black='\033[0;30m'        # Black
#Red='\033[0;31m'          # Red
#Green='\033[0;32m'        # Green
#Yellow='\033[0;33m'       # Yellow
#Blue='\033[0;34m'         # Blue
#Purple='\033[0;35m'       # Purple
#Cyan='\033[0;36m'         # Cyan
#White='\033[0;37m'        # White

CYAN='\033[1;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'
LABEL1="Error: TF_TOKEN env var for terraform cloud is not set."
LABEL1_1="Input TF_TOKEN ENV Value: "
LABEL1_2=" Value: ENV VAR TF_TOKEN is EMPTY "
LABEL2="credentials.tfrc.json and terraform.tfvars with ENV VAR was created."
LABEL3="ENV AWS_ACCESS_KEY_ID is not set" 
LABEL3_1="Input AWS_ACCESS_KEY_ID ENV Value: "
LABEL3_2=" Value: ENV VAR AWS_ACCESS_KEY_ID is EMPTY "
LABEL4="ENV AWS_SECRET_ACCESS_KEY is not set" 
LABEL4_1="Input AWS_SECRET_ACCESS_KEY ENV Value: "
LABEL4_2=" Value: ENV VAR AWS_SECRET_ACCESS_KEY is EMPTY "
LABEL5="ENV TF_USER_UUID is not set"
LABEL5_1="Input TF_USER_UUID ENV Value: "
LABEL5_2=" Value: ENV VAR TF_USER_UUID is EMPTY "
LABEL6="ENV PATH_TO_INDEX is not set"
LABEL6_1="Input PATH_TO_INDEX ENV Value: "
LABEL6_2=" Value: ENV VAR PATH_TO_INDEX is EMPTY "
LABEL7="ENV PATH_TO_ERROR is not set"
LABEL7_1="Input PATH_TO_ERROR ENV Value: "
LABEL7_2=" Value: ENV VAR PATH_TO_ERROR is EMPTY "
CRED_PATH="/Users/alexsmirnov/.terraform.d"
CRED_PATH="/Users/alexsmirnov/.terraform.d"
CRED_PATH="/Users/alexsmirnov/.terraform.d"
CRED_TARGET="credentials.tfrc.json"
EU_REGION="eu-central-1"
US_REGION="us-east-1"

# Check ENV VAR 
if [ -z "$TF_TOKEN" ]; then
  printf "${CYAN}==== ${LABEL1}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL1_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r terraform_token
fi

export TF_TOKEN=$terraform_token

if [ -z "$TF_TOKEN" ]; then
  printf "${RED}==== ${LABEL1_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  printf "${CYAN}==== ${LABEL3}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL3_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r AWS_ACCESS_KEY_ID
fi  

export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  printf "${RED}==== ${LABEL3_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
  exit 1
fi


if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  printf "${CYAN}==== ${LABEL4}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL4_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r AWS_SECRET_ACCESS_KEY
fi  

export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  printf "${RED}==== ${LABEL4_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
  exit 1
fi

if [ -z "$TF_USER_UUID" ]; then
  printf "${CYAN}==== ${LABEL5}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL5_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r TF_USER_UUID
fi  

export TF_USER_UUID=$TF_USER_UUID

if [ -z "$TF_USER_UUID" ]; then
  printf "${RED}==== ${LABEL5_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
  exit 1
fi

if [ -z "$PATH_TO_INDEX" ]; then
  printf "${CYAN}==== ${LABEL6}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL6_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r PATH_TO_INDEX
fi  

export PATH_TO_INDEX=$PATH_TO_INDEX

if [ -z "$PATH_TO_INDEX" ]; then
  printf "${RED}==== ${LABEL6_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
  exit 1
fi

if [ -z "$PATH_TO_ERROR" ]; then
  printf "${CYAN}==== ${LABEL7}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"
  printf "${GREEN}==== ${LABEL7_1}${NO_COLOR} ${GREEN}====${NO_COLOR}\n"
  read -r PATH_TO_ERROR
fi  

export PATH_TO_ERROR=$PATH_TO_ERROR

if [ -z "$PATH_TO_ERROR" ]; then
  printf "${RED}==== ${LABEL7_2}${NO_COLOR} ${RED}======${NO_COLOR}\n"
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
#aws_secret_key = "$AWS_SECRET_ACCESS_KEY"
#aws_access_key = "$AWS_ACCESS_KEY_ID"
#aws_europe = "$EU_REGION"
# aws_usa = "$US_REGION"
user_uuid = "$TF_USER_UUID"
path_to_index = "$PATH_TO_INDEX"
path_to_error = "$PATH_TO_ERROR"
EOF

printf "${CYAN}==== ${LABEL2}${NO_COLOR} ${CYAN}======${NO_COLOR}\n"