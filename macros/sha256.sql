{% macro sha256(input_string) %}
    {% if target.type == 'postgres' %}
        -- For PostgreSQL, use the `digest` function from the `pgcrypto` extension
        digest({{ input_string }}, 'sha256')
    {% elif target.type == 'snowflake' %}
        -- For Snowflake, use the `sha2` function
        sha2({{ input_string }}, 256)
    {% elif target.type == 'bigquery' %}
        -- For BigQuery, use the `SHA256` function
        SHA256({{ input_string }})
    {% elif target.type == 'redshift' %}
        -- For Redshift, use the `encode` function with `sha256`
        encode(sha256({{ input_string }}::bytea), 'hex')
    {% elif target.type == 'azure' %}
        -- For Azure SQL Database, use the `HASHBYTES` function
        CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', {{ input_string }}), 2)  -- Convert to hex
    {% else %}
        -- Fallback for other databases
        raise "SHA-256 is not supported for this database."
    {% endif %}
{% endmacro %}