SET maintenance_work_mem = '16GB';
SET max_parallel_maintenance_workers = 80;

CREATE INDEX ON tweet_tags (tag, id_tweets);
CREATE INDEX ON tweets USING GIN (to_tsvector('english', text));
CREATE INDEX ON tweets (lang);
CREATE INDEX ON tweets (id_tweets, lang);
