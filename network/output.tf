
output "vpc_id" {
  description = "The ID of the JFrog VPC"
  value       = aws_vpc.jfrog_vpc.id
}

output "vpc_id_print" {
  description = "A list of JFrog VPC IDs (printed)"
  value       = aws_vpc.jfrog_vpc[*].id
}

output "pub_subnet_id" {
  description = "A list of IDs for the public subnet"
  value       = aws_subnet.public[*].id
}

output "pvt_subnet_id" {
  description = "A list of IDs for the private subnet"
  value       = aws_subnet.private[*].id
}