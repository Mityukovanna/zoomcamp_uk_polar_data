-- This model cleans the raw data from BigQuery
WITH source AS (
     SELECT * FROM {{ source('uk_polar_data', 'beach_debris') }}
),

cleaned AS (
    SELECT
        unique_row_id,
        filename,

        TRIM(LOCATION) AS location, 
        TRIM(SITE) AS site,

        -- Split season to season start year, season start month, season end year, season end month
        -- e.g. Jan 1991 - Apr 1991 --> | 1991 | Jan | 1991 | Apr |

        REGEXP_EXTRACT(SEASON, r'^([A-Za-z]+)')
            AS season_start_month,

        CAST(REGEXP_EXTRACT(SEASON, r'^[A-Za-z]+\s(\d{4})') AS INT64)
            AS season_start_year,

        REGEXP_EXTRACT(SEASON, r'-\s([A-Za-z]+)\s\d{4}$')
            AS season_end_month,

        CAST(REGEXP_EXTRACT(SEASON, r'(\d{4})$') AS INT64)
            AS season_end_year,

        SAMPLE_PERIOD AS sample_period,
        SAMPLE_DATE AS sample_date,

        TRIM(DEBRIS_TYPE) AS debris_type,
        TRIM(DEBRIS_DESCRIPTION) AS debris_description,
        NO_ITEMS AS no_items,
        WEIGHT_KG AS weight_kg,
        TRIM(DEBRIS_SIZE) AS debris_size,
        COMMENTS AS comments

    FROM source
    WHERE LOCATION IS NOT NULL
)

SELECT * FROM cleaned