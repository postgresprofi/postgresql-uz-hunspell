# Contributing

Build against the **same major PostgreSQL** you run in production: use that installation’s `pg_config` (not necessarily the `libpq`-only client).

## Build and install

The `Makefile` uses **`DATA_TSEARCH`** (PGXS variable) so `.aff`, `.dic`, and `.stop` files install into `share/tsearch_data/`. A variable named `TSEARCH_DATA` would **not** install them.

You need a **full PostgreSQL installation** that ships PGXS (`pgxs.mk`), not only the `libpq` client.

**macOS (Homebrew):** `libpq`’s `pg_config` often points at a tree where `pgxs.mk` is missing. Install the **server** formula that matches the PostgreSQL you use, then point `PG_CONFIG` at it, for example:

```bash
brew install postgresql
# yoki relizga mos formula: postgresql@<major> — `brew search postgresql`
make PG_CONFIG="$(brew --prefix postgresql)/bin/pg_config"
sudo make PG_CONFIG="$(brew --prefix postgresql)/bin/pg_config" install
```

**Debian/Ubuntu:** install the **`-dev`** package that matches your server major version (package name varies by distro):

```bash
sudo apt install postgresql-server-dev-<major>
make PG_CONFIG=/usr/bin/pg_config
sudo make install
```

PostgreSQL must be built **with Hunspell** support (`CREATE TEXT SEARCH DICTIONARY … TEMPLATE = hunspell` must work). On some distributions this is a separate package or build flag.

## Quick test

```bash
psql -d postgres -c "CREATE EXTENSION hunspell_uz;"
psql -d postgres -f sql/examples_fts.sql
```

## Changing stopwords

Edit `tsearch_data/uzbek.stop` and `tsearch_data/uzbek_cyrl.stop`. Keep Latin and Cyrillic lists aligned in meaning (same number of lines is recommended). Reinstall the extension or copy the `.stop` files into `share/tsearch_data/` and recreate dictionaries if you test without reinstalling everything.

## Changing dictionaries

Updates to `.aff` / `.dic` usually come from upstream [uz-hunspell](https://github.com/u2b3k/uz-hunspell) or your own linguistic work. After replacing files under `tsearch_data/`:

- Ensure the first line of each `.dic` equals the number of following non-empty entry lines.
- Run the SQL examples and a few `ts_debug` checks on real text.

## Pull requests

- Describe the change (FTS behaviour, spelling, or packaging only).
- Note license compatibility: project is **GPL-3.0** (see `LICENSE`).
- Avoid committing generated noise; keep diffs focused.

---

## Для авторов (кратко)

Сборка: нужен **серверный** PostgreSQL с PGXS, не только клиент `libpq`. Проверка: `CREATE EXTENSION hunspell_uz;`, затем `sql/examples_fts.sql`. Стоп-слова — в `tsearch_data/*.stop`, словари — в `tsearch_data/*.aff` и `*.dic`.
