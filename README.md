# Bank Statement Parsing Benchmark (BSPB)

A standardized benchmark for evaluating bank statement PDF parsers. 15 synthetic statements across 3 difficulty tiers, 12 countries, 9 languages, and 30+ parsing challenges.

**[View results and submit your parser](https://bankstatemently.com/benchmarks)** | **[Challenge browser](https://bankstatemently.com/benchmarks/challenges)** | **[API docs](https://bankstatemently.com/developers/api)**

## Why this exists

There is no standard way to measure how well a bank statement parser works. Every tool claims high accuracy, but there's no shared dataset to verify against. BSPB provides:

- **Synthetic statements** that are safe to distribute (no real customer data)
- **Known ground truth** held server-side for tamper-proof scoring
- **Real-world challenges** — bilingual headers, Buddhist era dates, scanned PDFs, multi-currency, 9-column layouts
- **Automated evaluation** via API — submit your parsed output, get a score

## Dataset

### Structure

```
datasets/
  basic/
    bsb-001/
      bsb-001-statement.pdf    # The statement to parse
      statement-info.json      # Metadata (challenges, country, currency)
    bsb-002/
    ...
  intermediate/
    bsb-006/
    ...
  advanced/
    bsb-011/
    ...
manifest.json                  # Dataset version, checksums, challenge index
```

### Statements

| ID | Difficulty | Country | Currency | Type | Challenges |
|----|-----------|---------|----------|------|------------|
| bsb-001 | Basic | SG | SGD | Bank | Credit/debit columns, balance validation, multi-line descriptions |
| bsb-002 | Basic | US | USD | Credit Card | Posting dates, transaction continuation, non-standard page size |
| bsb-003 | Basic | NL | EUR | Bank | Counterparty column, currency symbols, comma decimals |
| bsb-004 | Basic | HK | HKD | Bank | Credit/debit columns, multi-line descriptions, value date |
| bsb-005 | Basic | CA | CAD | Bank | French Canadian, space thousands separator |
| bsb-006 | Intermediate | MX | MXN | Bank | Spanish headers, dual balance timeline |
| bsb-007 | Intermediate | CA | CAD | Credit Card | French/English bilingual, split date columns, multiple tables |
| bsb-008 | Intermediate | AU | AUD | Bank | Date-time columns, scanned PDF |
| bsb-009 | Intermediate | GB | GBP | Bank | Value date, currency symbols, no table grid lines |
| bsb-010 | Intermediate | IN | INR | Bank | 500 transactions, Indian numbering, payment method column |
| bsb-011 | Advanced | HK | HKD | Bank | Bilingual (EN/ZH), multi-currency, multiple accounts, end-of-day balance |
| bsb-012 | Advanced | SG | SGD | Credit Card | Chinese-only headers, inverted sign convention, scanned PDF |
| bsb-013 | Advanced | KZ | KZT | Bank | Multi-currency, 9-column layout, fee column |
| bsb-014 | Advanced | TH | THB | Bank | Thai bilingual, Buddhist era dates, payment method column |
| bsb-015 | Advanced | MY | MYR | Credit Card | Malay/English bilingual, header-only currency symbol, scanned PDF |

All statements use fictional banks with synthetic data. No real customer information.

### Challenges

Each statement exercises specific parsing challenges found in real-world bank statements:

| Challenge | Description |
|-----------|-------------|
| `balance-validation` | Running balance must be verified against transaction amounts |
| `bilingual-headers` | Column headers in two languages (e.g., English + Chinese) |
| `buddhist-era-dates` | Thai Buddhist calendar dates (BE 2568 = CE 2025) |
| `credit-debit-columns` | Separate columns for credits and debits instead of a single amount |
| `currency-symbol-amounts` | Currency symbols embedded in amount cells |
| `date-carry-forward` | Date field blank when same as previous row |
| `date-format-variations` | Multiple date formats within the same statement |
| `dual-balance-timeline` | Two parallel balance columns (e.g., available + ledger) |
| `end-of-day-balance` | Balance shown only on the last transaction of each day |
| `fee-column` | Dedicated column for fees/charges |
| `inverted-cc-sign-convention` | Credits shown as negative, debits as positive |
| `multi-currency` | Transactions in multiple currencies within one statement |
| `multiple-tables` | Statement split into sections (e.g., Purchases, Payments, Fees) |
| `no-table-boundaries` | No visible grid lines separating columns |
| `partial-year-dates` | Dates without year (e.g., "15 Mar" instead of "15 Mar 2025") |
| `posting-date-selection` | Multiple date columns (transaction date vs posting/value date) |
| `scanned-pdf-text` | OCR-style text with slight degradation |
| `separate-counterparty-column` | Merchant/payee in a dedicated column, not embedded in description |
| `split-embedded-date-column` | Date embedded within the description column |
| `transaction-continuation` | Transaction description wrapping across multiple lines |

See the full list of 30+ challenges at [bankstatemently.com/benchmarks/challenges](https://bankstatemently.com/benchmarks/challenges).

## Evaluation

The dataset is fully open — use it however you like. If you want to score your parser against ground truth without building your own evaluation pipeline, Bankstatemently provides a free evaluation API.

### Quick start

1. Parse any statement PDF with your tool
2. Format the output as JSON (see schema below)
3. Submit to the evaluation endpoint

```bash
curl -X POST https://api.bankstatemently.com/v1/benchmark/evaluate \
  -H "Content-Type: application/json" \
  -d '{
    "statementId": "bsb-001",
    "transactions": [
      {
        "date": "2025-06-02",
        "description": "NTUC FAIRPRICE",
        "amount": -12.20,
        "balance": 15438.55,
        "originalData": {
          "Date": "02/06/2025",
          "Description": "NTUC FAIRPRICE",
          "Withdrawal (-)": "12.20",
          "Balance": "15,438.55"
        }
      }
    ]
  }'
```

### Response

```json
{
  "parsedScore": {
    "overall": 0.96,
    "structuralScore": 0.98,
    "fieldAccuracy": {
      "date": 1.00,
      "description": 0.95,
      "amount": 0.97,
      "balance": 0.94
    }
  },
  "normalizedScore": {
    "overall": 0.94,
    "structuralScore": 0.97,
    "fieldAccuracy": {
      "date": 0.98,
      "description": 0.91,
      "amount": 0.95,
      "balance": 0.93
    }
  }
}
```

### Two scores

The API evaluates two dimensions of parser quality:

- **Parsed score**: How accurately did you extract raw cell values from the PDF? Compared against the original text as it appears in the document (e.g., `"02/06/2025"`, `"15,438.55"`).
- **Normalized score**: How well did you convert extracted values to canonical form? Compared against ISO dates, numeric amounts, and unified debit/credit direction.

Both scores require `originalData` on each transaction — the raw column values as they appear in the PDF. This separates extraction accuracy from normalization accuracy.

### Rate limits

| Tier | Limit |
|------|-------|
| Anonymous | 5 evaluations/hour |
| API key (free) | 50 evaluations/day |

Get a free API key at [bankstatemently.com/developers](https://bankstatemently.com/developers).

## Submission schema

```typescript
interface Submission {
  statementId: string;         // e.g. "bsb-001"
  transactions: Transaction[];
  metadata?: {                 // Optional
    accountNumber?: string;
    statementDate?: string;
    openingBalance?: number;
    closingBalance?: number;
  };
}

interface Transaction {
  date: string;                // ISO 8601 preferred (e.g. "2025-06-02")
  description: string;
  amount: number;              // Negative for debits, positive for credits
  balance?: number;            // Running balance if available
  originalData: Record<string, string>; // Raw cell values as they appear in the PDF (required)
}
```

## Dataset integrity

Each PDF has a SHA-256 checksum in `manifest.json`. Verify your download:

```bash
# Check all PDFs
for dir in datasets/*/*; do
  id=$(basename "$dir")
  sha=$(shasum -a 256 "$dir/$id-statement.pdf" | cut -c1-16)
  echo "$id: $sha"
done
```

## License

MIT. See [LICENSE](LICENSE).

---

Built by [Bankstatemently](https://bankstatemently.com) — convert bank statement PDFs to Excel, CSV, and QBO.
