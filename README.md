# downstream-demo-opentofu
Deploy downstream clusters to a Rancher instance using terraform.

## Select providers
Comment out the provider you do or don't want in top level  `main.tf`

## Select clusters
Switch around active/inactive clusters as needed in modules

## Run terraform
1. Generate a rancher access token from the UI
1. Update terraform.tfvars at the toplevel

    * prefix
    * ssh_key_file_name
    * rancher_subdomain
    * rancher_access_token
1. `terraform apply --auto-approve`