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

```elixir
Framer.start_link
Framer.replace_frame(:fish, %{parent: :animal, lives_in: :water, has: :gills})
Framer.replace_frame(:animal, %{is_alive?: true})
Framer.replace_frame(:water, %{is_alive?: false})
Framer.replace_frame(:whale, %{parent: :mammal, lives_in: :water})
Framer.replace_frame(:mammal, %{parent: :animal, has: :vertebras})
Framer.replace_frame(:polar_bear, %{parent: :mammal, has: :fur, legs: 4, eats: :fish, lives_in: :artic})
Framer.replace_frame(:water, %{color: :blue})

Framer.query(:fish, :has) # => :gills
Framer.query(:polar_bear, [:eats, :lives_in]) # => :water
Framer.query(:polar_bear, :is_alive?) # => true
```
