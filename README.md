# PME DevSecOps Toolkit

Este repositório descreve como implementar DevSecOps em pequenas e médias empresas (PMEs) recorrendo sobretudo a ferramentas open-source ou planos gratuitos, desde a formação dos colaboradores até ao planeamento e monitorização das aplicações desenvolvidas.


## Estrutura do Repositório

```
README.md
KPIs/
  PKIs_List.xlsx         # Ficheiro Excel com a lista de KPIs/PKIs
  README.md              # Informação sobre KPIs/PKIs
Material_Treinamento/
  DesenvolvimentoSeguro_tecnico.pptx  # Material de formação em desenvolvimento seguro (técnico)
  DevSecOps_tecnico.pptx               # Material de formação em DevSecOps (técnico)
  README.md                            # Informação sobre os materiais de formação
poc_devsecops/
  docker-compose.yml     # Configuração Docker Compose para PoC
  Dockerfile             # Dockerfile para o ambiente PoC
  local/                 # Ficheiros de ambiente local (detalhes dentro da pasta)
  README.md              # Informação sobre a PoC
  requirements.txt       # Dependências Python para a PoC
  app/
    manage.py            # Script de gestão do Django
    myapp/               # Aplicação Django com modelos, vistas, templates, etc.
    myproject/           # Definições e configuração do projeto Django
    static/              # Ficheiros estáticos (CSS, JS, etc.)
terraform/
  docker_run.sh.tpl      # Script template para correr Docker
  main.tf                # Configuração principal do Terraform
  outputs.tf             # Outputs do Terraform
  provider.tf            # Configuração do provider do Terraform
  README.md              # Informação sobre a configuração do Terraform
  terraform.tfstate*     # Ficheiros de estado do Terraform
  terraform.tfvars       # Variáveis do Terraform
  variables.tf           # Definição de variáveis do Terraform
```

### Descrição das Pastas

- **KPIs/**: Contém documentação e ficheiros relacionados com os Indicadores Chave de Desempenho (KPIs) e Indicadores Chave de Processo (PKIs) para DevSecOps.
- **Material_Treinamento/**: Materiais de formação e apresentações sobre desenvolvimento seguro e melhores práticas de DevSecOps.
- **poc_devsecops/**: Prova de Conceito (PoC) para implementação de DevSecOps, incluindo uma aplicação Django, configuração Docker, e ficheiros relacionados.
- **terraform/**: Scripts e configuração de Infraestrutura como Código (IaC) para provisionamento de ambientes usando Terraform.

Para mais detalhes, consulte os ficheiros README dentro de cada pasta.
