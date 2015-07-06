defmodule Weather do

  def find_location({lat, long}) do
    [lat,long]
  end

  def find_location(zip) do
    [zip]
  end

end
