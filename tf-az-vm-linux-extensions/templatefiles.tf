data "template_file" "disk_encryption" {
  template = file(join("", [var.template_file_path, "/files/disk-encryption-config.json"]))
  vars = {
    EncryptionOperation = jsonencode(var.disk_encryption_provider_config["encryption_operation"])
    KeyVaultURL         = jsonencode(var.disk_encryption_config.key_vault_url)
    KeyVaultResourceId  = jsonencode(var.disk_encryption_config.key_vault_resource_id)
    KeyEncryptionKeyURL = jsonencode(var.disk_encryption_config.key_encryption_key_url)
  }
}

data "template_file" "rapid7_json" {
  template = file(join("", [var.template_file_path, "/files/rapid7.json"]))
  vars = {
    configzip = jsonencode(filebase64(join("", [var.template_file_path, "/files/rapid7-config.zip"])))
  }
}

data "template_file" "diagnostic_settings" {
  template = file(join("", [var.template_file_path, "/files/linux.json"]))
  vars = {
    storageAccountName = jsonencode(var.diagnostic_agent_config.metrics_storage_account)
    vm_id              = jsonencode(var.virtual_machine_ids[0])
  }
}

data "template_file" "diagnostic_protected_settings" {
  template = file(join("", [var.template_file_path, "/files/storage-account-config.json"]))
  vars = {
    storageAccountName     = jsonencode(var.diagnostic_agent_config.metrics_storage_account)
    storageAccountSasToken = jsonencode(var.diagnostic_agent_config.sas_token)
  }
}

data "template_file" "symantec_protected_settings" {
  template = file(join("", [var.template_file_path, "/files/symantec-protected-settings.json"]))
  vars = {
    storageAccountName  = jsonencode(var.symantec_agent_config.storage_account_name)
    storageAccountKey   = jsonencode(var.symantec_agent_config.storage_account_key)
  }
}

data "template_file" "symantec_settings" {
  template = file(join("", [var.template_file_path, "/files/symantec-settings.json"]))
  vars = {
    fileUris = jsonencode(
      [for file in var.symantec_files : 
        "${join("", [var.symantec_agent_config.primary_blob_endpoint, file])}"]
    )
    commandtoexecute  = jsonencode(var.symantec_command_to_execute)
  }
}