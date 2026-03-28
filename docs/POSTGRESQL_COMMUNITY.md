# PostgreSQL hamjamiyatiga qanday „taqdim etish“ mumkin

Bu hujjat **postgresql-uz-hunspell** loyihasini [PostgreSQL](https://www.postgresql.org/) ekotizimiga bogʻlash boʻyicha amaliy yoʻl-yoʻriq.

## 1. Bu repozitoriy nima beradi?

- **Foydalanuvchilar** uchun tayyor **kengaytma**: `hunspell_uz`, Hunspell fayllari, FTS konfiguratsiyasi `uz_fts`.
- **Jamiyat** uchun manba: lugʻat sifati, stop-soʻzlar, SQL va oʻrnatish jarayoni — muhokama va takrorlanadigan natija.

Bu allaqachon „PostgreSQL bilan ishlaydigan“ yechim; uni **PGXN**, blog, [pgsql-general](https://www.postgresql.org/list/pgsql-general/) yoki mahalliy konferensiyalarda eʼlon qilish mumkin.

## 2. „Asl“ PostgreSQL (core) ga kiritish

Oddiy yoʻl yoʻq: yangi til yoki standart FTS „uzbek“ konfiguratsiyasini **patch** sifatida [pgsql-hackers](https://www.postgresql.org/list/pgsql-hackers/) orqali taklif qilish kerak, keyin committerlar koʻrib chiqadi.

Odatda:

1. **Snowball**da yangi stemmer (oʻzbek uchun hozircha rasmiy stemmer yoʻq) — alohida loyiha: [snowballstem/snowball](https://github.com/snowballstem/snowball).
2. Yoki **stop-soʻzlar** va hujjatlar — kichikroq patchlar, lekin hamon dizayn va litsenziya muhokamasi bor.
3. **Hunspell** asosidagi kengaytmalar koʻpincha **contrib** emas, balki **tashqi kengaytma** / **PGXN** sifatida qoladi — bu normal va qadrlanadi.

Sizning holatda eng kuchli argument: **ishlaydigan kengaytma + ochiq manba + ikki yozuv (lotin/kirill)**.

## 3. Texnik eslatma: `ispell` vs `hunspell` shabloni

PostgreSQLda `.aff` / `.dic` (Hunspell) uchun standart yondashuv:

```sql
TEMPLATE = hunspell
```

`TEMPLATE = ispell` boshqa format va cheklovlarga moʻljallangan. Kengaytma ichidagi SQLni **`hunspell`** bilan tekshirib, sinovlardan oʻtkazing (quyidagi `sql/examples_fts.sql` va README).

## 4. Taklif qilish uchun qisqa xat namunasi (inglizcha)

pgsql-hackers yoki umumiy roʻyxat uchun:

> Subject: Uzbek full-text search: Hunspell extension and dictionaries  
>
> We maintain an open-source extension that ships Uzbek Hunspell dictionaries (Latin and Cyrillic), stopword files, and a `uz_fts` text search configuration for PostgreSQL. It is intended for full-text search where no Snowball stemmer exists for Uzbek.  
> Repository: https://github.com/postgresprofi/postgresql-uz-hunspell  
> We would appreciate feedback on dictionary quality, stopword lists, and whether any parts could be suitable for documentation or future packaging (e.g. PGXN).

## 5. Keyingi qadamlar (ixtiyoriy)

- [PGXN](https://pgxn.org/) ga yuklash — oʻrnatishni osonlashtiradi.
- PostgreSQL Wiki yoki blog post — qidiruv va FTS mavzusida koʻrinuvchanlik.
- Stop-soʻzlar va sinov toʻplamlari — til mutaxassislari bilan tekshiruv.

---

## Russian / по-русски (кратко)

Этот репозиторий уже полезен сообществу как **готовое расширение** с Hunspell и FTS. Включение в **ядро** PostgreSQL — отдельный процесс через **pgsql-hackers** и обычно требует согласования лицензии, формата и объёма; отдельные словари чаще распространяются как **расширение** или через **PGXN**. Для `.aff`/`.dic` в PostgreSQL следует использовать шаблон **`hunspell`**, не путать с `ispell`. Подробные примеры запросов — в `sql/examples_fts.sql`.
