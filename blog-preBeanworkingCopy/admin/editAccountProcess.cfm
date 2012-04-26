<cfsilent>
<cfset aErrors = ArrayNew(1)/>
	<cfif StructIsEmpty(Form)>
			<cfset arrayAppend(aErrors, "Please fill out form") />
				<cfinclude template="editAccount.cfm"/>
					<cfabort/>
	</cfif>
		
<cfparam name="Form.username" type="string" />
<cfparam name="Form.firstname" type="string" />
<cfparam name="Form.lastname" type="string" />
<cfparam name="Form.email" default="#Form.email#" />
<cfparam name="Form.password" type="string" />
<cfparam name="Form.repassword" type="string" />
<cfparam name="Form.user_id" default=""   />
<cfparam name="URL.user_id" default="" />
<cfparam name="Form.userEditsubmit" default="" />
<cfparam name="Form.bnsubmit" default="" />
<cfparam name="Form.userSearch" default="" />
<cfparam name="Form.userDeletesubmit" default="" />

<cfparam name="This.addCheck" default="" />
<cfparam name="This.editCheck" default="" />

<cfparam name="userEdit" default="" />
<cfparam name="blogAccountForm" default="" />
<cfparam name="Form" default="" />
<cfparam name="aErrorsPW" default="#ArrayNew(1)#" />



</cfsilent>
																<!--- <	 testing
																  cfdump var="#Form#" >
																--->
																
<!---	sets error array and start of editAccount validation	--->							
<cfset aErrors = ArrayNew(1)/> 


<!---	start of conditional validation for editAccount based on edit or create/add of user	--->			
	<cfif  Form.user_id LT 1 AND Form.bnsubmit IS "CREATE ACCOUNT" >
					
				<cfif Form.username IS NOT "" and IsValid("String", Form.username)>
					<!---	sets object/component path: sets name for pass of arguments (to component function call)and return of argument result for duplicate check 	
					<cfset objverifyUsername = createObject('component','UserGateway') />--->
					<cfset usernameONuser = application.daoUserGateway.verify_Username(userName ="#Form.username#") />	
						<!---	check for duplicate username: y/n --->					
						<cfif usernameONuser.userName EQ Form.username>
							<cfset arrayAppend(aErrors, "SORRY! Your username is already in use please try a new one!")/>
						</cfif>
					
				<cfelse>
					<cfset arrayAppend(aErrors, "You must enter User name.")/>
				</cfif>
		
				<cfif Form.firstname IS NOT "" AND IsValid( "String", Form.firstname )>
					<cfset firstName = trim(Form.firstname)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter First name.")/>
								
				</cfif>		
			
				<cfif Form.lastname IS NOT "" AND IsValid( "String", Form.lastname )>
					<cfset lastName = trim(Form.lastname)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter Last name.")/>
				
				</cfif>
				
				<cfif Form.email IS NOT "" AND IsValid(  "email" , Form.email )>
					<cfset eMail = trim(Form.email)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter a Valid E-mail.")/>
										
				</cfif>
					
				<cfif trim(Form.password) IS "" OR trim(Form.repassword) IS  "">
					<cfset arrayAppend(aErrors, "Your Password is empty, please re-enter!")/>	
							
				<cfelseif Form.password EQ Form.repassword>
					<cfset objverifyPassword = createObject('component','utility') />
					<cfset aErrorsPW = objverifyPassword.checkPassword(usernameIn ="#Form.username#", passwordIn="#Form.password#" ) />	
						<cfelse>		
							<cfset arrayAppend(aErrors, "Your Passwords do not match, please re-enter!")/>	
					
				</cfif>
					<!---TEST true = yes and false equals no	--->
					
				<cfif IsDefined("Form.commit")>
					<cfif Form.commit EQ "TRUE">
						<cfset ACTIVE="1"/>
					<cfelseif Form.commit EQ "FALSE">
						<cfset ACTIVE="0"/>
					</cfif>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must select Active Yes or No.")/>
					
				</cfif>
				<cfset This.addCheck = "addOKed">	
     
     <!---	additional conditional validation logic which re-directs to userSearch when new account is not being accomplished --->
     <cfelseif Form.userEditsubmit IS "EDIT USER" AND Form.user_id LTE 0>	
		<cfinclude template="userSearch.cfm"/>			
			<cfabort>
	<!---	additional conditional validation logic which once userSearch has returned a selection for user "edit is accomplished" --->
	<cfelseif Form.userUpdate IS "UPDATE" AND Form.user_id GTE 1>
	
				<cfif Form.firstname IS NOT "" AND IsValid( "String", Form.firstname )>
					<cfset firstName = trim(Form.firstname)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter First name.")/>
								
				</cfif>		
			
				<cfif Form.lastname IS NOT "" AND IsValid( "String", Form.lastname )>
					<cfset lastName = trim(Form.lastname)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter Last name.")/>
				
				</cfif>
				
				<cfif Form.email IS NOT "" AND IsValid(  "email" , Form.email )>
					<cfset eMail = trim(Form.email)/>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must enter a Valid E-mail.")/>
										
				</cfif>	
				
					<cfif IsDefined("Form.commit")>
					<cfif Form.commit EQ "TRUE" OR Form.commit EQ "1">
						<cfset ACTIVE="1"/>
					<cfelseif Form.commit EQ "FALSE" OR Form.commit EQ "0">
						<cfset ACTIVE="0"/>
					</cfif>
						<cfelse>
							<cfset arrayAppend(aErrors, "You must select Active Yes or No.")/>
					
					</cfif>	
				<cfset This.editCheck = "editOKed">	
														
	</cfif>	
