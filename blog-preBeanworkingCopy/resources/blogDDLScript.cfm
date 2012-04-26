<cfabort></cfabort><cftry>
<cfquery datasource="blogrichard">
ALTER TABLE blog_entries
	DROP CONSTRAINT FK_BLOG_ENTRIES_AUTHORS
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE comments
	DROP CONSTRAINT FK_BLOG_COMMENTS
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE blog_entry_categories
	DROP CONSTRAINT FK_BLOG_ENTRY_CATEGORIES
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE blog_entry_categories
	DROP CONSTRAINT FK_CATEGORY_BLOG_ENTRIES
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE blog_entries
	DROP CONSTRAINT PK_BLOG_ENTRIES
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE blog_entry_categories
	DROP CONSTRAINT PK_BLOG_ENTRY_CATEGORIES
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE categories
	DROP CONSTRAINT PK_CAT_ID
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE comments
	DROP CONSTRAINT PK_COMMENTS
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
ALTER TABLE users
	DROP CONSTRAINT PK_USER_ID
</cfquery>
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
DROP TABLE blog_entries
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
DROP TABLE blog_entry_categories
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
DROP TABLE categories
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
DROP TABLE comments
</cfquery> 
<cfcatch></cfcatch>
</cftry>

<cftry>
<cfquery datasource="blogrichard">
DROP TABLE users
</cfquery> 
<cfcatch></cfcatch>
</cftry>



<cfquery datasource="blogrichard">
CREATE TABLE blog_entries  ( 
	blog_id     	INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
	title       	VARCHAR(512) NOT NULL,
	date_created	TIMESTAMP NOT NULL,
	views       	INTEGER NOT NULL DEFAULT 0,
	body_text   	LONG VARCHAR,
	author_id   	INTEGER NOT NULL,
	CONSTRAINT PK_BLOG_ENTRIES PRIMARY KEY(blog_id)
)
</cfquery> 

<cfquery datasource="blogrichard">
CREATE TABLE blog_entry_categories  ( 
	blog_id	INTEGER NOT NULL,
	cat_id 	INTEGER NOT NULL,
	CONSTRAINT PK_BLOG_ENTRY_CATEGORIES PRIMARY KEY(blog_id,cat_id)
)
</cfquery> 

<cfquery datasource="blogrichard">
CREATE TABLE categories  ( 
	cat_id	INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
	name  	VARCHAR(64) NOT NULL,
	CONSTRAINT PK_CAT_ID PRIMARY KEY(cat_id)
)
</cfquery> 

<cfquery datasource="blogrichard">
CREATE TABLE comments  ( 
	comment_id  	INTEGER NOT NULL,
	blog_id     	INTEGER NOT NULL,
	body_text   	LONG VARCHAR NOT NULL,
	date_created	TIMESTAMP NOT NULL,
	author      	VARCHAR(128) NOT NULL,
	email       	VARCHAR(128) NOT NULL,
	website     	VARCHAR(128),
	subscribe   	SMALLINT NOT NULL,
	CONSTRAINT PK_COMMENTS PRIMARY KEY(comment_id,blog_id)
)
</cfquery> 

<cfquery datasource="blogrichard">
CREATE TABLE users  ( 
	user_id  	INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL,
	username 	VARCHAR(30) NOT NULL,
	password 	VARCHAR(128) NOT NULL,
	email    	VARCHAR(128) NOT NULL,
	firstname	VARCHAR(30) NOT NULL,
	lastname 	VARCHAR(30) NOT NULL,
	active   	SMALLINT NOT NULL,
	salt     	VARCHAR(36),
	CONSTRAINT PK_USER_ID PRIMARY KEY(user_id)
)
</cfquery> 

<cfquery datasource="blogrichard">
ALTER TABLE comments
	ADD CONSTRAINT FK_BLOG_COMMENTS
	FOREIGN KEY(blog_id)
	REFERENCES blog_entries(blog_id)
</cfquery> 

<cfquery datasource="blogrichard">
ALTER TABLE blog_entry_categories
	ADD CONSTRAINT FK_BLOG_ENTRY_CATEGORIES
	FOREIGN KEY(blog_id)
	REFERENCES blog_entries(blog_id)
</cfquery> 

<cfquery datasource="blogrichard">
ALTER TABLE blog_entry_categories
	ADD CONSTRAINT FK_CATEGORY_BLOG_ENTRIES
	FOREIGN KEY(cat_id)
	REFERENCES categories(cat_id)
</cfquery> 

<cfquery datasource="blogrichard">
ALTER TABLE blog_entries
	ADD CONSTRAINT FK_BLOG_ENTRIES_AUTHORS
	FOREIGN KEY(author_id)
	REFERENCES users(user_id)
</cfquery> 

<cfquery datasource="blogrichard">
	INSERT INTO users (username, password, firstname, lastname, email, active) VALUES ('admin', 'admin', 'Jason', 'Dean', 'jason@12robots.com', 1)
</cfquery> 

<cfquery datasource="blogrichard">
	INSERT INTO users (username, password, firstname, lastname, email, active) VALUES ('joeUser', 'password', 'Joe', 'User', 'joe@user.com', 1)
</cfquery>


<cfquery datasource="blogrichard">
	INSERT INTO blog_entries(title, date_created, body_text, views, author_id) VALUES ('My First Blog Post', #createODBCDateTime(dateAdd("d", -4, now()))#, 'This is my first blog post.  Soon it will be yours', 0, 1)
</cfquery>

<cfquery datasource="blogrichard">
	INSERT INTO blog_entries(title, date_created, body_text, views, author_id) VALUES ('My Second Blog Post', #createODBCDateTime(dateAdd("d", -2, now()))#, 'This is my second blog post.  Soon it will be yours', 0, 1)
</cfquery>

<cfquery datasource="blogrichard">
	INSERT INTO blog_entries(title, date_created, body_text, views, author_id) VALUES ('My Third Blog Post', #createODBCDateTime(now())#, 'This is my third blog post.  Are you getting the idea?', 0, 1)
</cfquery>

<cfquery datasource="blogrichard">
	INSERT INTO comments(comment_id, author, email, blog_id, date_created, body_text, subscribe) VALUES (1, 'Joe User', 'joe@user.com', 1, #createODBCDateTime(dateAdd("d", -4, now()))#, 'Hey admin. This is a really neat blog. I love your post.  Nice work', 1)
</cfquery>

<cfquery datasource="blogrichard">
	INSERT INTO comments(comment_id, author, email, blog_id, date_created, body_text, subscribe) VALUES (2, 'Admin', 'admin@thisblog.com', 1, #createODBCDateTime(dateAdd("d", -3, now()))#, 'Thanks Joe. Good to hear form you.', 0)
</cfquery>

<cfdbinfo datasource="blogrichard" type=Tables dbname=blog name=test>
<cfdump var=#test#>