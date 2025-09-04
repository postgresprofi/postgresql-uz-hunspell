CREATE TEXT SEARCH DICTIONARY uz_hunspell_lat (
  TEMPLATE = ispell,
  DictFile = uz_UZ,
  AffFile  = uz_UZ,
  StopWords = uzbek
);

CREATE TEXT SEARCH DICTIONARY uz_hunspell_cyrl (
  TEMPLATE = ispell,
  DictFile = uz_UZ_cyrl,
  AffFile  = uz_UZ_cyrl,
  StopWords = uzbek_cyrl
);

CREATE TEXT SEARCH CONFIGURATION uz_fts (COPY = simple);

ALTER TEXT SEARCH CONFIGURATION uz_fts
  ALTER MAPPING FOR
    word, asciiword, hword, hword_part, asciihword, hword_asciipart
  WITH uz_hunspell_lat, uz_hunspell_cyrl, simple;

COMMENT ON TEXT SEARCH CONFIGURATION uz_fts IS
'Uzbek FTS (Latin + Cyrillic) via Hunspell';
