output "public_ip" {
  value = module.ec2.public_ip
}

output "app_url" {
  value = "http://${module.ec2.public_ip}/health"
}