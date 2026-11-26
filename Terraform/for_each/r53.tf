resource "aws_route53_record" "roboshop" {
  
  for_each = aws_instance.ec2-server
  zone_id = var.zone_id
  name    = "${each.key}.${var.domain_name}" # mongodb.devopsmegham.fun
  type    = "A"
  ttl     = 2
  records = [each.value.private_ip]
  allow_overwrite = true # it will write the old records address with new address if there are any
}
