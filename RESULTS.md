# Benchmark Results

The canonical, always-current leaderboard is published at [https://bankstatemently.com/benchmark/results](https://bankstatemently.com/benchmark/results) — this file is a point-in-time mirror for anyone browsing the repo directly.

## Open Benchmark Leaderboard

One row per tool, aggregated across its scores on the released open-benchmark statements (bsb-001..bsb-005) — the same statements in this repo, so any ranking here is independently reproducible.

| Tool | Mean Accuracy | Statements Scored |
|---|--:|--:|
| [Bankstatemently](https://bankstatemently.com/benchmark/results/bankstatemently) | 99.9% | 5/5 |

## Legacy Results (dbs-sg-jul-2025)

Our earlier methodology tested every tool against a single private DBS Bank (Singapore) statement. These scores remain here for continuity, but the leaderboard above — scored against 5 released, independently reproducible statements — is the current methodology.

| Tool | Accuracy |
|---|--:|
| [Bank Statement Converter](https://bankstatemently.com/benchmark/results/bankstatementconverter) | 100.0% |
| [Bankstatemently](https://bankstatemently.com/benchmark/results/bankstatemently) | 100.0% |
| [Claude Sonnet 4](https://bankstatemently.com/benchmark/results/claudesonnet4) | 81.0% |
| [BankStatementWizard](https://bankstatemently.com/benchmark/results/bankstatementwizard) | 57.5% |
| [ConvertBankStatement.io](https://bankstatemently.com/benchmark/results/convertbankstatement) | 52.7% |
| [LlamaIndex](https://bankstatemently.com/benchmark/results/llamaindex) | 31.2% |
| [ChatGPT - GPT-5](https://bankstatemently.com/benchmark/results/chatgpt5) | 30.1% |
| [Statemently.ai](https://bankstatemently.com/benchmark/results/statemently) | 17.0% |
| [StatementConvert.com](https://bankstatemently.com/benchmark/results/statementconvert) | 7.9% |

## Submissions

Score your own tool by running `evaluate_benchmark` against the released statements (bsb-001..bsb-005), then follow the "Submit to the leaderboard" instructions in this repository's README.
