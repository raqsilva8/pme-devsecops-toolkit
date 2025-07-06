# PME DevSecOps Toolkit

Este repositório descreve como implementar DevSecOps em pequenas e médias empresas (PMEs) recorrendo sobretudo a ferramentas open-source ou planos gratuitos, desde a formação dos colaboradores até ao planeamento e monitorização das aplicações desenvolvidas.


## Estrutura do Repositório

```
README.md
KPIs/                    # Informação sobre KPIs/PKIs
Material_de_Treino/
  DesenvolvimentoSeguro_tecnico.pptx   # Material de formação em desenvolvimento seguro (técnico)
  DevSecOps_tecnico.pptx               # Material de formação em DevSecOps (técnico)
  Material_nao_tecnico.pdf             # Material expositivo para a gestão de topo das PME - a nossa proposta de DevSecOps e Cibersegurança
  README.md                            # Informação sobre os materiais de formação
poc_devsecops/           # PoC DevSecOps
  README.md              # Informação sobre a PoC
  .github/               # Configuração do GitHub Actions para CI/CD
    workflows/
      main.yml           # Workflow de Integração Contínua (CI)
terraform/               # PoC terraform
```

### Descrição das Pastas

- **KPIs/**: Contém documentação e ficheiros relacionados com os Indicadores Chave de Desempenho (KPIs) e Indicadores Chave de Processo (PKIs) para DevSecOps.
- **Material_de_Treino/**: Materiais de formação e apresentações sobre desenvolvimento seguro e melhores práticas de DevSecOps.
- **poc_devsecops/**: Prova de Conceito (PoC) para implementação de DevSecOps, incluindo uma aplicação Django, configuração Docker, e GitHub workflow.
- **terraform/**: Scripts e configuração de Infraestrutura como Código (IaC) para provisionamento de ambientes usando Terraform.

Para mais detalhes, consulte os ficheiros README dentro de cada pasta.
