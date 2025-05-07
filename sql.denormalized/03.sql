SELECT lang, count(*) AS count
FROM (
    SELECT distinct data->>'id' AS id_tweets, data->>'lang' AS lang
    FROM tweets_jsonb
    WHERE data ->'entities'->'hashtags'@@'$[*].text == "coronavirus"' 
	OR data->'extended_tweet'->'entities'->'hashtags'@@'$[*].text == "coronavirus"'
) t1
GROUP BY lang
ORDER BY count DESC, lang
LIMIT 1000;
