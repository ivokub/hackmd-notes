WITH default_values AS (
    SELECT blockNumber, value
    FROM proofs
    WHERE parameter = 'all-total' AND proveMode = 'default'
),
unconstrained_values AS (
    SELECT blockNumber, value
    FROM proofs
    WHERE parameter = 'all-total' AND proveMode = 'unconstrained-sha3'
)
SELECT 
    d.blockNumber,
    d.value AS "constrained sha3",
    u.value AS "unconstrained sha3",
    (d.value - u.value) AS value_difference,
    CAST((d.value - u.value) AS FLOAT)/ CAST(d.value AS FLOAT) * 100 AS percentage_difference
FROM 
    default_values d
JOIN 
    unconstrained_values u
ON 
    d.blockNumber = u.blockNumber
ORDER BY
    value_difference DESC
;