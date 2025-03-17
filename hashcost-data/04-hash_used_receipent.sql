--select t."to" as "receipent", sum(s.dynamicGas)+sum(s.staticGas) as "hash gas used", SUM(t.gas) as "total gas used", s.hashType as "hash function" from transactions t join steps s on s.transactionHash=t.transactionHash group by t."to",s.hashType order by "hash gas used";
with hash_gas as (
    select steps.transactionHash, sum(dynamicGas) + sum(staticGas) as "hash gas used"
    from steps
    join transactions on steps.transactionHash = transactions.transactionHash
    -- where transactions.failed=false
    group by steps.transactionHash
),
total_gas as (
    select t."to", t.transactionHash, t.gas as "total gas used"
    from transactions t
    -- where t.failed=false
)
select tg."to" as "receipent", sum(hg."hash gas used") as "hash gas used", sum(tg."total gas used") as "total gas used"
from total_gas tg
join hash_gas hg on tg.transactionHash = hg.transactionHash
group by tg."to"
order by "hash gas used";