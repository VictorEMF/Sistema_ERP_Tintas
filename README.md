## Sistema ERP Tintas - Controle de Estoque, Produção e Financeiro

![status](https://img.shields.io/badge/status-conclu%C3%ADdo-brightgreen)
<a href="https://www.python.org/"><img src="https://img.shields.io/badge/tech-python-blue" alt="Python"/></a>
<a href="https://www.postgresql.org/"><img src="https://img.shields.io/badge/database-postgresql-blue" alt="Postgres"/></a>
<a href="https://pentaho.com/products/pentaho-data-integration/"><img src="https://img.shields.io/badge/ETL-Pentaho-red" alt="Pentaho"/></a>
<a href="https://www.microsoft.com/pt-br/power-platform/products/power-bi"><img src="https://img.shields.io/badge/visualization-power_bi-orange" alt="Power BI"/></a>


## 📋 Sobre o Projeto

Este projeto surgiu da necessidade de modernizar o sistema de controle de estoque de uma empresa do setor de pintura, que anteriormente utilizava uma planilha Excel extremamente complexa com 127 abas para gerenciar tintas e seu histórico. Cada tinta tinha sua própria aba com todo o histórico, tornando a visualização e gestão dos dados bastante complicada.

A ideia de remodelação foi criar um novo Excel com apenas 3 abas principais (menu principal, tintas e histórico), simplificando significativamente a visualização e o gerenciamento das informações.

## 🎯 Objetivos

- Simplificar a visualização e gestão de dados de estoque

- Automatizar processos manuais de cadastro e cálculos

- Criar dashboard intuitivo para análise de dados

- Reduzir erros operacionais e tempo de processamento

## ⚙️ Funcionalidades

- ✅ Sistema de cadastro de tintas

- ✅ Registro automatizado de serviços

- ✅ Cálculos automáticos de gastos e estoque

- ✅ Dashboard interativo para análise de dados

- ✅ Integração mensal com banco de dados PostgreSQL

- ✅ Processo ETL para migração e tratamento de dados

## 🛠️ Tecnologias Utilizadas


- <strong>Python</strong> - Extração e tratamento de dados

- <strong>VBA/Excel</strong>  - Automação e interface de cadastro

- <strong>Pentaho Data Integration</strong>  - Processo ETL

- <strong>PostgreSQL</strong>  - Banco de dados
  
- <strong>Power BI</strong>  - Visualização e analytics

## 📊 Metodologia de Desenvolvimento


## Extração e Tratamento de Dados

O método utilizado para extrair os dados foi o Python. Porém, mesmo após a extração, os dados precisavam ser tratados, já que do jeito que ficaram inicialmente, nem mesmo ferramentas de ETL como o Pentaho Data Integration (PDI) conseguiam compreendê-los.

Utilizando Python novamente, foi feito um segundo tratamento para deixar os dados mais fáceis de serem processados. Em seguida, utilizamos o Pentaho para carregar esses dados em bancos de dados temporários e realizar a extração final.


## Consolidação dos Dados

Após essas etapas, restaram apenas 2 arquivos: tintas.xlsx e historico.xlsx. Com esses arquivos, utilizamos o Pentaho para mesclar tudo em um único arquivo com 3 abas. Com a conclusão dessas etapas, a parte mais difícil do projeto estava finalizada e dávamos início à próxima fase: a criação da automação, que era o pedido inicial.

## Sistema de Automação

A automação foi desenvolvida para facilitar o cadastro das atividades na empresa, pois todo o trabalho de cadastro de tinta, movimentação, cálculo de gasto e atualização de estoque era feito manualmente no Excel pelo chefe e sua assistência.

Para resolver este problema, criamos:

- Um sistema de cadastro de tinta

- Um sistema para cadastrar serviços realizados

- Todos os cálculos e edições são feitos automaticamente pelo próprio VBA


## Dashboard e Visualização

O último objetivo do projeto visava a visualização dos dados da empresa. O cliente não queria mais depender do Excel para visualizar os dados - o Excel seria apenas o meio de cadastro das informações.

Para atender esta necessidade, criamos um dashboard com os dados mais relevantes e implementamos um pequeno banco de dados local utilizando PostgreSQL. Desenvolvemos também um processo ETL no Pentaho para capturar os dados do Excel e alimentar o banco de dados uma vez por mês, permitindo que o cliente se prepare com as informações atualizadas todo início de mês.

## 📸 Visualizações

## Excel Antigo vs Novo

![excel_antigo](https://github.com/VictorEMF/ERP-altapint-prototipo/blob/main/02%20-%20ARQUIVOS/IMAGEN/EXCEL%20ANTIGO.png)<br/>
Planilha original complexa com 127 abas - cada tinta tinha sua própria aba com histórico completo

<br/>

![excel_novo](https://github.com/VictorEMF/ERP-altapint-prototipo/blob/main/02%20-%20ARQUIVOS/IMAGEN/EXCEL%20NOVO.png)
Nova planilha simplificada com apenas 3 abas: menu principal, tintas e histórico

## Sistema de Cadastro

Interface do sistema de cadastro desenvolvido em VBA para automatizar o registro de tintas e serviços

## Dashboard de Análise

![dashboard](https://github.com/VictorEMF/Sistema_ERP_Tintas/blob/main/06%20-%20POWER_BI/IMAGEM/DASHBOARD%20VENDAS.png)
Dashboard criado no Power BI para visualização de dados e métricas de vendas

## 📊 Estrutura do Projeto

```
Sistema ERP Customizado - Controle de Estoque, Produção e Financeiro/
├── 01 - DOCUMENTACAO/           # Manuais e documentação
├── 02 - ARQUIVOS/               # Arquivos de base e recursos
│   ├── IMAGEM/                  # Imagens do projeto
│  
├── 03 - ETL/                    # Transformações e jobs do Pentaho
│   ├── IMAGEM/                  # Imagens das transformações
│  
├── 04 - POWER_BI/               # Dashboards e relatórios
│   ├── IMAGEM/                  # Imagens do dashboard
│  
├── 05 - PYTHON/                 # Scripts de extração e tratamento de dados
├── README.md
```

## 🔄 Fluxo do Processo

  1. Extração: Dados migrados do Excel antigo usando Python

  2. Transformação: Tratamento adicional e estruturação dos dados

  3. Carga: Processamento ETL com Pentaho para PostgreSQL

  4. Automação: Sistema VBA para cadastro e gestão contínua

  5. Visualização: Dashboard Power BI para análise mensal

## 🚀 Como Utilizar

  - Python 3.8+
    
  - PostgreSQL 12+
    
  - Pentaho Data Integration
    
  - Microsoft Excel
    
  - Power BI Desktop

## Processo de Migração

  - Executar scripts Python para extração dos dados antigos
    
  - Realizar tratamento adicional dos dados
    
  - Executar jobs do Pentaho para carga no PostgreSQL
    
  - Configurar conexão do Power BI com o banco de dados
    
  - Implementar automações VBA no Excel novo

## 📈 Resultados Obtidos

  - Redução de 127 para 3 abas no Excel

  - Automação completa dos cálculos de estoque

  - Dashboard mensal para tomada de decisão

  - Processo de atualização mensal automatizado

  - Melhoria significativa na usabilidade do sistema

## 📄 Licença

Este projeto está sob licença. Veja o arquivo LICENSE para detalhes.

## 📞 Contato

Victor Emanuel - GitHub - victoremanuel.mff@outlook.com

Link do Projeto: https://github.com/VictorEMF/Sistema_ERP_Tintas

<strong>Nota:</strong> Este projeto foi desenvolvido como protótipo para demonstração das capacidades de automação e modernização de sistemas legados, transformando um processo manual e complexo em uma solução integrada e eficiente.
