# Terrahouse Module

## How it Works

At root project `main.tf`

* Define `module` with env var 

```sh
module "terratowns_missingo" {
  source          = "./modules/terrahouse"

  public_path     = var.missingo.public_path
  content_version = var.missingo.content_version 
  user_uuid       = var.user_uuid
}
```

* Define resources 

```tf
resource "terratowns_home" "missingo" {
  name = "==== Rick & Morty. Who Are They??? ===="
  description = <<EOF
    "Rick and Morty" is an American animated science fiction sitcom created by Justin Roiland and Dan Harmon. The show first premiered in 2013 and has gained a dedicated fan following. 
    The series primarily focuses on the adventures of its two main characters, Rick Sanchez and Morty Smith.
    Rick Sanchez is an eccentric, brilliant, and often morally ambiguous scientist. He's known for his disregard for conventional rules and ethics. 
    Morty Smith, on the other hand, is Rick's easily influenced and somewhat naive grandson. Morty often finds himself reluctantly accompanying Rick on various interdimensional and extraterrestrial adventures.
  EOF

  domain_name = module.terratowns_missingo.cloudfront_url
  town = "missingo"
  content_version = 1
}
```