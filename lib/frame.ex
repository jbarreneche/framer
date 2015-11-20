defmodule Frame do
  defstruct attributes: %{}, parent: nil

  def from_attributes(attributes) do
    case Dict.fetch(attributes, :parent) do
      {:ok, parent } -> %Frame{ attributes: Dict.delete(attributes, :parent), parent: parent }
      :error -> %Frame{ attributes: attributes }
    end
  end

  def get(frame, :parent), do: frame.parent
  def get(frame, attribute), do: Dict.get(frame.attributes, attribute)

end
