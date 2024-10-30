Este projeto é um bot para Discord escrito em Elixir que responde a comandos para buscar dados de diversas APIs externas. 
Ele utiliza `Nostrum` para gerenciar eventos do Discord e `HTTPoison` para realizar requisições HTTP. O bot oferece informações divertidas e úteis, como imagens aleatórias de cachorros, piadas do Chuck Norris, informações de CEP, fatos aleatórios e repositórios públicos de usuários no GitHub.

---

### Índice

1. [Introdução](#introdução)
2. [Instalação e Configuração](#instalação-e-configuração)
3. [Comandos Disponíveis e APIs Utilizadas](#comandos-disponíveis)
4. [Tratamento de Erros](#tratamento-de-erros)
5. [Contribuição](#contribuição)
6. [Licença](#licença)

---

### 1. Introdução

Este bot responde a comandos enviados no Discord, chamando APIs externas e retornando os resultados na mesma conversa. É uma ótima maneira de adicionar interatividade e funcionalidades ao seu servidor.

---

### 2. Instalação e Configuração

1. Clone o repositório:
   ```bash
   git clone https://github.com/slnntk/bot-cabeca-de-ovo.git
2. Navegue até o diretório do projeto:
   ```bash
   cd seu-repositorio
3. Instale as dependências com:
   ```bash
   mix deps.get
4. Configure o arquivo config/config.exs com o token do seu bot do Discord:
   ```bash
    import Config
    
    config :nostrum,
      token: <token>,
      ffmpeg: nil,
      gateway_intents: [:guilds, :guild_messages, :message_content]
5. Inicie o bot com:
   ```bash
   mix run --no-halt

---

### 3. Comandos Disponíveis e APIs Utilizadas

| Comando                   | Descrição                                                | API Utilizada               |
|---------------------------|---------------------------------------------------------|------------------------------|
| `!get_dog_image`         | Envia uma imagem aleatória de cachorro                  | Dog CEO API                 |
| `!get_joke`              | Busca uma piada aleatória do Chuck Norris               | Chuck Norris API            |
| `!get_cep <cep>`         | Exibe informações de endereço para um CEP informado     | OpenCEP API                 |
| `!get_random_fact`       | Busca um fato aleatório                                  | Useless Facts API           |
| `!get_repos <username>`   | Lista repositórios públicos de um usuário no GitHub    | GitHub API                  |

  #### 1. Dog CEO API
- **Função**: Retorna imagens aleatórias de cachorros.
- **Endpoint para Imagem Aleatória**: `https://dog.ceo/api/breeds/image/random`
- **Método**: GET
- **Corpo da Requisição**: Não é necessário enviar um corpo na requisição.
- **Corpo da Resposta**:
    ```json
    {
        "status": "success",
        "message": "https://dog.ceo/api/image-url"
    }
  
    
#### 2. Chuck Norris API
  - **Função**: Retorna piadas aleatórias do Chuck Norris.
  - **Endpoint para Piada Aleatória**: `https://api.chucknorris.io/jokes/random`
  - **Método**: GET
  - **Corpo da Requisição**: Não é necessário enviar um corpo na requisição.
  - **Corpo da Resposta**:
      ```json
      {
          "categories": [],
          "created_at": "2020-01-05 13:09:59.266959",
          "icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
          "id": "YyCvOY4jQ5qH0VxDL1CSUg",
          "updated_at": "2020-01-05 13:09:59.266959",
          "url": "https://api.chucknorris.io/jokes/YyCvOY4jQ5qH0VxDL1CSUg",
          "value": "Chuck Norris doesn't need a watch; he decides what time it is."
      }
      ```
    
  #### 3. OpenCEP API
  - **Função**: Busca informações de endereço para um CEP informado.
  - **Endpoint**: `[https://opencep.com/v1/#{cep}]`
  - **Método**: GET
  - **Corpo da Requisição**: Não é necessário enviar um corpo; o CEP é passado na URL.
  - **Corpo da Resposta**:
      ```json
      {
          "cep": "01001-000",
          "logradouro": "Praça da Sé",
          "complemento": "lado ímpar",
          "bairro": "Sé",
          "localidade": "São Paulo",
          "uf": "SP",
          "ibge": "3550308",
          "gia": "1004",
          "ddd": "11",
          "siafi": "7087"
      }
      ```
    
  #### 4. Useless Facts API
  - **Função**: Fornece fatos aleatórios.
  - **Endpoint para Fato Aleatório**: `https://uselessfacts.jsph.pl/random.json`
  - **Método**: GET
  - **Corpo da Requisição**: Não é necessário enviar um corpo na requisição.
  - **Corpo da Resposta**:
      ```json
      {
          "text": "A crocodile cannot stick its tongue out.",
          "source": "http://www.factretriever.com/crocodile-facts",
          "success": true
      }
      ```
    
  #### 5. GitHub API
  - **Função**: Lista repositórios públicos de um usuário no GitHub.
  - **Endpoint**: `https://api.github.com/users/{username}/repos`
  - **Método**: GET
  - **Corpo da Requisição**: Não é necessário enviar um corpo na requisição.
  - **Corpo da Resposta** (exemplo de resposta para um usuário):
      ```json
      [
          {
              "id": 123456,
              "name": "repo-name",
              "full_name": "username/repo-name",
              "private": false,
              "html_url": "https://github.com/username/repo-name",
              "description": "A short description of the repository.",
              "created_at": "2021-01-01T00:00:00Z",
              "updated_at": "2021-01-01T00:00:00Z",
              "language": "JavaScript",
              ...
          }
      ]
      ```

---

### 4. Tratamento de Erros
  O bot lida com erros em dois estágios:
  
  Erro de Requisição HTTP: Caso a requisição falhe, uma mensagem de erro é exibida com o código de status ou motivo da falha.
  Erro de Decodificação JSON: Caso a resposta da API não esteja em formato JSON válido, uma mensagem "Falha ao decodificar resposta" é exibida.
