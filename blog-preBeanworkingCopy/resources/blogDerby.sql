/*
Script generated by Aqua Data Studio 8.0.14 on Feb-17-2012 08:11:57 PM
Database: null
Schema: <All Schemas>
*/

ALTER TABLE "comments"
	DROP CONSTRAINT "FK_BLOG_COMMENTS";
ALTER TABLE "blog_entry_categories"
	DROP CONSTRAINT "FK_BLOG_ENTRY_CATEGORIES";
ALTER TABLE "blog_entry_categories"
	DROP CONSTRAINT "FK_CATEGORY_BLOG_ENTRIES";
ALTER TABLE "blog_entries"
	DROP CONSTRAINT "FK_BLOG_ENTRIES_AUTHORS";
DROP TABLE "blog_entries";
DROP TABLE "blog_entry_categories";
DROP TABLE "categories";
DROP TABLE "comments";
DROP TABLE "users";
CREATE TABLE "blog_entries"  ( 
	"blog_id"     	INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
	"title"       	VARCHAR(512) NOT NULL,
	"date_created"	TIMESTAMP NOT NULL,
	"views"       	INTEGER NOT NULL DEFAULT 0,
	"body_text"   	LONG VARCHAR,
	"author_id"   	INTEGER NOT NULL,
	CONSTRAINT "PK_BLOG_ENTRIES" PRIMARY KEY("blog_id")
);
CREATE TABLE "blog_entry_categories"  ( 
	"blog_id"	INTEGER NOT NULL,
	"cat_id" 	VARCHAR(25) NOT NULL,
	CONSTRAINT "PK_BLOG_ENTRY_CATEGORIES" PRIMARY KEY("blog_id","cat_id")
);
CREATE TABLE "categories"  ( 
	"cat_id"	INTEGER NOT NULL,
	"name"  	VARCHAR(64) NOT NULL,
	CONSTRAINT "PK_CAT_ID" PRIMARY KEY("cat_id")
);
CREATE TABLE "comments"  ( 
	"comment_id"  	INTEGER NOT NULL,
	"body_text"   	LONG VARCHAR NOT NULL,
	"date_created"	TIMESTAMP NOT NULL,
	"author"      	VARCHAR(128) NOT NULL,
	"email"       	VARCHAR(128) NOT NULL,
	"website"     	VARCHAR(128),
	"subscribe"   	SMALLINT NOT NULL,
	"blog_id"     	INTEGER NOT NULL,
	CONSTRAINT "PK_COMMENTS" PRIMARY KEY("comment_id","blog_id")
);
CREATE TABLE "users"  ( 
	"user_id"  	INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
	"username" 	VARCHAR(30) NOT NULL,
	"password" 	VARCHAR(128) NOT NULL,
	"email"    	VARCHAR(128) NOT NULL,
	"firstname"	VARCHAR(30) NOT NULL,
	"lastname" 	VARCHAR(30) NOT NULL,
	"active"   	SMALLINT NOT NULL,
	"salt"     	VARCHAR(36) NOT NULL,
	CONSTRAINT "PK_USER_ID" PRIMARY KEY("user_id")
);
ALTER TABLE "comments"
	ADD CONSTRAINT "FK_BLOG_COMMENTS"
	FOREIGN KEY("blog_id")
	REFERENCES "blog_entries"("blog_id");
ALTER TABLE "blog_entry_categories"
	ADD CONSTRAINT "FK_BLOG_ENTRY_CATEGORIES"
	FOREIGN KEY("blog_id")
	REFERENCES "blog_entries"("blog_id");
ALTER TABLE "blog_entry_categories"
	ADD CONSTRAINT "FK_CATEGORY_BLOG_ENTRIES"
	FOREIGN KEY("cat_id")
	REFERENCES "categories"("cat_id");
ALTER TABLE "blog_entries"
	ADD CONSTRAINT "FK_BLOG_ENTRIES_AUTHORS"
	FOREIGN KEY("author_id")
	REFERENCES "users"("user_id");
