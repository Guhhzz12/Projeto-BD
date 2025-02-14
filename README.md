# Projeto-BD

# Gerenciador de RPG

Este projeto é um sistema web para gerenciamento de RPG de mesa. Ele permite criar, visualizar, editar e excluir jogadores e personagens, além de realizar transferências de moedas entre jogadores.

## Tecnologias Utilizadas

- **Python**
- **Flask**
- **Flask-SQLAlchemy**
- **HTML/CSS**
- **MySQL** (banco de dados)

## Estrutura do Projeto

- **app.py**: Arquivo principal que contém as rotas e inicializa o servidor Flask.
- **models.py**: Contém os modelos de dados usados pelo SQLAlchemy.
- **templates/**: Diretório que armazena os templates HTML renderizados pelas rotas.
- **README.md**: Arquivo de documentação do projeto.

## Configuração do Ambiente

### Pré-requisitos

1. Python 3.9 ou superior instalado.
2. Gerenciador de pacotes `pip`.

### Configuração do Banco de Dados
1. Crie o banco de dados:

Utilize os arquivos presentes na pasta "Comandos SQL" para criar o banco no MYSQL.

2. Inicie o banco de dados MySQL:

Altere o arquivo config.py com as informações do seu banco.


## Executando o Projeto

1. Inicie o servidor Flask:

Inicie o arquivo app.py em qualquer IDE ou terminal de sua preferência.

2. Acesse o sistema no navegador em: `http://127.0.0.1:5000`

## Funcionalidades

### 1. Gerenciamento de Jogadores
- Criação de jogadores com nome, data de nascimento e preferência de campanha.
- Relacionamento de jogadores com personagens.

### 2. Gerenciamento de Personagens
- Criação e listagem de personagens vinculados a jogadores.
- Edição e exclusão de personagens.

### 3. Transferência de Moedas
- Transferência de moedas entre jogadores.
