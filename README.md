# Teste prático DTI Digital

Este repositório contém o código-fonte de uma aplicação mobile para a criação de lembretes, desenvolvida como parte de um teste prático para a DTI Digital.

## Premissas

- Deve ser desenvolvida uma aplicação mobile utilizando Swift.
- Os lembretes devem ser ordenados em ordem cronológica.
- O sistema deve ser composto por uma API backend que siga os padrões RESTful.
- Lembretes possuem os atributos "nome", "data", "descrição" e "status".
- Para criar um lembrete, os campos "nome" e "data" devem estar preenchidos.
- O campo "data" deve estar no futuro.
- Quando um novo lembrete é adicionado e a data correspondente já existe na lista, o mesmo será exibido naquela data específica. Caso contrário, um novo dia será criado para exibir o lembrete recém-adicionado.
- O usuário pode criar novos lembretes e excluir aqueles que foram criados anteriormente.

## Decisões de Projeto

Foram implementados os seguintes bônus:

- Testes unitários
- Layout feito em SwiftUI
- Criação e utilização de uma API RESTful
- Não utilização de bibliotecas de componentes ou de terceiros

## Tecnologias Utilizadas

- Back-end: Node.js
- Front-end: SwiftUI
- Banco de dados: MongoDB

## Organização de Pastas

- **Back-end:** Contém os arquivos da API desenvolvida em Node.js.
  - `ApiVagaEstagio-main`: Pasta principal da API.
  - `src`: Contém os controladores e modelos da aplicação.
  - `controllers`: Controladores da API.
  - `models`: Modelos da aplicação.
  - `tests`: Testes da API.

- **Lembretes UI:** Contém a interface do projeto.
  - `Components`: Componentes da interface.
  - `Model`: Modelos da interface.
  - `View`: Vistas da interface.
  - `Utility`: Utilitários diversos.

## Instruções para Executar o Código

### Pré-requisitos

- Sistema Operacional: macOS
- Node.js e Xcode instalados (o Node.js pode ser baixado em: https://nodejs.org/en)
- Yarn instalado (pode ser instalado com o comando "npm install --global yarn")

### Execução

#### Back-end

1. Abra o terminal no diretório da API e digite o comando `npm install`.
2. Em seguida, execute o comando `yarn dev` no mesmo diretório.

#### Front-end

1. Abra o projeto no Xcode.

### Testes Unitários

#### Front-end

1. Navegue até a pasta de testes.
2. Pressione as teclas `⌘ + U`.

#### Back-end

1. Abra o terminal no diretório da API (ApiVagaEstagio-main).
2. Digite o comando `npm test`.

Em caso de qualquer problema ao executar o código, entre em contato pelo WhatsApp no número (62 996876254).

[Link mostrando a execução do código](https://www.youtube.com/watch?v=wlHAC2Fnvrk)
