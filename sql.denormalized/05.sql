SELECT 
    '#' || t.hashtag AS tag, 
    COUNT(*) AS count
FROM (
    SELECT DISTINCT
        data->>'id' AS id_tweets,
        JSONB_ARRAY_ELEMENTS(
            data->'entities'->'hashtags' || 
            COALESCE(data->'extended_tweet'->'entities'->'hashtags', '[]')
        )->>'text' AS hashtag
    FROM tweets_jsonb
    WHERE TO_TSVECTOR('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@ TO_TSQUERY('english', 'coronavirus')
      AND data->>'lang' = 'en'
) AS t
GROUP BY t.hashtag
ORDER BY count DESC, t.hashtag
LIMIT 1000;

