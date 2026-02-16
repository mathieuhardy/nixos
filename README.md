# Setup

- Install a fresh NixOS (with KDE for example)

- Generate a new `age` key:

```shell
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

- Extract public `age` key and add it in `secrets.toml`

```shell
age-keygen -y ~/.config/sops/age/keys.txt
```

```toml
[sops]
age = [
  "age1abc...",
  "age1def..."
]
```

- Create the secret in raw format and cipher it inplace

```shell
echo '{"mistral": {"api_key.txt": "<my_key>"}}' > secrets/mistral/api_key.json
sops --age <age_public_key> -i -e secrets/mistral/api_key.json
```

- Apply NixOS configuration
