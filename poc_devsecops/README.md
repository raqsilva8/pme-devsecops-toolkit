# poc_devsecops

1. Create a free account in [Snyk](https://snyk.io/)
2. Get the Auth Token from Snyk, you can find it [here](https://app.snyk.io/account)
3. Add the token to your GitHub secrets 
   1. Go to your GitHub repository in a web browser 
   2. Click on the "Settings" tab near the top of the page
   3. In the left sidebar, click on  Settings > Secrets and variables > Actions
   4. On the Secrets page, click the "New repository secret" button 
   5. In the "Name" field, enter `SNYK_TOKEN` (exactly as written, case-sensitive)
   6. In the "Value" field, paste your Snyk API token that you copied in Step 1 
   7. Click "Add secret" to save
4. Add the Azure credentials to your GitHub secrets, see terraform/README.md for details.
   - `AZURE_CLIENT_ID`: The appId from the service principal output
   - `AZURE_CLIENT_SECRET`: The password from the service principal output
   - `AZURE_TENANT_ID`: The tenant from the service principal output
   - `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID
5. A Service Principal is needed to login to azure when running the GitHub Actions workflow. You can create it with the following command:
   ```sh
   az ad sp create-for-rbac --name "poc_isep" --role contributor --scopes /subscriptions/"<your-subscription-id>"
   ```
6. ACR details to push the docker image to Azure Container Registry:
   - `ACR_LOGIN_SERVER`: The login server URL for your ACR (e.g., `myregistry.azurecr.io`)
   - `ACR_USERNAME`: The username for your ACR (az acr credential show --name <your-acr-name> --query "username" --output tsv)
   - `ACR_PASSWORD`: The password for your ACR (az acr credential show --name <your-acr-name> --query "passwords[0].value" --output tsv)