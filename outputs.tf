output "Bucket_name" {
    value = aws_s3_bucket.main_bucket.id
    description="the bucket name"

} 

output "error_id"{
    value=aws_s3_object.error_file.id
    description="the key of the error file on the bucket"

}
output "index_id"{
    value=aws_s3_object.index_file.id
    description="the key of the index file on the bucket"
    }
output "website_endpoint"{
    value=aws_s3_bucket_website_configuration.example.website_endpoint
    description="The website endpoint on the bucket"
}