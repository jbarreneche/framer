# Framer

## Examples

```elixir
Framer.start_link
Framer.replace_frame(:a, %{data: 3})
Framer.replace_frame(:b, %{parent: :a, left: :c})
Framer.replace_frame(:c, %{parent: :b})
Framer.query(:c, :data)
Framer.query(:b, [:left, :data])
Framer.query(:c, [:left, :left, :data])
```
