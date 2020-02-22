﻿-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/3F00jX
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE card_holder (
    id INTEGER   NOT NULL,
    name VARCHAR   NOT NULL,
    CONSTRAINT pk_card_holder PRIMARY KEY (
        id
     )
);

CREATE TABLE credit_card (
    card VARCHAR   NOT NULL,
    cardholder_id INTEGER   NOT NULL,
    CONSTRAINT pk_credit_card PRIMARY KEY (
        card
     )
);

CREATE TABLE merchant (
    id INTEGER   NOT NULL,
    name VARCHAR   NOT NULL,
    id_merchant_category INTEGER   NOT NULL,
    CONSTRAINT pk_merchant PRIMARY KEY (
        id
     )
);

CREATE TABLE merchant_category (
    id INTEGER   NOT NULL,
    name VARCHAR   NOT NULL,
    CONSTRAINT pk_merchant_category PRIMARY KEY (
        id
     )
);

CREATE TABLE transactions (
    id INTEGER   NOT NULL,
    date TIMESTAMP   NOT NULL,
    amount REAL   NOT NULL,
    card VARCHAR   NOT NULL,
    id_merchant INTEGER   NOT NULL,
    CONSTRAINT pk_transactions PRIMARY KEY (
        id
     )
);

ALTER TABLE credit_card ADD CONSTRAINT fk_credit_card_cardholder_id FOREIGN KEY(cardholder_id)
REFERENCES card_holder (id);

ALTER TABLE merchant ADD CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY(id_merchant_category)
REFERENCES merchant_category (id);

ALTER TABLE transactions ADD CONSTRAINT fk_transactions_card FOREIGN KEY(card)
REFERENCES credit_card (card);

ALTER TABLE transactions ADD CONSTRAINT fk_transactions_id_merchant FOREIGN KEY(id_merchant)
REFERENCES merchant (id);
