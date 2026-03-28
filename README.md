# postgresql-uz-hunspell

Oʻzbek tili uchun [Hunspell](https://hunspell.github.io/) lugʻatlari va PostgreSQL **toʻliq matnli qidiruv (FTS)** sozlamalari — lotin va kirill yozuvlarida.

Kengaytma **PGXS** orqali yigʻiladi — o‘rnatishda serveringizdagi PostgreSQL bilan mos **`pg_config`** ishlating (reliz raqami hujjatda qattiq bog‘lanmagan).

[Uzbek Hunspell dictionaries](https://github.com/u2b3k/uz-hunspell) (fork manbasi) asosida: 90 000 dan ortiq lemma va soʻz turkumlari boʻyicha qoʻshimchalar.

**Inglizcha / по-русски:** this repository provides Uzbek Hunspell `.aff` / `.dic` files and a PostgreSQL extension that registers text search dictionaries and a `uz_fts` configuration for Latin and Cyrillic text. It is suitable for **full-text search**, not only spell checking.

## Nima uchun FTS uchun Hunspell?

PostgreSQL ichida oʻzbek tili uchun alohida **Snowball** stemmer yoʻq ([Snowball algoritmlari roʻyxati](https://snowballstem.org/algorithms/)). `TEMPLATE = hunspell` bilan lugʻat morfologik normalizatsiya va qoidalarni Hunspell orqali beradi — bu amaliyotda eng toʻgʻri yoʻl.

## Talablar

- PostgreSQL **hunspell** qoʻllab-quvvatlashi bilan yigʻilgan boʻlishi kerak (`CREATE TEXT SEARCH DICTIONARY ... TEMPLATE = hunspell` mavjud boʻlishi).
- Qurish: **toʻliq** PostgreSQL server dev (PGXS), `make`, `gcc`. Faqat `libpq` klienti yetarli emas — `pgxs.mk` yoʻq boʻlishi mumkin (masalan, Homebrew’da server formulasi `pg_config` ishlating, `libpq` emas). Batafsil: [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Oʻrnatish (kengaytma — tavsiya etiladi)

Repozitoriydan klonda:

```bash
cd postgresql-uz-hunspell
# PG_CONFIG server PostgreSQL bilan mos bo‘lishi kerak (masalan Homebrew server formulasi, libpq emas)
make PG_CONFIG="$(command -v pg_config)"
sudo make PG_CONFIG="$(command -v pg_config)" install
```

Soʻng maʼlumotlar bazasida:

```sql
CREATE EXTENSION hunspell_uz;
```

Kengaytma `share/tsearch_data/` ichiga `uz_UZ.*`, `uz_UZ_cyrl.*` va stop-fayllarni joylaydi va `sql/hunspell_uz--1.0.sql` dagi obyektlarni yaratadi.

## Tezkor tekshiruv (FTS)

```sql
SELECT to_tsvector('uz_fts', 'Oʻzbekiston Respublikasi Konstitutsiyasi')
     @@ plainto_tsquery('uz_fts', 'konstitutsiya');

SELECT ts_headline(
  'uz_fts',
  'Toshkent — Oʻzbekiston poytaxti.',
  plainto_tsquery('uz_fts', 'poytaxt')
);
```

Batafsil va qoʻshimcha soʻrovlar: [`sql/examples_fts.sql`](sql/examples_fts.sql).

## Repozitoriy tuzilishi

| Yo‘l | Mazmun |
|------|--------|
| `Makefile`, `hunspell_uz.control` | PGXS kengaytmasi (`DATA_TSEARCH` → `share/tsearch_data/`) |
| `tsearch_data/*.aff`, `tsearch_data/*.dic` | Hunspell lug‘atlari (asosiy nusxa shu yerda) |
| `tsearch_data/*.stop` | FTS stop-so‘zlar |
| `sql/hunspell_uz--1.0.sql` | Kengaytma SQL (`TEMPLATE = hunspell`) |
| `sql/examples_fts.sql` | Sinov so‘rovlari |
| `LICENSE` | GPL-3.0 |

Loyiha ildizidagi `uz_UZ.dic` va `uz_UZ_Cyrl.dic` — `tsearch_data/` ga **simlink** (bir xil fayl, ikki marta saqlanmaydi).

## Stop-soʻzlar

`tsearch_data/uzbek.stop` va `tsearch_data/uzbek_cyrl.stop` — umumiy funksional soʻzlar (qidiruv sifatini yaxshilash uchun). Roʻyxatni loyiha ehtiyojiga qarab kengaytirish mumkin.

## Hissa qoʻshish va reliz

- Qurish, sinash, PR: [`CONTRIBUTING.md`](CONTRIBUTING.md)
- GitHub teg va reliz: [`docs/RELEASING.md`](docs/RELEASING.md)

## PostgreSQL hamjamiyati va yoʻl xaritasi

Qanday qilib bu ishni jamiyat bilan ulashish, qayerga yozish va nima kutish mumkin — [`docs/POSTGRESQL_COMMUNITY.md`](docs/POSTGRESQL_COMMUNITY.md).

## Litsenziya

GPL-3.0 (repozitoriydagi `LICENSE` fayliga qarang).

## Aloqa

Muammolar va takliflar: [GitHub Issues](https://github.com/postgresprofi/postgresql-uz-hunspell/issues).

---

### English summary

| Item | Description |
|------|-------------|
| **Purpose** | Uzbek FTS via Hunspell dictionaries (Latin + Cyrillic). |
| **PostgreSQL** | Use your server’s `pg_config` (PGXS + Hunspell); no fixed version in this repo. |
| **Install** | `make && sudo make install`, then `CREATE EXTENSION hunspell_uz;`. |
| **Config** | Text search configuration `uz_fts` (see extension SQL). |
| **Community** | See [`docs/POSTGRESQL_COMMUNITY.md`](docs/POSTGRESQL_COMMUNITY.md). |
| **License** | GPL-3.0 — [`LICENSE`](LICENSE). |
| **Contributing / build** | [`CONTRIBUTING.md`](CONTRIBUTING.md) |
| **Releases** | [`docs/RELEASING.md`](docs/RELEASING.md) |
