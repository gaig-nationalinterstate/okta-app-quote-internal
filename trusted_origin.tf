resource "okta_trusted_origin" "quote" {
  name   = var.env == "prd" ? "Quote National Interstate" : "Quote National Interstate ${var.env}"
  origin = "https://${var.audience}"
  scopes = ["CORS", "REDIRECT"]
}