<cfcomponent accessors='true' displayname="Comment" output="false" >
	<cfproperty name="id" type="numeric" default="" />
	<cfproperty name="firstname" type="string" default="" />
	<cfproperty name="lastname" type="string" default="" />
	<cfproperty name="email" type="string" default="" />
	<cfproperty name="username" type="string" default="" />
	<cfproperty name="password" type="string" default="" />
	<cfproperty name="active" type="boolean" default="" />
	
	<cffunction name="init" access="public" returntype="model.users.User" output="false" >
			
			<cfset setId(id) />
			<cfset setFirstname(firstname) />
			<cfset setLastname(lastname) />
			<cfset setEmail(email) />
			<cfset setUsername(username) />
			<cfset setPassword(password) />
			<cfset setActive(active) />
			
			<cfreturn this />
			
	</cffunction>

		<cffunction name="isLoggedIn" access="public" returntype="boolean" output="false" >
			
			<cfset isLoggedIn() />
			
		</cffunction>
		
		
		<cffunction name="isActive" access="public" returntype="boolean" output="false" >
			
			<cfset isActive() />
			
		</cffunction>


		<cffunction name="getDisplayName" access="public" returntype="string" output="false" >
			
			<cfset getDisplayName() />
			
		</cffunction>
		


</cfcomponent>