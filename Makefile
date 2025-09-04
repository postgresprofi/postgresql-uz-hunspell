EXTENSION = hunspell_uz
DATA = sql/hunspell_uz--1.0.sql
TSEARCH_DATA = \
  tsearch_data/uz_UZ.dic tsearch_data/uz_UZ.aff \
  tsearch_data/uz_UZ_cyrl.dic tsearch_data/uz_UZ_cyrl.aff \
  tsearch_data/uzbek.stop tsearch_data/uzbek_cyrl.stop
PGFILEDESC = "Uzbek Hunspell dictionaries (Latin + Cyrillic) for PostgreSQL FTS"

# PGXS bootstrap
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
