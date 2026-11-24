resource "aws_route53_record" "roboshop" {
  count = 3
  zone_id = var.zone_id
  name    = "${var.instances_names[count.index]}.${var.domain_name}" # mongodb.devopsmegham.fun
  type    = "A"
  ttl     = 2
  records = [aws_instance.ec2-server[count.index].private_ip]
  allow_overwrite = true # it will write the old records address with new address if there are any
}
