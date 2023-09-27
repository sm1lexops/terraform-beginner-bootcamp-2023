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

