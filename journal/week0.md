# Week 0 — Prerequisite Week

- [Prerequisites](#prerequisite-technologies)

- [Semantic Versioning](#semantic-versioning-200)

- [Refacroting Terraform](#refactoring-terraform-cli)

## Prerequisite Technologies 

> **The bootcamper is required to register an account with the following online cloud services:**

1. GitHub Account
GitHub will be the VCS we use to store our application code. 
We will be working from an existing minimal application web-application that is divided into a backend and frontend.

2. Gitpod Account 
Gitpod will be used as our Cloud Developer Environment (CDE). 
We will be working in Gitpod to write code as we integrate cloud services into the provided web applications.
Primary instruction will be conducted within Gitpod
Gitpod has a generous free-tier, which we’ll be using.

3. Terraform Cloud Account
We will be using Terraform Cloud to remotely store our statefiles. 
This will be useful for team collaboration and will make you comfortable with how enterprise organizations leverage locking to prevent multiple simultaneous changes from occurring in an environment. 

4. AWS Account
Amazon Web Services (AWS) will be our Cloud Service Provider (CSPs)
AWS has a free-tier, but requires a credit card to activate your account.
This is a Bring-Your-Own-Account (BYOA) cloud project bootcamp.
There is a risk of spending while we are performing this bootcamp.
You will find these potential costs under each respective week.
We will attempt to stay with free-tier services, and provide guidance to watch out for unexpected spending.

## Semantic Versioning 2.0.0

> Link to [semver.org](https://semver.org)

Given a version number **MAJOR.MINOR.PATCH**, increment the:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Refactoring Terraform CLI

> Fix `.gitpod.yml`

```yml
tasks:
  - name: terraform
    before: |
      sudo apt-get update && sudo apt-get install -y gnupg software-properties-common wget
      wget -O- https://apt.releases.hashicorp.com/gpg | \
      gpg --dearmor | \
      sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
      sudo apt-get update && sudo apt-get install terraform
  - name: aws-cli
    env:
      AWS_CLI_AUTO_PROMPT: on-partial
    before: |
      cd /workspace
      curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
      unzip awscliv2.zip
      sudo ./aws/install
      cd $THEIA_WORKSPACE_ROOT
vscode:
  extensions:
    - amazonwebservices.aws-toolkit-vscode
    - hashicorp.terraform
```

- Change `init` to `before`

- Refactoring terraform CLI, link to tutorial [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)