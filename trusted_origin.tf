resource "okta_trusted_origin" "quote" {
  name   = "Quote - ${var.env}"
  origin = "https://${var.audience}"
  scopes = ["CORS", "REDIRECT"]
}