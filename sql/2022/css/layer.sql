# Note: using response bodies here instead of parsed CSS.
# The parser doesn't quite support the @layer syntax yet, resulting in errors.
# Because the table is clustered, this query is actually cheaper than querying parsed_css.
WITH layers AS (
  SELECT
    client,
    page,
    url,
    REGEXP_CONTAINS(body, r'\b@layer\b') AS has_layer
  FROM
    `httparchive.almanac.summary_response_bodies`
  WHERE
    date = '2022-06-01' AND
    type = 'css'
)


SELECT
  *
FROM
  layers
WHERE
  has_layer
