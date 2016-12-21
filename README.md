# Review Cast

## Local setup

### Initial setup

Bootstrap local PG db (version 9.6 or above):

```bash
$ pg_ctl init -D db/postgresql
```

Start local services

```
$ heroku local -f Procfile.dev
```

Create local dbs:

```bash
$ mix ecto.create && mix ecto.migrate
$ MIX_ENV=test mix ecto.create && MIX_ENV=test mix ecto.migrate
```

### Running tests

```bash
$ mix compile
$ mix test
```

You can also go into individual sub-apps to test directly:

```bash
$ cd apps/reviewcast
$ mix test
```
