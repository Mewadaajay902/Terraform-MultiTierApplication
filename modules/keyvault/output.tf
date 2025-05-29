output "keyvalut_Secret_Identifier" {
  value = azurerm_key_vault_certificate.kv_certificate.secret_id
}

output "user_assigned_identity_id" {
    value = azurerm_user_assigned_identity.base.id

}