resource "okta_app_oauth" "quote" {
  auto_key_rotation          = "true"
  auto_submit_toolbar        = "false"
  grant_types                = ["authorization_code", "implicit", "refresh_token"]
  hide_ios                   = "true"
  hide_web                   = "true"
  implicit_assignment        = "false"
  issuer_mode                = "CUSTOM_URL"
  label                      = "GCAT Quote"
  login_mode                 = "DISABLED"
  login_uri                  = "https://${var.env}quote.natl.com/CommercialLines/Account/Login" # Pointing to tstaura59 etc..
  pkce_required              = "false"
  post_logout_redirect_uris  = ["https://${var.env}quote.natl.com/CommercialLines/Account/PostLogout"]
  redirect_uris              = ["https://${var.env}quote.natl.com/CommercialLines/authorization-code/callback"]
  refresh_token_leeway       = "30"
  refresh_token_rotation     = "ROTATE"
  response_types             = ["code", "id_token", "token"]
  status                     = "ACTIVE"
  token_endpoint_auth_method = "client_secret_basic"
  type                       = "web"
  user_name_template_type    = "BUILT_IN"
  wildcard_redirect          = "DISABLED"

  lifecycle {
    ignore_changes = [groups]
  }
}

# Assign groups to Calulation Engine
resource "okta_app_group_assignment" "Quote_Agents" {
  app_id            = okta_app_oauth.gcat-quote.id
  group_id          = okta_group.Quote_Agents.id
  retain_assignment = true
}

resource "okta_app_group_assignment" "Quote_Underwriters" {
  app_id            = okta_app_oauth.gcat-quote.id
  group_id          = okta_group.Quote_Underwriters.id
  retain_assignment = true
}