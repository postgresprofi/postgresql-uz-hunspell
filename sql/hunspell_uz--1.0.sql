-- Uzbek FTS: use hunspell template for Hunspell .aff / .dic (not ispell).
-- Install files into tsearch_data via extension Makefile (TSEARCH_DATA).

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

COMMENT ON TEXT SEARCH CONFIGURATION uz_fts IS
  'Uzbek FTS (Latin + Cyrillic) via Hunspell';
