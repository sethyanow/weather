defmodule Weather.CLI do


  @moduledoc """
  Handle the command line parsing and dispatch to
  various functions that end up displaying the
  weather for a given location
  """

  def run(argv), do: parse_args(argv)

  @doc """
  'argv' can be -h or --help, which returns :help

  Otherwise it is a location code (string) that
  refers to the NWS XML service name.
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help])

    case parse do
      { [ help: true ], _, _}
        -> :help

      { _, [ location ] , _}
        -> { location }

      _ -> :help
    end

  end

end