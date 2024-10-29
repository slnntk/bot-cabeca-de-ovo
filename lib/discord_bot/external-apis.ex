defmodule ExternalApisModule do
  defp make_get_request(url, callback) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, result} -> {:ok, callback.(result)}
          {:error, _} -> {:error, "Failed to decode response"}
        end

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "Failed with status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed #{reason}"}
    end
  end

  def get_dog_image() do
    url = "https://dog.ceo/api/breeds/image/random"
    make_get_request(url, fn(data) ->
    """
    #{data["message"]}
    """ end)
  end

  def get_joke() do
    url = "https://api.chucknorris.io/jokes/random"
    make_get_request(url, fn(data) -> data["value"] end)
  end

  def get_cep(cep) do
    url = "https://opencep.com/v1/#{cep}"
    make_get_request(url, fn(data) -> """
      Cep: #{data["cep"]}
      Logradouro: #{data["logradouro"]}
      Bairro: #{data["bairro"]}
      Cidade: #{data["localidade"]}
      UF: #{data["uf"]}
      IBGE: #{data["ibge"]}
    """ end)
  end

  def get_random_fact() do
    url = "https://uselessfacts.jsph.pl/api/v2/facts/random"
    make_get_request(url, fn(data) -> """
    #{data["text"]}

    origem: #{data["source"]}
    url de origem: #{data["source_url"]}
    linguagem: #{data["language"]}
    """ end)
  end

  def get_repos(username) do
    url = "https://api.github.com/users/#{username}/repos"
    make_get_request(url, fn(data) -> """
    Repositórios de #{username}:
    #{Enum.map(data, fn(repo) -> repo["name"] end) |> Enum.join("\n")}
    """ end)
  end
end
