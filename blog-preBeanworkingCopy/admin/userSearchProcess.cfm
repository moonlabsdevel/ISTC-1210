<cfsilent>
	<!---  ensures structor data is already passed and returns user to "userSearch.cfm"  if not  --->
	<cfset aErrors = ArrayNew(1)/>
	<cfif StructIsEmpty(Form)>
			<cfset arrayAppend(aErrors, "Please fill out form") />
				<cfinclude template="userSearch.cfm"/>
					<cfabort/>
	</cfif>
	<!---	sets variable existence	some are not currently used--->	
	<cfparam name="aErrors" default="#ArrayNew(1)#" />
	<cfparam name="Form.searchType"  default=""/>
	<cfparam name="Form.searchFor"  default=""/>
	<cfparam name="Form.user_id"  default=""  />
	<cfparam name="Form.userName"  default=""  type="string"/>
	<cfparam name="Form.firstName"  default="" type="string"/>
	<cfparam name="Form.lastName"  default=""  type="string"/>
	<cfparam name="Form.Email"  default="" type="string"/>
	<cfparam name="URL.user_id" default="" />
	<cfparam name="Form.userEditsubmit" default="" />
	<cfparam name="Form.bnsubmit" default="" />
	<cfparam name="Form.userSearch" default="" />
	<cfparam name="Form.userDeletesubmit" default="" />
										
</cfsilent>

<!---	sets error array and start of editBlogEntry validation	--->
<cfset aErrors = ArrayNew(1)/>

	<!---	start of user search validation based on selection of user	--->
	<cfif Form.searchType EQ "userName" AND NOT len(Form.searchFor)>
					<cfset arrayAppend(aErrors, "You must enter a username here!")/>	
				<cfelseif  Form.searchType EQ "userName" AND len(Form.searchFor)>
						<cfset srchtype="#Form.searchType#"/>
						<cfset srchfor="%#Form.searchFor#%"/>
					</cfif>
	<cfif Form.searchType EQ "firstName" AND NOT len(Form.searchFor)>
					<cfset arrayAppend(aErrors, "You must enter First name here!")/>	
				<cfelseif  Form.searchType EQ "firstName" AND len(Form.searchFor)>
						<cfset srchtype="#Form.searchType#"/>
						<cfset srchfor="%#Form.searchFor#%"/>
					
		</cfif>
	<cfif Form.searchType EQ "lastName" AND NOT len(Form.searchFor)>
	    	<cfset arrayAppend(aErrors, "You must enter Last name here!")/>
				<cfelseif  Form.searchType EQ "lastName" AND len(Form.searchFor)>
						<cfset srchtype="#Form.searchType#"/>
						<cfset srchfor="%#Form.searchFor#%"/>
		</cfif>
	<cfif Form.searchType EQ "eMail" AND NOT len(Form.searchFor)>
	    	<cfset arrayAppend(aErrors, "You must enter a Valid E-mail here!")/>
				<cfelseif  Form.searchType EQ "eMail" AND len(Form.searchFor)>
						<cfset srchtype="#Form.searchType#"/>
						<cfset srchfor="%#Form.searchFor#%"/>
		</cfif>
		
<!--- 	Checks for and appends errors for the error array "aErrors". Sets a local variables to be passed Form.searchType Form.searchFor to componet with the invoke method below. --->
<cfif ArrayLen(aErrors)>
	<!---	return errors if any exist to userSearch.cfm page	--->
	<cfinclude template="userSearch.cfm"/>
	<cfabort>
</cfif>
<cfset searchUsers = application.daoUserGateway.searchONusers(srchtype="#srchtype#", srchfor="#srchfor#")/>
	<!--- set and retrieves all created authors for selection based on search settings for user (edit)	
	<cfinvoke method="" component="UserGateway"   returnvariable="searchUsers" >
								
		<cfinvokeargument name="srchtype" value="#srchtype#"   />
		<cfinvokeargument name="srchfor" value="#srchfor#"    />
	
	</cfinvoke>--->
	
							<!---  passes back search result for user edit	 --->
<cfinclude template="userSearch.cfm" / >

<cfabort>


