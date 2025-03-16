SELECT 
    s.transactionHash as "transaction hash", 
    SUM(s.staticGas) + SUM(s.dynamicGas) AS "total hash gas used",
    CAST(SUM(s.staticGas) + SUM(s.dynamicGas) AS FLOAT) / CAST(t.gas AS FLOAT) * 100 AS "relative gas used",
    t.gas
FROM 
    steps s 
JOIN 
    transactions t 
ON 
    s.transactionHash = t.transactionHash 
WHERE
    t.failed=false 
GROUP BY 
    s.transactionHash 
ORDER BY
    "total hash gas used" ASC;