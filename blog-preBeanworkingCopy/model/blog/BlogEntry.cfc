	<!------>
<cfcomponent accessors='true' displayname="BlogEntry" output="false" >
	<cfproperty name="id" type="numeric" default="" />
	<cfproperty name="title" type="string" default="" />
	<cfproperty name="body" type="string" default="" />
	<cfproperty name="publishDate" type="date" default="" />
	<cfproperty name="author" type="model.users.User" default="" />
	<cfproperty name="comments" type="array" default="" />
	
	
		<cffunction name="init" access="public" returntype="model.blog.BlogEntry" output="false" >
			
	<!--- 		<cfset setId(id) />
			<cfset setTitle(title) />
			<cfset setBody(body) />
			<cfset setPublishDate(now()) />
			<cfset setAuthor(author) /> --->
			<cfset setComments(ArrayNew(1)) />
			
			<cfreturn this />
			
		</cffunction>
		
		
		<cffunction name="addComment" access="public" returntype="void" output="false" >
			
			<cfset addComment() />
			
		</cffunction>
		
		
		<cffunction name="getCommentById" access="public" returntype="model.blog.Comment" output="false" >
			
			<cfset getCommentById() />
			
		</cffunction>
		
		
		<cffunction name="updateComment" access="public" returntype="void" output="false" >
			
			<cfset updateComment() />
			
		</cffunction>	
		
		
		<cffunction name="deleteComment" access="public" returntype="void" output="false" >
			
			<cfset deleteComment() />
			
		</cffunction>	
		
	
		<cffunction name="deleteCommentById" access="public" returntype="void" output="false" >
			
			<cfset deleteCommentById() />
			
		</cffunction>
		
		
		<cffunction name="publish" access="public" returntype="void" output="false" >
			
			<cfset setPublishDate(now()) />
		
		</cffunction>
	
	
	
</cfcomponent>
