# Benchmark Results

The canonical, always-current leaderboard is published at [https://bankstatemently.com/benchmark/results](https://bankstatemently.com/benchmark/results) — this file is a point-in-time mirror for anyone browsing the repo directly.

## Leaderboard

One row per tool, two columns: a Real Statement (2025) run against one real DBS Singapore statement, and an Open Benchmark (2026) mean across the released statements in this repo (bsb-001..bsb-005) — so any ranking here is independently reproducible.

| Tool | Real Statement (2025) | Open Benchmark (2026) | Statements Scored |
|---|--:|--:|--:|
| [Bank Statement Converter](https://bankstatemently.com/benchmark/results/bankstatementconverter) | 100.0% | Not yet run | 0/5 |
| [Bankstatemently](https://bankstatemently.com/benchmark/results/bankstatemently) | 100.0% | 99.9% | 5/5 |
| [Claude Sonnet 4](https://bankstatemently.com/benchmark/results/claudesonnet4) | 81.0% | Not yet run | 0/5 |
| [BankStatementWizard](https://bankstatemently.com/benchmark/results/bankstatementwizard) | 57.5% | Not yet run | 0/5 |
| [ConvertBankStatement.io](https://bankstatemently.com/benchmark/results/convertbankstatement) | 52.7% | Not yet run | 0/5 |
| [LlamaIndex](https://bankstatemently.com/benchmark/results/llamaindex) | 31.2% | Not yet run | 0/5 |
| [ChatGPT - GPT-5](https://bankstatemently.com/benchmark/results/chatgpt5) | 30.1% | Not yet run | 0/5 |
| [Statemently.ai](https://bankstatemently.com/benchmark/results/statemently) | 17.0% | Not yet run | 0/5 |
| [StatementConvert.com](https://bankstatemently.com/benchmark/results/statementconvert) | 7.9% | Not yet run | 0/5 |

## Community submissions

Parsers submitted by their authors that aren't available as a product or service. Scored through the same engine as the leaderboard, listed separately because you can't go and use them.

| Tool | Real Statement (2025) | Open Benchmark (2026) | Statements Scored |
|---|--:|--:|--:|
| [Internal Statement Parser](https://bankstatemently.com/benchmark/results/internal-statement-parser) | Not yet run | 45.3% | 5/5 |

## Submissions

Score your own tool by running `evaluate_benchmark` against the released statements (bsb-001..bsb-005), then follow the "Submit to the leaderboard" instructions in this repository's README.
