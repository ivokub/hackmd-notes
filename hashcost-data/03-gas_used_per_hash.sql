select hashType as "hash function", SUM(staticGas) as "static gas used", SUM(dynamicGas) as "dynamic gas used", SUM(staticGas)+SUM(dynamicGas) as "total gas used" from steps group by hashType;
select "total", SUM(staticGas) as "static gas used", SUM(dynamicGas) as "dynamic gas used", SUM(staticGas)+SUM(dynamicGas) as "total gas used" from steps;
