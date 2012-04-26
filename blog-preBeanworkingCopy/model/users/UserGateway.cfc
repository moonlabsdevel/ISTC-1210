<cfcomponent displayname="UserGateway">
	<!---		--->
	<cfset variables.datasource = ""/>
	
	
	<!---	   --->
<cffunction name="init" access="public" returntype="model.users.UserGateway" output="false">
	<cfargument name="dsn" type="string" required="true" >
	
	
	
		<cfset variables.datasource = arguments.dsn/>
		<cfreturn this/>
	
</cffunction>	
	

<cffunction name="verify_Username" access="public" returntype="Query" output="false">
	
	 <cfargument name="userName" type="string" required="true" />
	 	 <cfargument name="id" type="numeric" required="false" />
	 	 <cfargument name="user_id" type="numeric" required="false" />
		  
			 <cfset LOCAL.usernameONuser = "" />
			  <cfquery name="usernameONuser" datasource="#variables.datasource#"  >
					SELECT USER_ID, USERNAME, EMAIL, FIRSTNAME, LASTNAME, ACTIVE
					  FROM USERS
	
					 WHERE UCASE(USERNAME) LIKE 
							UCASE(<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar"/>)
		   			</cfquery>
				 <cfreturn usernameONuser />
	
</cffunction>


<cffunction name="getAuthors" access="public" returntype="Query" output="false"  >
 	 
		 <cfargument name="id" type="numeric" required="false" />
		 
			  <cfset LOCAL.authorsOnUserID = "" />
				<cfquery name="authorsOnUserID" datasource="#variables.datasource#" >
					    SELECT USER_ID, USERNAME, EMAIL, FIRSTNAME, LASTNAME, ACTIVE  
						  FROM USERS
						  <cfif structKeyExists(ARGUMENTS,"id")>
						 WHERE USER_ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer"/> 
						  </cfif>  				 					 	
				</cfquery>
    <cfreturn authorsOnUserID />
</cffunction>
 
 <cffunction name="usersBYID" access="public" returntype="Query" output="false"  >
	 <cfargument name="id" type="numeric" required="true" />	
	 	
    <cfreturn getAuthors(ARGUMENTS.id) />
</cffunction>	
<!--- removed all datasource="blogrichard"
  
 --->
<cffunction name="create_User" access="public"   returntype="boolean" output="false">
	
 			 <cfargument name="user_id" type="numeric" required="false" /> 
			  
			 <cfargument name="userName" type="string" required="true" />
			 <cfargument name="passWord" type="string" required="false" />
			 <cfargument name="eMail"  type="string" required="true" />
			 <cfargument name="firstName" type="string" required="true" />
			 <cfargument name="lastName"  type="string" required="true" />
			 <cfargument name="isActive"  type="numeric" required="true" />
				
				
				<cfif arguments.user_id EQ 0> 
					<cfset LOCAL.createUser = "" />
				  	<cfquery name="createUser" datasource="#variables.datasource#" >
				  	  
				  	  	INSERT 
						  INTO USERS
						      (USERNAME, PASSWORD, EMAIL, FIRSTNAME, LASTNAME, ACTIVE)
						   
						VALUES  (
							
								 <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar"/>, 
								 <cfqueryparam value="#arguments.passWord#" cfsqltype="cf_sql_varchar"/>,
								 <cfqueryparam value="#arguments.eMail#" cfsqltype="cf_sql_varchar"/>,
					   			 <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar"/>,
								 <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar"/>,
								 <cfqueryparam value="#arguments.isActive#" cfsqltype="cf_sql_numeric" />)
											
				   		</cfquery>
				  	
					<cfelse>
						
						 <cfset LOCAL.editUser = "" />
						<cfif arguments.user_id GTE 1> 
							<cfquery name="editUser" result="editUser" datasource="#variables.datasource#">
								UPDATE USERS
								   SET  FIRSTNAME = <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar"/>,
										LASTNAME = <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar" />,
										EMAIL = <cfqueryparam value="#arguments.eMail#" cfsqltype="cf_sql_varchar"/>,
										ACTIVE = <cfqueryparam value="#arguments.isActive#" cfsqltype="cf_sql_numeric" />
								WHERE USER_ID = <cfqueryparam value="#arguments.user_id#" cfsqltype="cf_sql_integer"/>
								
							</cfquery>
						<!---	--->
						</cfif>	
				</cfif>
					 <cfreturn true />
</cffunction>

<cffunction name="searchONusers" access="public" returntype="Query" output="false"  >
		 	   				
	 	 <cfargument name="srchtype" type="string" required="true" />
		 <cfargument name="srchfor"  type="string" required="true" />
		 
			 <cfset LOCAL.searchUsers = "" />
				<cfquery name="searchUsers"  result="results"  datasource="#variables.datasource#" >
						SELECT USER_ID, USERNAME, FIRSTNAME, LASTNAME,  EMAIL, ACTIVE
						  FROM USERS
						 WHERE	
					<cfswitch expression="#arguments.srchtype#">
							<cfcase value="USERNAME">
								UCASE(FIRSTNAME) LIKE 
										UCASE(<cfqueryparam value="#arguments.srchfor#" cfsqltype="cf_sql_varchar"/>)
							</cfcase>
							<cfcase value="FIRSTNAME">
								UCASE(FIRSTNAME) LIKE 
										UCASE(<cfqueryparam value="#arguments.srchfor#" cfsqltype="cf_sql_varchar"/>)
							</cfcase>
							<cfcase value="LASTNAME">
								UCASE(LASTNAME) LIKE 
										UCASE(<cfqueryparam value="#arguments.srchfor#" cfsqltype="cf_sql_varchar"/>)
							</cfcase>
							<cfcase value="EMAIL">
								UCASE(EMAIL) LIKE 
										UCASE(<cfqueryparam value="#arguments.srchfor#" cfsqltype="cf_sql_varchar"/>)
							</cfcase>
					</cfswitch>
				</cfquery>
	    	<cfreturn searchUsers />
 </cffunction>

</cfcomponent>