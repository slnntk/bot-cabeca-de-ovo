defmodule DiscordBot do
  use Nostrum.Consumer
  use HTTPoison.Base
  alias Nostrum.Api

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    case String.split(msg.content, " ", [parts: 2, trim: true]) do
      ["!get_dog_image"] -> get_dog_image(msg.channel_id)
      ["!get_joke"] -> get_joke(msg.channel_id)
      ["!get_cep", cep] -> get_cep(cep, msg.channel_id)
      ["!get_random_fact"] -> get_random_fact(msg.channel_id)
      ["!get_repos", username] -> get_user_repos(username, msg.channel_id)
      _ -> :ignore
    end
  end

  def get_dog_image(channel_id) do
    case ExternalApisModule.get_dog_image() do
      {:ok, data} -> Api.create_message(channel_id, data)
      {:error, result} -> IO.puts("Error: #{result}")
    end
  end

  def get_joke(channel_id) do
    case ExternalApisModule.get_joke() do
      {:ok, data} -> Api.create_message(channel_id, data)
      {:error, result} -> IO.puts("Error: #{result}")
    end
  end

  def get_cep(cep, channel_id) do
    case ExternalApisModule.get_cep(cep) do
      {:ok, data} -> Api.create_message(channel_id, data)
      {:error, result} -> IO.puts("Error: #{result}")
    end
  end

  def get_random_fact(channel_id) do
    case ExternalApisModule.get_random_fact do
      {:ok, data} -> Api.create_message(channel_id, data)
      {:error, result} -> IO.puts("Error: #{result}")
    end
  end

  def get_user_repos(username, channel_id) do
    case ExternalApisModule.get_repos(username) do
      {:ok, data} -> Api.create_message(channel_id, data)
      {:error, result} -> IO.puts("Error: #{result}")
    end
  end
end
