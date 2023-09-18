# init the provider
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}
provider "aws" {
  # Configuration options
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}
# create bucket that will host the necessary files 
resource "aws_s3_bucket" "main_bucket" {
  bucket = "fwd-project1-test.hashicorp.com"
  acl    = "public-read"
#   policy = file("policy.json") deprecaretd

#   website {
#     index_document = "index.html"
#     error_document = "error.html"

# #     routing_rules = <<EOF
# # [{
# #     "Condition": {
# #         "KeyPrefixEquals": "docs/"
# #     },
# #     "Redirect": {
# #         "ReplaceKeyPrefixWith": "documents/"
# #     }
# # }]
# # EOF
#   }
}
# upload the object to the bucket then configure the website 
resource "aws_s3_object" "error_file" {
  bucket = aws_s3_bucket.main_bucket
  key    = "error.html"
  source = "./error.html"
#   etag = filemd5("path/to/file") md5 ta2riban parity check
}
resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.main_bucket
  key    = "index.html"
  source = "./index.html"
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.main_bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

#   routing_rule {
#     condition {
#       key_prefix_equals = "docs/"
#     }
#     redirect {
#       replace_key_prefix_with = "documents/"
#     }
#   }
}
# Bring it to Edge location
# resource "aws_cloudfront_cache_policy" "example" {
#   name        = "example-policy"
#   comment     = "test comment"
#   default_ttl = 50
#   max_ttl     = 100
#   min_ttl     = 1
#   parameters_in_cache_key_and_forwarded_to_origin {
#     cookies_config {
#       cookie_behavior = "whitelist"
#       cookies {
#         items = ["example"]
#       }
#     }
#     headers_config {
#       header_behavior = "whitelist"
#       headers {
#         items = ["example"]
#       }
#     }
#     query_strings_config {
#       query_string_behavior = "whitelist"
#       query_strings {
#         items = ["example"]
#       }
#     }
#   }
# }