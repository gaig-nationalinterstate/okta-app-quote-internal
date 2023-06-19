resource "okta_trusted_origin" "quote" {
  name   = "Quote - ${var.env}"
  origin = "https://${var.env}quote.natl.com"
  scopes = ["CORS", "REDIRECT"]
}