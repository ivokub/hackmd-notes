SELECT 
    "keccak256",
    -- b.blockNumber as "block number",
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
    p.proveMode = "bigblocks" AND
    b.blockNumber = 18965
GROUP BY 
    b.blockNumber
ORDER BY 
    "gas proven per ms" DESC;

SELECT 
    "sha256",
    -- b.blockNumber as "block number",
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
    p.proveMode = "bigblocks" AND
    b.blockNumber = 18968
GROUP BY 
    b.blockNumber
ORDER BY 
    "gas proven per ms" DESC;

SELECT 
    "ripemd160",
    -- b.blockNumber as "block number",
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
    p.proveMode = "bigblocks" AND
    b.blockNumber = 18971
GROUP BY 
    b.blockNumber
ORDER BY 
    "gas proven per ms" DESC;

SELECT 
    "blake2f",
    -- b.blockNumber as "block number",
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
    p.parameter = "prove_core-total" AND
    p.proveMode = "bigblocks" AND
    b.blockNumber = 18973
GROUP BY 
    b.blockNumber
ORDER BY 
    "gas proven per ms" DESC;