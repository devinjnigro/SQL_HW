--Isolate transactions for each card_holder

--View:

CREATE VIEW total_transactions AS
SELECT card_holder.id AS cardholder_id, card_holder.name, 
	transactions.id, transactions.card, transactions.date, 
	transactions.amount, merchant.name as merchant
FROM credit_card
JOIN card_holder
  ON card_holder.id = credit_card.cardholder_id
JOIN transactions
  ON transactions.card = credit_card.card
join merchant
  ON merchant.id = transactions.id_merchant;


--Table version:

SELECT * FROM trans_per_holder;

SELECT merchant.name, transactions.id
INTO merchant_table
FROM merchant
JOIN transactions
  ON transactions.id_merchant = merchant.id;

SELECT * FROM merchant_table
ORDER BY merchant_table.id;

SELECT trans_per_holder.id, cardholder_id, trans_per_holder.name, 
	trans_per_holder.card, trans_per_holder.date, 
	trans_per_holder.amount, merchant_table.name AS merchant
INTO transactions_cleaned
FROM trans_per_holder
JOIN merchant_table
  ON merchant_table.id = trans_per_holder.id
ORDER BY trans_per_holder.id;
  
ALTER TABLE transactions_cleaned
  ADD PRIMARY KEY (id);

SELECT * FROM transactions_cleaned
ORDER BY transactions_cleaned.id;

SELECT * FROM transactions_cleaned
ORDER BY name;


--Top 100 highest transactions from  7:00 am - 9:00 am

SELECT * 
FROM transactions_cleaned AS t
WHERE DATE_PART('hour', t.date) >= 7 
  AND DATE_PART('hour', t.date) <= 8
ORDER BY amount DESC
LIMIT 100;


--Transactions less than $2.00

SELECT * 
FROM transactions_cleaned
WHERE amount < 2.00 
ORDER BY amount ASC;


--Top 5 merchants prone to being hacked by small transactions

SELECT merchant, COUNT (merchant)
FROM transactions_cleaned
WHERE amount < 2.00
GROUP BY merchant
ORDER BY COUNT (merchant) DESC
LIMIT 5;


--Create table of Cardholder 25's transactions from Jan to June

SELECT * 
INTO ch_25_jan_to_june
FROM transactions_cleaned AS t
WHERE DATE_PART('month', t.date) <= 6 
  AND t.cardholder_id = 25
ORDER BY date ASC;


