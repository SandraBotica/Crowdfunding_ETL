-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/f7nw1E
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "campaign" (
    "cf_id" INTEGER   NOT NULL,
    "contact_id" INTEGER   NOT NULL,
    "company_name" VARCHAR(50)   NOT NULL,
    "description" VARCHAR(100)   NOT NULL,
    "goal" FLOAT   NOT NULL,
    "pledged" FLOAT   NOT NULL,
    "outcome" VARCHAR(10)   NOT NULL,
    "backers_count" INTEGER   NOT NULL,
    "country" VARCHAR(2)   NOT NULL,
    "currency" VARCHAR(3)   NOT NULL,
    "launch_date" VARCHAR(10)   NOT NULL,
    "end_date" VARCHAR(10)   NOT NULL,
    "category_id" VARCHAR(4)   NOT NULL,
    "subcategory_id" VARCHAR(8)   NOT NULL,
    CONSTRAINT "pk_campaign" PRIMARY KEY (
        "cf_id"
     )
);

SELECT * 
from campaign;

CREATE TABLE "category" (
    "category_id" VARCHAR(4)   NOT NULL,
    "category" VARCHAR(12)   NOT NULL,
    CONSTRAINT "pk_category" PRIMARY KEY (
        "category_id"
     )
);

SELECT * 
from category;

CREATE TABLE "subcategory" (
    "subcategory_id" VARCHAR(8)   NOT NULL,
    "subcategory" VARCHAR(17)   NOT NULL,
    CONSTRAINT "pk_subcategory" PRIMARY KEY (
        "subcategory_id"
     )
);

SELECT *
from subcategory;

CREATE TABLE "contacts" (
    "contact_id" INTEGER   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "email" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_contacts" PRIMARY KEY (
        "contact_id"
     )
);

SELECT *
from contacts;

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_contact_id" FOREIGN KEY("contact_id")
REFERENCES "contacts" ("contact_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_category_id" FOREIGN KEY("category_id")
REFERENCES "category" ("category_id");

ALTER TABLE "campaign" ADD CONSTRAINT "fk_campaign_subcategory_id" FOREIGN KEY("subcategory_id")
REFERENCES "subcategory" ("subcategory_id");


SELECT country, COUNT(category_id) AS "category_ids" 
from campaign
group by country;

SELECT country, COUNT(subcategory_id) AS "subcategory_ids" 
from campaign
group by country;

SELECT * from campaign where country = 'AU';

SELECT * from campaign where company_name = 'Davis Ltd';

SELECT MAX(goal) from campaign;

SELECT MAX(pledged) from campaign;

SELECT * from contacts where contact_id <1250;

SELECT * from contacts where first_name = 'Samuel';

SELECT * from category where category_id = 'cat7';

SELECT * from subcategory where subcategory = 'jazz';

SELECT c.contact_id, 
co.first_name, 
co.last_name, 
co.email, 
c.company_name, 
c.category_id, 
ca.category,
c.subcategory_id,
s.subcategory
from campaign as c
INNER JOIN contacts as co ON
c.contact_id = co.contact_id
INNER JOIN category as ca ON
c.category_id = ca.category_id
INNER JOIN subcategory as s ON
c.subcategory_id = s.subcategory_id