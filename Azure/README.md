# [Azure](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)

 ```
sudo apt-get install apt-transport-https lsb-release software-properties-common dirmngr -y
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key --keyring /etc/apt/trusted.gpg.d/Microsoft.gpg adv \
     --keyserver packages.microsoft.com \
     --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF
 ```
## add autocomplete to azuer cli
- Get the completions for bash from the Azure CLI git repo and store this file somewhere your zsh startup script can find it: https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion

- Enable bash autocompletions in zsh (if it's not enabled already) [1]: 
```autoload -U +X bashcompinit && bashcompinit```

- ```source /path/to/az.completion``` (you will likely want this in your startup file for zsh also).

## azure cli

- az account list-locations
- az aks create -g k-li-gp -n jersey-mike --ssh-key-value /home/simon/.ssh/id_rsa.pub
