WITH busy_values AS (
    SELECT blockNumber, value
    FROM proofs
    WHERE parameter = 'all-busy' AND proveMode = 'default'
),
total_values AS (
    SELECT blockNumber, value
    FROM proofs
    WHERE parameter = 'all-total' AND proveMode = 'default'
)
SELECT 
    -- d.blockNumber,
    -- d.value AS "busy time",
    -- u.value AS "idle time",
    AVG(CAST(d.value AS FLOAT)/ CAST(u.value AS FLOAT) * 100) AS "utilization"
FROM 
    busy_values d
JOIN 
    total_values u
ON 
    d.blockNumber = u.blockNumber
-- ORDER BY
--     "utilization" DESC
;