<!---	end of conditional validation for editAccount form and 
start of logic for continuation of process	--->	

<cfif ArrayLen(aErrors)OR ArrayLen(aErrorsPW )>
	<!---	return errors if any exist to editAccount.cfm page	--->
	<cfinclude template="editAccount.cfm"/>

	<!---	logic for processing of create/add user: sets object/component path: sets name for pass of arguments (to component function call)and return of argument and action with passed data to "editAccount.cfm" page (confirmation display)) <cfset objaddNewUser = createObject('component','UserGateway') />--->
	<cfelseif (Form.user_id LT 1 OR URL.user_id GTE 1) AND This.addCheck EQ "addOKed">
			<cfset Form.user_id = 0> 
    		<cfset confirmation="confirmed" />
			
			<cfset createUser = application.daoUserGateway.create_user(user_id="#Trim(Form.user_id)#",userName ="#Form.username#", passWord="#Form.password#", eMail ="#Form.email#", firstName="#Form.firstname#", lastName="#Form.lastname#", isActive="#ACTIVE#" ) />	
				<cfinclude template="editAccount.cfm"/>	
					<cfabort>
	<!---	logic for processing of edit/update user: sets object/component path: sets name for pass of arguments (to component function call)and return of argument and action with passed data to "editAccount.cfm" page (confirmation display)) <cfset objeditUser = createObject('component','UserGateway') />--->
	<cfelseif Form.userUpdate IS "UPDATE" AND Form.user_id GTE 1 AND This.editCheck EQ "editOKed" >
    		<cfset confirmation="confirmed" />
			
			<cfset editUser = application.daoUserGateway.create_User(user_id="#Trim(Form.user_id)#", userName ="#Form.username#", eMail ="#Form.email#", firstName="#Form.firstname#", lastName="#Form.lastname#", isActive="#ACTIVE#" ) />
																							<!---TESTING 	
																							<cfdump var="#editUser#"/> 	
																			  				<cfdump var="#create_User#"/> 
																 							<cfdump var="#editUser#"/>	--->
				<cfinclude template="editAccount.cfm"/>	
					<cfabort>
</cfif>
<!---  end of logic for continuation of process	--->