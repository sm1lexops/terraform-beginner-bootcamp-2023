output "random_bucket_name_string" {
  value = random_string.bucket_name.id
}
output "my_random_s3_bucket" {
  value = aws_s3_bucket.my_random_s3_bucket.id
}