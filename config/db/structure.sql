CREATE TABLE `schema_migrations`(`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `accounts`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `name` varchar(255) NOT NULL,
  `balance_cents` integer DEFAULT(0) NOT NULL,
  `currency` varchar(255) DEFAULT('GBP') NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL
);
CREATE TABLE `transactions`(
  `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
  `account_id` integer NOT NULL REFERENCES `accounts` ON DELETE CASCADE,
  `amount_cents` integer NOT NULL,
  `currency` varchar(255) DEFAULT('GBP') NOT NULL,
  `type` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL,
  `description` varchar(255) NULL
);
INSERT INTO schema_migrations (filename) VALUES
('20251206092829_create_accounts.rb'),
('20251206093505_create_transactions.rb');
