# Week 0 — Prerequisite Week

- [Prerequisites](#prerequisite-technologies)

- [Semantic Versioning](#semantic-versioning-200)

- [Refacroting Terraform](#refactoring-terraform-cli)

- [Terraform Files and Structure](#terraform-files-and-structure)

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

## Terraform Files and Structure

> Structure may vary depending on the projects, but some best practice project structure you can see below

* We can devide our structure **by services** or **by components**

* Terraform sources their providers and modules in [registry.terraform.io](https://registry.terraform.io/)

```vbnet
project-root/
│
├── main.tf
├── variables.tf
├── outputs.tf
│
├── providers.tf (Optional)
├── terraform.tfvars (Optional)
├── terraform.tfstate (Do not commit to version control)
├── terraform.tfstate.backup (Do not commit to version control)
│
├── modules/
│   ├── module1/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── README.md (Optional)
│   │   └── examples/ (Optional)
│   │       ├── example1/
│   │           ├── main.tf
│   │           ├── variables.tf
│   │           └── outputs.tf
│   │
│   ├── module2/
│   │   ├── ...
│   │
│   └── ...
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── terraform.tfvars (Environment-specific)
│   │
│   ├── staging/
│   │   ├── ...
│   │
│   ├── prod/
│   │   ├── ...
│   │
│   └── ...
│
└── .gitignore
```

1. `main.tf` - define the resources to be created in the target.

2. `provider.tf` - containing the terraform block, provider configuration and aliases.

3. `variables.tf` - containing the variables declarations used in the resource blocks.

4. `output.tf` - containing the outputs generated on successful completion of **apply** operation.

5. `*.tfvars` - containing the env-specific default values of variables.

> All files above can be using with `json` extensions, for example `main.tf.json`

### Automatically Managed Files and Directories

* When we run `terraform init`, terraform identifies required providers and downloads the appropriate plugin binary from the registry, this `go` binary downloaded in the `/.terraform` directory located at the root of the project.

* Also creats a **`.terraform.lock.hcl`** file, with maintains the hashes of the downloaded binary for consistency.

* Then we can run `terraform plan` command wich analyzes your current infrastructure and configurations in your `*.tf` files to determine what changes are needed to reach the desired state in your configuration. Terraform generates `*.tfplan` file describing this changes in detail.

* Once the project is initialized we using `terraform apply` (this command includes `plan`) for applying/changing/destroying resources as planned in your `*.tf` files.

6. **`terraform.tfstate`** and **`terraform.tfstate.backup`**: These files store the Terraform state. Do not commit them to version control; use remote state storage like AWS S3 and DynamoDB.

7. **`.terraform.lock.hcl`** The primary purpose of .terraform.lock.hcl is to lock the versions of provider plugins and their respective dependencies (such as modules) used in your Terraform configuration. This ensures that your Terraform configurations consistently use the same versions of providers and modules, reducing the risk of unexpected behavior or breaking changes caused by automatic updates. Terraform uses the information in .terraform.lock.hcl to download the correct provider versions and their dependencies. This ensures that you have all the necessary plugins and versions available locally for your configuration.

## Terraform Random

> In this small example project we try generate random 16*digits name for our `bucket_name`

> Create `main.tf` and define **random** provider

```tf
terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "backet_name" {
    length      = 16
    special     = false
}
output "random_backet_name_string" {
    value = random_string.backet_name.id
}
```

> Run `terraform init` and `terraform plan`, you should see success downloaded binary and planned changes in your project

```sh
Terraform will perform the following actions:

  # random_string.backet_name will be created
  + resource "random_string" "backet_name" {
      + id          = (known after apply)
      + length      = 16
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = true
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + random_backet_name_string = (known after apply)
```

> Run `terraform apply`, you'll see successfully added 1 resource and outputs for out **backet_name**

```sh
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

random_backet_name_string = "saUWC1GbuYq4KvPc"
```

## Terraform AWS S3 Provider

* To learn how to create TF providers and resources at this example we create aws s3 bucket with random name

> Add to [`main.tf`](https://github.com/sm1lexops/terraform-beginner-bootcamp-2023/blob/week-0/main.tf)

```tf
'''''
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
provider "aws" {
  
}
    ''''
resource "aws_s3_bucket" "my_random_s3_bucket" {
  bucket = "my-random-${random_string.bucket_name.id}"
}
resource "random_string" "bucket_name" {
  length  = 16
  special = false
  upper   = false
}

```
