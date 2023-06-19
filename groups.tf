resource "okta_group" "Quote_Underwriters" {
  name = "Quote_Underwriters_${var.env}"
}

resource "okta_group" "Quote_Agents" {
  name = "Quote_Agents_${var.env}"
}