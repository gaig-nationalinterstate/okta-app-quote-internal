resource "okta_auth_server_policy" "quote-policy" {
  auth_server_id   = okta_auth_server.quote-auth-server.id
  client_whitelist = [okta_app_oauth.quote.id]
  description      = "Quote Access Policy - ${var.env}"
  name             = "Quote Access Policy - ${var.env}"
  priority         = "1"
  status           = "ACTIVE"
}

# Policy Rule
resource "okta_auth_server_policy_rule" "quote-rule" {
  auth_server_id       = okta_auth_server.quote-auth-server.id
  policy_id            = okta_auth_server_policy.quote-policy.id
  status               = "ACTIVE"
  name                 = "Quote Default Policy Rule - ${var.env}"
  priority             = 1
  group_whitelist      = ["EVERYONE"]
  grant_type_whitelist = ["authorization_code", "implicit"]
  scope_whitelist      = ["*"]
}