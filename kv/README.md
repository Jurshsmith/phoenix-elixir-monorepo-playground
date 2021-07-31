# KV

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kv` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kv, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kv](https://hexdocs.pm/kv).

## Run App
From project root :

```
  mix run
```

or for some

after cloning

```
  cd kv\lib\key_value_server
```

interact with Key Value Store with
```
  KeyValue.Server.start_link()
```

map the process id to an atom so that every other service can interact with this process from anywhere using : 

```
Process.register(pid, :process_alias)
```

Only do this, if the process is a single instance (like each unique micro-service?)
