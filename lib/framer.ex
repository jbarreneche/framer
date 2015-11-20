defmodule Framer do
  defstruct frames: %{}
  require IEx

  def start_link(name \\ __MODULE__) do
    Agent.start_link(fn -> %Framer{} end, name: name)
  end

  def replace_frame(framer \\ __MODULE__, name, attributes) do
    Agent.update(framer, &replace_in_memory(&1, name, attributes))
  end

  def query(framer \\ __MODULE__, name, attribute) do
    Agent.get(framer, &fetch_in_memory(&1, name, attribute))
  end

  defp replace_in_memory(framer, name, attributes) do
    %Framer{ frames: Dict.put(framer.frames, name, Frame.from_attributes(attributes)) }
  end

  def state(inferencer \\ __MODULE__) do
    Agent.get(inferencer, &({&1.frames}))
  end

  defp fetch_in_memory(_framer, nil, _attribute), do: nil
  defp fetch_in_memory(framer, name, []), do: name
  defp fetch_in_memory(framer, name, [attribute]), do: fetch_in_memory(framer, name, attribute)
  defp fetch_in_memory(framer, name, [association | rest]) do
    fetch_in_memory(framer, fetch_association(framer, name, association), rest)
  end

  defp fetch_in_memory(framer, name, attribute) do
    case Dict.fetch(framer.frames, name) do
      :error        -> nil
      {:ok, frame } ->
        Frame.get(frame, attribute) || fetch_in_memory(framer, frame.parent, attribute)
    end
  end

  defp fetch_association(framer, name, association_name) do
    case fetch_in_memory(framer, name, association_name) do
      nil -> nil
      association when is_atom(association) -> association
      _ -> nil
    end
  end

end
