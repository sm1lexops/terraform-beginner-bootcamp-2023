# Week 1 — Terraform Beginner Bootcamp 2023

- [Terraform Aliases](#terraform-aliases)

- []()

- []()

- []()

- []()

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

## Terraform Import and Configurations Drift

* First we need to delete our `random` provider and resources

* Then we need to change name of the bucket, personaly I added to my bucket name `user_uuid`



