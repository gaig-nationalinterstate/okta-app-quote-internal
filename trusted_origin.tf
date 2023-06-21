resource "okta_trusted_origin" "quote" {
  name   = "Quote - ${var.env}"
  origin = "https://${var.url}.natl.com"
  scopes = ["CORS", "REDIRECT"]
}