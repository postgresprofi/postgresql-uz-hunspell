# Releasing (GitHub)

## Versioning

- **`hunspell_uz.control`**: field `default_version` (e.g. `1.0`).
- **Extension SQL**: initial install is `sql/hunspell_uz--1.0.sql`. For **compatible** updates you can keep `1.0` and only change data files under `tsearch_data/`.
- For **SQL changes** that require `ALTER EXTENSION`, add `sql/hunspell_uz--1.0--1.1.sql` (or the next pair) and bump `default_version` to `1.1` in the control file.

## Tag

From a clean `main` (or your release branch):

```bash
git tag -a v1.0.0 -m "hunspell_uz 1.0: initial packaging"
git push origin v1.0.0
```

Use [Semantic Versioning](https://semver.org/) for the tag (`v1.0.0`). The leading `v` is optional but common on GitHub.

## GitHub Release

1. **Releases** → **Draft a new release**.
2. Choose the tag `v1.0.0`.
3. Title: e.g. `v1.0.0`.
4. Notes: short list — Uzbek Hunspell Latin + Cyrillic, `uz_fts`, stopwords, GPL-3.0.
5. Attach **Source code (zip/tar)** if colleagues need a tarball without git.

## PGXN (optional)

To publish on [PGXN](https://pgxn.org/), add a `META.json` and follow their checklist; that is separate from GitHub tags.
