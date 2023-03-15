resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.kittens.zone_id
  name    = "kittens.ibrahimu.net"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
data "aws_route53_zone" "kittens" {
  name         = "ibrahimu.net"
}