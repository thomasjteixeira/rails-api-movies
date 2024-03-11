# API - Sistema de Avaliação de Filmes

Este projeto consiste em uma API para avaliação de filmes, desenvolvida utilizando o framework Ruby on Rails. Foi criado como um desafio no processo seletivo para uma vaga de desenvolvedor Ruby on Rails. 

A API oferece aos usuários a capacidade de importar informações de filmes em larga escala a partir da API do TMDB (The Movie Database). Além disso, permite que os usuários submetam avaliações para vários filmes simultaneamente e consultem a média das notas atribuídas a cada filme.

As funcionalidades implementadas são acompanhadas por testes para garantir a robustez e a confiabilidade da aplicação. Para otimizar o desempenho e não bloquear o processo principal, as tarefas de importação de dados são executadas em segundo plano, utilizando o Sidekiq, uma solução de processamento de tarefas assíncronas para Ruby on Rails.

O projeto tem como base o desafio proposto pela Oxeanbits que inclui um esqueleto inicial do projeto disponível em [fuzzy-invention](https://github.com/oxeanbits/fuzzy-invention), fornecendo uma base sobre a qual este projeto foi construído.

## Funcionalidades
**Importação de Filmes em Massa**: Rota para a importação das informações de filmes em massa por meio de um arquivo CSV. Essa funcionalidade utiliza a API do TMDB (The Movie Database) para buscar e importar dados detalhados dos filmes fornecidos por ID ou nome, enriquecendo a base de dados da aplicação com informações precisas e atualizadas diretamente da fonte.

**Avaliação de Filmes em Massa**: Rota para submissão de avaliações de filmes em massa por meio de um arquivo CSV. 

**Autenticação de Usuários**: Login com usuário padrão (login: admin@rotten e senha: admin).

**Gestão de Usuários**: Rota para criação de novos usuários.

**Visualização de Avaliações**: Exibe a média das notas de cada filme.

**Gerenciamento de Filmes**: Rota para visualizar, cadastrar e editar detalhes de filmes.

## Requisitos:

- ruby-3.1.4
- rails 7.1.3
- Redis (Para o Sidekiq)
- sqlite3

## Configuração e Instalação

Para configurar e rodar este projeto localmente, siga os passos abaixo:

1. Clone o repositório para sua máquina local:

```bash
git clone https://github.com/thomasjteixeira/rails-api-movies
```
2. Navegue até o diretório do projeto:

```bash
cd rails-api-movies
```
3. Instale as dependências do projeto:

```bash
bundle install
```
4. Crie e configure o banco de dados:

```bash
rails db:create db:migrate db:seed
```
5. Adicione o arquivo o .env na raiz do projeto com base no .sample_env e insira a sua chave da API do TMBd. Para ter acesso a key da API do TMBd, veja em: https://developer.themoviedb.org/docs/getting-started

6. Inicie o servidor Rails:

```bash
rails server
```

## Executando os Testes

Este projeto utiliza RSpec para testes. Para executar todos os testes:

```bash
bundle exec rspec
```

## Principais Gems Utilizadas

**themoviedb-api**: Integração com a API do TMDB para importação das informações atualizadas dos filmes.

**sidekiq**: Processamento de jobs em background.

**rspec-rails**: Framework de testes para Rails.

**vcr**: Gravar e reproduzir requisições HTTP nos testes.

**shoulda-matchers**: Fornece matchers para facilitar os testes das funcionalidade comum do Rails, como validações, associações e muito mais.
