# Azure Infrastructure Setup with Terraform

Follow these steps to deploy your Django infrastructure on Azure:

All needed variables should be added to terraform.tfvars file, which is not included in the repository for security reasons. You can create a `terraform.tfvars` file in the `terraform` directory with the following variables:

1. **Login to Azure**
   ```sh
   az login
   ```
   Set the correct subscription, note it should match the one in `variables.tf`:
   ```sh
   az account set --subscription "<your-subscription-id>"
   ```

2. **Initialize Terraform**
   ```sh
   cd terraform
   terraform init
   ```

3. **Review the Terraform Plan**
   ```sh
   terraform plan
   ```

4. **Apply the Terraform Plan**
   ```sh
   terraform apply
   ```
   
5. Create a service principal
   ```sh
   az ad sp create-for-rbac --name "poc_isep" --role contributor --scopes /subscriptions/"<your-subscription-id>"
   ```
   
6. Add the django key to the secrets in Azure Key Vault:
   Note that this can be done manually via the UI.
   ```sh
   az keyvault secret set --vault-name pockeyvaultisep --name django-secret-key --value "<your-django-secret-key>"
   ```

7. **Get the Public IP**
   - After apply, Terraform will output the public IP of your VM. Use this to access your deployed Django app.

8. **(Optional) SSH Access**
   - If you need to SSH into the VM, use the admin username and the SSH key you specified in `variables.tf`:
   ```sh
   ssh azureuser@<public-ip>
   ```
