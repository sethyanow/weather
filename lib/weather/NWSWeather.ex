

defmodule Weather.NWSWeather do

  @user_agent [ {"User-agent", "Elixir test@test.test"} ]

  @nws_url Application.get_env(:weather, :nws_url)

  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  require Logger

  def fetch(location) do
    Logger.info("Fetching weather for location: #{location}")
    location
    |> xml_url
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def xml_url(location) do
    "#{@nws_url}/xml/current_obs/#{location}.xml"
  end

  def get_temp(data) do
    data |> Exml.get "//current_observation/temperature_string"
  end


  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    result = body
      |> Exml.parse
    { :ok, result}
  end


  def handle_response({:error, %{reason: reason}}) do
    { :error, reason }
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    { :error, :erlang.bitstring_to_list(body) }
  end






end