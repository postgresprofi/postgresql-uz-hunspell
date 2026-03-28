-- Examples: Uzbek full-text search after: CREATE EXTENSION hunspell_uz;
-- Requires hunspell_uz extension objects (see sql/hunspell_uz--1.0.sql in the repo).
-- NOTE: Dictionaries should use TEMPLATE = hunspell for Hunspell .aff/.dic files.

-- ---------------------------------------------------------------------------
-- 1) Sanity: configuration exists
-- ---------------------------------------------------------------------------
SELECT cfgname, cfgnamespace::regnamespace AS schema
FROM pg_ts_config
WHERE cfgname = 'uz_fts';

-- ---------------------------------------------------------------------------
-- 2) Tokenization / lexeme preview (Latin)
-- ---------------------------------------------------------------------------
SELECT *
FROM ts_debug('uz_fts', 'Oʻzbekiston Respublikasi mustaqillik eʼlon qildi.');

-- ---------------------------------------------------------------------------
-- 3) Document search
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS uz_docs;
CREATE TABLE uz_docs (
  id   serial PRIMARY KEY,
  body text NOT NULL
);

INSERT INTO uz_docs (body) VALUES
  ('Konstitutsiya Oʻzbekiston Respublikasining asosiy qonuni hisoblanadi.'),
  ('Toshkent — respublika poytaxti.');

CREATE INDEX uz_docs_body_fts ON uz_docs
  USING gin (to_tsvector('uz_fts', body));

SELECT id, ts_rank(to_tsvector('uz_fts', body), q) AS rank, body
FROM uz_docs,
     plainto_tsquery('uz_fts', 'poytaxt') q
WHERE to_tsvector('uz_fts', body) @@ q
ORDER BY rank DESC;

-- ---------------------------------------------------------------------------
-- 4) Headline (snippet)
-- ---------------------------------------------------------------------------
SELECT ts_headline(
  'uz_fts',
  body,
  plainto_tsquery('uz_fts', 'konstitutsiya'),
  'StartSel=>>, StopSel=<<, MaxWords=20, MinWords=5'
) AS snippet
FROM uz_docs
WHERE id = 1;

-- ---------------------------------------------------------------------------
-- 5) If you need to recreate dictionaries manually (e.g. after path change):
--    Files must live under PostgreSQL share/tsearch_data/ as uz_UZ.aff, uz_UZ.dic, etc.
-- ---------------------------------------------------------------------------
/*
CREATE TEXT SEARCH DICTIONARY uz_hunspell_lat (
  TEMPLATE = hunspell,
  DictFile = uz_UZ,
  AffFile = uz_UZ,
  StopWords = uzbek
);

CREATE TEXT SEARCH DICTIONARY uz_hunspell_cyrl (
  TEMPLATE = hunspell,
  DictFile = uz_UZ_cyrl,
  AffFile = uz_UZ_cyrl,
  StopWords = uzbek_cyrl
);

CREATE TEXT SEARCH CONFIGURATION uz_fts (COPY = pg_catalog.simple);

ALTER TEXT SEARCH CONFIGURATION uz_fts
  ALTER MAPPING FOR
    word, asciiword, hword, hword_part, asciihword, hword_asciipart
  WITH uz_hunspell_lat, uz_hunspell_cyrl, simple;
*/
