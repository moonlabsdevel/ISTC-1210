<cfcomponent displayname="BlogGateway">
	<!---	 	--->
	<cfset variables.datasource = ""/>
	
	
	<!---        --->
<cffunction name="init" access="public" returntype="model.blog.BlogGateway" output="false">
	<cfargument name="dsn" type="string" required="true" >
	
	
		<cfset variables.datasource = arguments.dsn/>
		<cfreturn this/>
	
</cffunction>	
	
<cffunction name="listblogEntries" access="public" returntype="Query" output="false"  >

	 <cfargument name="id" type="numeric" required="false" />		
	 	 <cfset LOCAL.user_ID_ON_author_ID = "" />
		 
			<cfquery name="user_ID_ON_author_ID"  datasource="#variables.datasource#">
				    SELECT FIRSTNAME, LASTNAME, BLOG_ID, TITLE, DATE_CREATED, BODY_TEXT, AUTHOR_ID
					  FROM USERS 
					  JOIN BLOG_ENTRIES
					    ON USERS.USER_ID = BLOG_ENTRIES.AUTHOR_ID
					    
					  	<cfif structKeyExists(ARGUMENTS,"id")>
					 		WHERE BLOG_ENTRIES.BLOG_ID = <cfqueryparam value="#trim(ARGUMENTS.id)#" cfsqltype="cf_sql_integer" />
					 	</cfif>
					 ORDER BY DATE_CREATED
			</cfquery>
			
       			<cfreturn  user_ID_ON_author_ID  />
</cffunction>

<cffunction name="blogEntriesBYID" access="public" returntype="any" output="false"  >
	 <cfargument name="id" type="numeric" required="true" />
	 	
	 	
    <cfreturn listblogEntries(ARGUMENTS.id) />
</cffunction>	 
	 
 <!---    
--->

<cffunction name="createBlogEntry" access="public" returntype="boolean" output="false">

	 <cfargument name="blog_Title" type="string" required="true" />
	 <cfargument name="date_created" type="date" required="true" />
	 <cfargument name="blog_bodyText"  type="string" required="true" />
	 <cfargument name="blog_Author_id" type="numeric"  required="true" />
	  	<cfargument name="blog_id" type="numeric"  required="true" />
	  <cfset LOCAL.createBlogEntryonAuthor_ID = "" />
	  
	 	<cfif arguments.blog_id EQ 0>
	 		
		 		<cfquery name="createBlogEntryonAuthor_ID" datasource="#variables.datasource#"  result="array" >
				  	 	INSERT 
						  INTO BLOG_ENTRIES
							      ( 
							      TITLE,
							      DATE_CREATED, 
							      AUTHOR_ID,  
							      BODY_TEXT 
							      )
						VALUES  (
									<cfqueryparam value="#arguments.blog_Title#" cfsqltype="cf_sql_varchar"/>,
									<cfqueryparam value="#arguments.date_Created#" cfsqltype="cf_sql_date"/>,
									<cfqueryparam value="#arguments.blog_Author_id#" cfsqltype="cf_sql_integer"/>,
									<cfqueryparam value="#arguments.blog_bodyText#" cfsqltype="cf_sql_varchar"/>					
								)
									
				</cfquery>
		<cfelse>
		
			<cfquery  result="array" datasource="#variables.datasource#">
				UPDATE BLOG_ENTRIES
				   SET  TITLE = <cfqueryparam value="#arguments.blog_Title#" cfsqltype="cf_sql_varchar"/>,
						DATE_CREATED = <cfqueryparam value="#arguments.date_Created#" cfsqltype="cf_sql_timestamp" />,
						AUTHOR_ID = <cfqueryparam value="#arguments.blog_Author_id#" cfsqltype="cf_sql_integer"/>,
						BODY_TEXT = <cfqueryparam value="#arguments.blog_bodyText#" cfsqltype="cf_sql_varchar"/>
				WHERE BLOG_ID = <cfqueryparam value="#arguments.blog_id#" cfsqltype="cf_sql_integer"/>
			</cfquery>
		</cfif>
		
		
	<cfreturn true />
	
</cffunction>
<!---    AND (editBlogEntryBlog_ID OR createBlogEntryonAuthor_ID)

--->
<!--- --->
<cffunction name="deleteBlogEntry" access="public" returntype="boolean" output="false">

	<cfargument name="blog_id" type="numeric"  required="true" />
	 	<cfset LOCAL.deleteBlogEntryonBlog_ID = "" />
		
		 	<cfquery name="deleteBlogEntryonBlog_ID" datasource="#variables.datasource#" >
				  	 	DELETE  
						  FROM BLOG_ENTRIES
	  					 WHERE BLOG_ID = <cfqueryparam value="#arguments.blog_id#" cfsqltype="cf_sql_integer"/>
				</cfquery>
		<cfreturn true />
	
</cffunction>


</cfcomponent>