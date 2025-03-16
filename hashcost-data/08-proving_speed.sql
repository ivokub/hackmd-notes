SELECT 
    b.blockNumber as "block number",
    SUM(t.gas) AS "total gas used",
    p.value AS "total proving time",
    SUM(t.gas)/p.value AS "gas proven per ms"
FROM 
    blocks b
JOIN 
    transactions t ON b.blockNumber = t.blockNumber
JOIN 
    proofs p ON b.blockNumber = p.blockNumber
WHERE
    p.parameter = "all-total" AND
    p.proveMode = "default"
GROUP BY 
    b.blockNumber
ORDER BY 
    "gas proven per ms" DESC;