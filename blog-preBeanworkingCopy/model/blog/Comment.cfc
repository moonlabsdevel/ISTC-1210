<cfcomponent accessors='true' displayname="Comment" output="false" >
	<cfproperty name="id" type="numeric" default="" />
	<cfproperty name="text" type="string" default="" />
	<cfproperty name="dateCreated" type="date" default="" />
	<cfproperty name="name" type="string" default="" />
	<cfproperty name="email" type="string" default="" />
	<cfproperty name="webSite" type="string" default="" />
	<cfproperty name="subscribe" type="boolean" default="" />
	
	<cffunction name="init" access="public" returntype="model.blog.Comment" output="false" >
			
			<cfset setId(id) />
			<cfset setText(text) />
			<cfset setDateCreated(dateCreated) />
			<cfset setName(name) />
			<cfset setEmail(email) />
			<cfset setWebSite(webSite) />
			<cfset setSubscribe(subscribe) />
			
			<cfreturn this />
			
		</cffunction>

</cfcomponent>