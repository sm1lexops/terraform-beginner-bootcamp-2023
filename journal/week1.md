# Week 1 — Terraform Beginner Bootcamp 2023

- [Week 1 — Terraform Beginner Bootcamp 2023](#week-1---terraform-beginner-bootcamp-2023)

  * [Terraform Aliases](#terraform-aliases)
  
  * [Terraform Variables, Import and Configurations Drift](#terraform-variables--import-and-configurations-drift)

    + [Terraform Variables Precedence Order](#terraform-variables-precedence-order)

    + [Import](#import)

    + [Configurations Drift](#configurations-drift)

## Terraform Aliases

> To made execute terraform commands easier, we should add aliases to our `~/.bashrc` or `~/.zshrc` file

```sh
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfap='terraform apply -auto-approve'
alias tfd='terraform destroy -auto-approve'
```

## Terraform Variables, Import and Configurations Drift

* First we need to delete our `random` provider and resources

* Then we need to change name of the bucket, personaly I added to my bucket name `user_uuid`


### Terraform Variables Precedence Order

> Variable precedence order:

* Environment Variables

* Variable Definitions in .tf Files

* .tfvars Files

* Command-Line Flags

* Default Values in Variable Declarations
j
Terraform evaluates variables in this order. If a variable is defined or assigned at a higher-precedence level, it will override any values set at a lower-precedence level.

For example, if you defined a variable with a default value in your .tf configuration file and then provide a different value for that variable in a .tfvars file, the value from the .tfvars file takes precedence when you run terraform apply.

### Import

The terraform import command is used in Terraform to import existing infrastructure resources into your Terraform state so that you can manage them as part of your infrastructure-as-code (IaC) setup. This command is particularly useful when you have pre-existing resources that you want to manage with Terraform. Here's a more detailed description of the terraform import command:

```sh
terraform import [options] RESOURCE_TYPE.RESOURCE_NAME ADDRESS
```

### Configurations Drift

If we don't want to change and provision resources in cloud, we should execute `terraform init`, `terraform import ...` then `terraform plan` and fix all difference between *.tf configurations and cloud resources

> Another way in TF >=1.5.0 we can use `import` block, example below for s3 bucket

[Link to Import AWS S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

```hcl
resource "aws_s3_bucket" "tf_bucket" {
  bucket = "eu-tf-bucket-${var.user_uuid}"
  provider = aws
  
  tags = {
    tf_user_uuid = var.user_uuid
    description = "Terraform Bootcamp User uuid"
  }
}
import {
  to = aws_s3_bucket.tf_bucket 
  id = "bucket_name" # in our case "eu-tf-bucket-${var.user_uuid}", the name of created AWS cloud bucket   
}
```

## Terraform Modules

> [Terraform Modules Docs](https://developer.hashicorp.com/terraform/language/modules)

### Module Sources

> The module installer supports installation from a number of different source types.

* Local paths

* Terraform Registry

* GitHub

* Bitbucket

* Generic Git, Mercurial repositories

* HTTP URLs

* S3 buckets

* GCS buckets

* Modules in Package Sub-directories

* GitHub

* Bitbucket

* Generic Git, Mercurial repositories

* HTTP URLs

* S3 buckets

GCS buckets

Modules in Package Sub-directories

### Build and use a local module

-  Terraform treats every configuration as a module. When you run terraform commands, or use Terraform Cloud or Terraform Enterprise to remotely run Terraform, the target directory containing Terraform configuration is treated as the root module.

In this tutorial, you will create a module to manage AWS S3 buckets used to host static websites.

### Module Structure

```sh
.
├── LICENSE
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

> There are also some other files to be aware of, and ensure that you don't distribute them as part of your module:

* `terraform.tfstate` and `terraform.tfstate.backup`: These files contain your Terraform state, and are how Terraform keeps track of the relationship between your configuration and the infrastructure provisioned by it.

* `.terraform`: This directory contains the modules and plugins used to provision your infrastructure. These files are specific to a specific instance of Terraform when provisioning infrastructure, not the configuration of the infrastructure defined in .tf files.

* `*.tfvars`: Since module input variables are set via arguments to the module block in your configuration, you don't need to distribute any *.tfvars files with your module, unless you are also using it as a standalone Terraform configuration.

### Create Module

> Create `modules/terrahouse` directory and all files in **Module Structrue** above

After creating these directories, your configuration's directory structure will look like this:

```sh
.
├── LICENSE
├── README.md
├── main.tf
├── modules
│   └── terrahouse
│       └── main.tf
│       └── outputs.tf
│       └── variables.tf
│       └── README.md
        └── LICENSE
├── outputs.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
└── versions.tf
```

* Module S3
 
> `main.tf`

```tf
resource "aws_s3_bucket" "this" {
  count           = var.create ? 1 : 0

  bucket          = var.bucket
  acl             = var.acl
  tags            = var.tags
}
```

> `outputs.tf`

```tf
output "aws_s3_bucket_id" {
  description   = "Name of S3 bucket"
  value         = try(aws_s3_bucket.this[0].id, "")
}
```

> `variables.tf`

```tf
variable "create" {
  description   = "Create bucket or not"
  type          = bool
  default       = true 
}

variable "bucket" {
  description   = "The name of the s3 bucket"
  type          = string
  default       = ""

  validation {
    condition     = (
      length(var.bucket) >= 10 && length(var.bucket) <= 60 && 
      can(regex("^[a-z0-9][a-z0-9-.]*[a-z0-9]$", var.bucket))
    )
    error_message = "The bucket name must be between 10 and 60 characters, start and end with a lowercase letter or number, and can contain only lowercase letters, numbers, hyphens, and dots."
  } 
}

variable "acl" {
  description   = "The ACL linked to the bucket"
  type          = string 
  default = null
}

variable "tags" {
  description   = "A map of tags asign to the bucket"
  type          = map(string) 
  default = {}
}
```

* Root 

> `main.tf`

```tf
provider "aws" {
  region      = local.region  
}

locals {
  region      = "eu-central-1"
  user_uuid   = var.user_uuid
} 
module "terrahouse" {
  source      = "./modules/terrahouse"

  bucket      = "my-bucket-c7f8d132-bac3-41e5-8cfc-f35779b73f8f"
}
```

> `outputs.tf`

```tf
output "aws_s3_bucket_name" {
  description   = "Name of S3 bucket"
  value         = module.terrahouse.aws_s3_bucket_id
}
```

> `versions.tf`

```tf
terraform {
    required_version = ">= 1.5.0"

    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = ">= 5.17.0"
      }
    }

    cloud {
    organization = "thevopz"

    workspaces {
      name = "root-tf"
    }
  }
}
```

> To instal module we can use

```sh
terraform get # install module
# or
terraform init #  initialize backends and install plugins, install and update module
```

> To update for example outputs block (when you forgot add outputs)

 This command instructs Terraform to refresh the state of your infrastructure. It will re-fetch the current state of your resources from your cloud provider (e.g., AWS, Azure) and update the local Terraform state file without making any changes to the infrastructure. This command is useful for ensuring that your Terraform state accurately reflects the real state of your resources in your cloud environment.
 
```sh
terraform apply -refresh-only 
```

## AWS S3 Static Website Hosting

1. Create s3 bucket 

2. Create s3 website hosting resource

3. Create s3 objects for `index` and `error` html static files

> [Resolved Issues Branch](https://github.com/sm1lexops/terraform-beginner-bootcamp-2023/tree/16-aws-s3-static-website-hosting)

> [Commit s3 static website hosting implemantation](https://github.com/sm1lexops/terraform-beginner-bootcamp-2023/commit/4b7a0aa3739e6da38420d6733d19dc55274cf1b3)

## Content Delivery Network

For using CDN for S3 bucket static website hosting need add next resources:

1. CloudFront Distribution

2. CloudFront Origin Access Control (OAC)

3. S3 bucket policy for OAC `jsonencode` block

4. Data aws_caller_identity for `account id`

5. content_type for s3_object

6. Before New Deploy `terraform apply` Clear cache for CDN, create invalidation `/*`

### CloudFront Distribution

> [CloudFront Distribution Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)


### CloudFront Origin Access Control

> [CloudFront OAC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control)

> [S3 bucket policy example](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html)

## Resource Versioning and Cache Invalidation

### Lifecycle of Resources

> [Lifecycle Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

For Versioning we using `terraform_data` resource [Link to Docs](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

* The terraform_data resource is useful for storing values which need to follow a manage resource lifecycle, and for triggering provisioners when there is no other logical managed resource in which to place them.

### CloudFront Cache Invalidation

We need to Add resource 

```tf
resource "terraform_data" "invalidate_cache" {
  triggers_replace = terraform_data.content_version.output

  provisioner "local-exec" {
    command = <<EOT 
    "aws cloudfront create-invalidation \
    --distribution-id ${aws_cloudfront_distribution.s3static.id} \
    --paths '/*'"
    EOT
  }
}
```

Where:

* `triggers_replace = terraform_data.content_version.output`: The triggers_replace argument specifies that this resource should be triggered by changes in the output of another data source or resource named 

* `terraform_data.content_version. When the terraform_data.content_version` data source or resource changes, it triggers this resource to be reevaluated.

* `provisioner "local-exec"`: Within this resource block, a "local-exec" provisioner is defined. A provisioner allows you to run local commands or scripts during the resource creation or update process.

* `command = <<EOT ... EOT`: The command attribute specifies the command that will be executed. It appears to be a command that uses the AWS CLI to create a cache invalidation for an AWS CloudFront distribution.

* `aws cloudfront create-invalidation`: This is the AWS CLI command used to create a cache invalidation.

* `--distribution-id ${aws_cloudfront_distribution.s3static.id}`: This part of the command specifies the CloudFront distribution's ID, which seems to be obtained from a resource named aws_cloudfront_distribution.s3static.

* `--paths '/*'`: This part of the command indicates that the invalidation should apply to all files and paths within the CloudFront distribution.

Add output `cloudfront_url` 

> module:

```tf
output "cloudfront_url" {
  value         = aws_cloudfront_distribution.s3static.domain_name 
}
```

> root:

```tf
output "cloudfront_url" {
  description = "CloudFront URL"
  value = module.terrahouse.cloudfront_url
}
```

Check all your terraform resources and static website hosting might be work `terraform apply -auto-approve`

> All changes made [Commit Cache Invalidations](https://github.com/sm1lexops/terraform-beginner-bootcamp-2023/commit/c756a0d1ddb6cf37d298c6f964c74a5d1b3483c9)

![S3 Static Website Hosting](assets/s3static.jpg)

### Assets and Data Structure

[Data Structure and Type Constraints](https://developer.hashicorp.com/terraform/language/expressions/type-constraints)

### For Each Expressions

For each allows us to enumerate over complex data types

```sh
[for s in var.list : upper(s)]
```

This is mostly useful when you are creating multiples of a cloud resource and you want to reduce the amount of repetitive terraform code.

[For Each Expressions](https://developer.hashicorp.com/terraform/language/expressions/for)

We should difine s3 object and load our image to bucket

> add to `index.html` path to our images

```html
        <h2>Today musician and Rick<h2>
            <img src="/assets/karol_szymanowskis.png" />
            <img src="/assets/rick.jpg" />
```

> add our s3 object `resource-s3.tf`

```tf
resource "aws_s3_object" "upload_assets" {
  for_each     = fileset("${path.root}/modules/terrahouse/assets/", "*.{jpg,png,gif}") 
  bucket        = aws_s3_bucket.this[0].bucket
  key           = "assets/${each.key}"
  source        = "${path.root}/modules/terrahouse/assets/${each.key}"
  etag          = filemd5("${path.root}/modules/terrahouse/assets/${each.key}")
  lifecycle {
    replace_triggered_by  = [ terraform_data.content_version.output ]    
    ignore_changes        = [ etag ]
  }
}
```

- Terraform resource block for uploading assets to an AWS S3 bucket. It uses the `for_each` meta-argument 
to iterate over a set of files that match specific patterns (jpg, png, gif) in a local directory 
and upload each of them to the S3 bucket. Let's break down what this code does:

  * `for_each`: The for_each argument is used to iterate over a set of files in the local directory specified by the fileset function. The fileset function matches files with extensions .jpg, .png, or .gif in the specified directory.

  * `bucket`: The bucket attribute is set to the name of the S3 bucket where the objects will be uploaded. It appears to reference an AWS S3 bucket resource named aws_s3_bucket.this[0].

  * `key`: The key attribute specifies the S3 object key under which the uploaded object will be stored in the bucket. It uses the each.key variable, which represents the file name of the asset. Objects are stored in a directory named "assets" within the bucket.

  * `source`: The source attribute specifies the local path of the file to be uploaded to S3. It uses the each.key variable to reference the current file from the fileset result.

  * `etag`: The etag attribute calculates the ETag (entity tag) of the local file using the filemd5 function. The ETag is used to validate the integrity of the uploaded object.