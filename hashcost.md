# Changing gas cost of hash functions to match them with proving cost

## Motivation

The goal of this post is to estimate the proposed coefficients in [EIP-7667](https://eips.ethereum.org/EIPS/eip-7667) for modifying the gas cost for opcodes and precompiles related to hashing in EVM.

The proposed increases in EIP-7667 for now are:
| Parameter          | Previous value | New value |
|--------------------|----------------|-----------|
| KECCAK_BASE_COST   | 30             | 300       |
| KECCAK_WORD_COST   | 6              | 60        |
| SHA256_BASE_COST   | 60             | 300       |
| SHA256_WORD_COST   | 12             | 60        |
| RIPEMD_BASE_COST   | 600            | 600       |
| RIPEMD_WORD_COST   | 120            | 120       |
| BLAKE2_GFROUND     | 1              | 10        |

These proposed costs are based on [declared proving cost](https://notes.ethereum.org/@vbuterin/evm_vs_keccak_benchmarks), not particularly for actual usage in Ethereum. Here, we instead run zkVM prover on a set of Ethereum blocks to obtain the average proving runtime.

## Hash function usage in Ethereum

For the benchmarks, we looked at blocks from [21733089](https://etherscan.io/block/21733089) to [21733759](https://etherscan.io/block/21733759). These blocks include in total of 111373 transactions. For all these transactions, we perform execution tracing to obtain the actual hash function usage. The total gas used in the transactions is 10135367525.

Gas used for hash functions is correspondingly:
| hash function | static gas | dynamic gas |  total   |
| --------------|------------|-------------|----------|
| keccak        | 41922120   | 18177390    | 60099510 |
| sha256        | 315900     | 201336      | 517236   |
| ripemd160     | 600        | 120         | 720      |
| blake2f       | 0          | 0           | 0        |
| total         | 42238620   | 18378846    | 60617466 |

Top 10 hash function gas usage per target and hash function:
| receipent                                  | hash gas used | total gas used |
|--------------------------------------------|---------------|----------------|
| 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D | 982374        | 3430718020     |
| 0x0000000000000068F116a894984e2DB1123eB395 | 1069290       | 6899777567     |
| 0x1231DEB6f5749EF6cE6943a275A1D3E7486F4EaE | 1106844       | 7918425315     |
| 0x1111111254EEB25477B68fb85Ed929f73A960582 | 1375818       | 7566485550     |
| 0x881D40237659C251811CEC9c364ef91dC08D300C | 1580136       | 10342347136    |
| 0x7CFdeB2dEF0fa6810eDa0Ac17c2A4e2F9e12DB4F | 2111046       | 24881385044    |
| 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 | 2853888       | 3348392506     |
| 0xdAC17F958D2ee523a2206206994597C13D831ec7 | 3111150       | 3609195887     |
| 0x0000000000001fF3684f28c67538d4D072C22734 | 3493914       | 19579473283    |
| 0x3fC91A3afd70395Cd496C647d5a6CC9D4B2b7FAD | 5838114       | 31690243521    |

Top 10 hash function gas used per sender and hash function:
| sender                                     | hash gas used | total gas used |
|--------------------------------------------|---------------|----------------|
| 0xe93685f3bBA03016F02bD1828BaDD6195988D950 | 277272        | 820556707      |
| 0xb1b2d032AA2F52347fbcfd08E5C3Cc55216E8404 | 289620        | 1139293240     |
| 0xD1Fa51f2dB23A9FA9d7bb8437b89FB2E70c60cB7 | 430266        | 7551045752     |
| 0x93793Bd1f3e35a0Efd098c30e486A860A0ef7551 | 449118        | 1356977455     |
| 0x654dF2b648b4E5ee2Bcc7f240Ef96B18E8DEc623 | 570276        | 129153281798   |
| 0xfb7d0D001BC8D0bC998071C762BfF53EE31b725F | 588696        | 77791914721    |
| 0xC94eBB328aC25b95DB0E0AA968371885Fa516215 | 618828        | 674362337      |
| 0xf7Bd34Dd44B92fB2f9C3D2e31aAAd06570a853A6 | 640230        | 193912200708   |
| 0xae2Fc483527B8EF99EB5D9B44875F005ba1FaE13 | 670800        | 7076271019     |
| 0x7830c87C02e56AFf27FA8Ab1241711331FA86F43 | 721230        | 11077841152    |

Top 10 transactions per absolute gas usage:
| transaction                                                        | hash gas abs        | hash gas relative   | total gas|
|--------------------------------------------------------------------|---------------------|---------------------|----------|
| 0x5ec7091c12b9f056d8b5108eda817dc748a86fc5de22e52cbc3b0f301ecb4d67 | 104172              | 2.93872714962762    | 3544800  |
| 0x9ee20239c27087d0bee5eb67dff3b987b02363ea07060b031048d8b3e67506b0 | 106470              | 1.02987876894326    | 10338110 |
| 0xcf37dcc1af302229b7d677137f90934ad4282406af319ccdfd2d23ede7bff610 | 106470              | 1.02988544350222    | 10338043 |
| 0x879920522d51d3d547f7177d1fdc703862470e3d4c302a2bccfea21e2f5388cf | 107184              | 1.02990168255518    | 10407207 |
| 0x8a09f57e362cc0f0d87ac0b71b56c50bfd670de0336bb6876b3707d97c2b5549 | 107184              | 1.02644014194569    | 10442304 |
| 0x54c41b41f4e7fd1a7c6c163f82fc711b55d9a724e1b1c275735c79f4935719f4 | 118476              | 1.99964353564036    | 5924856  |
| 0x7b87d7cc4a68aa3a6f9a7cad65ac1fdf9db8e61b9cc7df46e3eb1071cdf418b6 | 124620              | 6.41851697337722    | 1941570  |
| 0xf7021f65fa000a6e1fa4b78c23a2de5901de291358c9faa3bb8941eff499dedb | 195678              | 4.75165731769505    | 4118100  |
| 0x4194063828fc16ea48c913eea0e2b82e44e7a5a990936131ef6aacb94ba0bb3b | 211680              | 2.33523895215639    | 9064597  |
| 0x625048d6a13dbd24ed01f39e68f463bf19b7dbdddbe3a38ab5c13b427d546e7d | 268764              | 3.45597116346426    | 7776801  |
| 0xa49fe3c75eec28cd1096423d2d4ec4006fe7ecc62c2b43432d9a13f215f41405 | 371466              | 2.40051429344686    | 15474434 |

Top 10 transactions per relative gas usage:
| transaction                                                        | hash gas abs        | hash gas relative   | total gas|
|--------------------------------------------------------------------|---------------------|---------------------|----------|
| 0xf7021f65fa000a6e1fa4b78c23a2de5901de291358c9faa3bb8941eff499dedb | 195678              | 4.75165731769505    | 4118100  |
| 0x2eb79011a89cb277ceb9b3fa2f134275ff2a6077e4945dee9e35bb499026548c | 19332               | 4.88349534183457    | 395864   |
| 0xca9db98115f06b18f976be3b6270d9184811c51ed71d7b20803e895ec50dd30e | 48120               | 5.04602981687694    | 953621   |
| 0x9d032c1a67f654eb8463d016ce17004ce07a20ae77f279aefb7f303840ed5c24 | 21606               | 5.05933703623915    | 427052   |
| 0xd26b0227f1d1bb8a0939e6d7860194ba04f3819736767c39d628daa740c76a8d | 19206               | 5.06174986954253    | 379434   |
| 0x230702f59397640cc3b98208caac80933cb0a0a3ad56cc46e9cda5713fa76b37 | 33120               | 6.0175949242895     | 550386   |
| 0xf96dd26ea4d70d7fb63cf52bc62e1027d3635da94aeb53fa9270f70ffe5569aa | 57540               | 6.30519373074829    | 912581   |
| 0xe3d7d9221172860bfb71cca378358e9e478ab5e03749d08d774a65a785549dc9 | 37806               | 6.39751720963604    | 590948   |
| 0x29df2b99ad005110174f0bebf832c429d27c620a694dac4d7c6e9534028fd2ed | 37806               | 6.39777704070236    | 590924   |
| 0x7b87d7cc4a68aa3a6f9a7cad65ac1fdf9db8e61b9cc7df46e3eb1071cdf418b6 | 124620              | 6.41851697337722    | 1941570  |

## Proving performance

For the same blocks, we used reth with SP1 zkVM to obtain the prover performance. We used AWS `g6e.2xlarge` machine with 1 GPU and 48GB GPU memory, 8CPU and 64GPU CPU memory. We used CUDA proving backend.

We currently have not benchmarked using other proof systems due to time required to set up the backends and run the provers, but are planning with the following:
- Risc0
- Nexus
- Valida
- Pico
- Zisk
- Jolt

.. TODO:
- how it is measured - right now we count the 32-byte words, but this doesn't apply to keccak which operates on 136 bytes per round
- https://github.com/imapp-pl/gas-cost-estimator/blob/master/docs/gas-schedule-proposal.md
- https://eips.ethereum.org/EIPS/eip-7797#sha-256-preprocessing