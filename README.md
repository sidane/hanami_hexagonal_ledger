# HanamiHexagonalLedger

🌸 Welcome to your Hanami app!

## Getting started

- Set up the project with `bin/setup`
- Run the server with `bin/dev`
- View the app at [http://localhost:2300](http://localhost:2300)
- Run the tests with `bundle exec rake`

## Useful links

- [Hanami](http://hanamirb.org)
- [Hanami guides](https://guides.hanamirb.org/)

## API Requests to test the endpoints

```bash
curl -X POST http://localhost:2300/accounts \
-H "Content-Type: application/json" \
-d '{"account": {"name": "Checking", "opening_balance": 100, "currency": "GBP"}}'
```

```bash
ACC_ID=<replace_with_account_id_from_previous_response>
```

```bash
curl -X POST http://localhost:2300/accounts/$ACC_ID/transaction \
-H "Content-Type: application/json" \
-d '{"transaction": {"amount": 20, "type": "debit", "currency": "GBP", "description": "Lunch"}}'
```bash

```bash
curl -X POST http://localhost:2300/accounts/$ACC_ID/transaction \
-H "Content-Type: application/json" \
-d '{"transaction": {"amount": 500, "type": "credit", "currency": "GBP", "description": "Bonus"}}'
```bash

```bash
curl http://localhost:2300/accounts/$ACC_ID
```
