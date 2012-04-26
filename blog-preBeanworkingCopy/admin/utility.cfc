<cfcomponent>
 
<!---  I recommend placing this inside of a CFC and using it as a supporting function to your user registration or password change function, hence the access="private" --->
<cffunction name="checkPassword" access="public" returntype="array" hint="I check password strength and determine if it is up to snuff, I return an array of error messages">
    <!--- Accept username arg for comparing later in the function --->
    <cfargument name="usernameIn" required="true" type="string" hint="Send in username as string">
    <!--- Accept password argument, default to blank string should be ok cause it will fail all of the tests --->
    <cfargument name="passwordIn" required="true" default="" type="string" hint="Send in password as a string, default is a blank string, which will fail">
		<!--- 	<br /><br /><cfdump var="#PASSWORD#"/><br /><br />
			   <cfdump var="#arguments.passwordIn#"/><br /><br />
			   <cfdump var="#arguments.usernameIn#"/><br /><br />
 Initialize return variable --->
     	<cfset var aErrorsPW = ArrayNew(1) /> 		
   
    <!--- If the password is more than X and less than Y, add an error. You could make this two functions (one for the lower limit and one for the upper), but why bother, can your users count? --->
    <cfif Len(arguments.passwordIn) LT 8 OR Len(arguments.passwordIn) GT 25>
        <cfset ArrayAppend(aErrorsPW, "Your password must be between 8 and 25 characters long") />
    </cfif>
    
    <!--- Check for atleast 1 uppercase letter --->        
    <cfif NOT REFind('[A-Z]+', arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password must contain at least 1 uppercase letter") />
    </cfif>
    
    <!--- Check for atleast 1 lowercase letter --->
    <cfif NOT REFind('[a-z]+', arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password must contain at least 1 lowercase letter") />
    </cfif>
    
    <!--- Check for atleast 1 numeral --->
    <cfif NOT REFind('[0-9]+', arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password must contain at least 1 numeral") />
    </cfif>

    <!--- Check for one of the predfined special characters, you can add more by seperating each character with a pipe(|) --->
    <cfif NOT REFind("[^\w\d\s]+", arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password must contain at least 1 special character") />
    </cfif>

    <!--- Check to see if the password contains the username --->
    <cfif findNoCase(arguments.usernameIn, arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password cannot contain your username") />
    </cfif>
    
    <!--- Make sure password contains no spaces --->
    <cfif arguments.passwordIn CONTAINS " ">
        <cfset ArrayAppend(aErrorsPW, "Your password cannot contain spaces") />
    </cfif>
    
    <!--- Make sure password is not a date --->
    <cfif IsDate(arguments.passwordIn)>
        <cfset ArrayAppend(aErrorsPW, "Your password cannot be a date") />
    </cfif>

    <!--- return the array of errors. On the other end you can do a check of <cfif ArrayLen(aErrorsPW) EQ true>There are errors</cfif>
  	 <cfdump var="#aErrorsPW#"/><br /><br />		--->
   

    <cfreturn aErrorsPW />
	
</cffunction>

</cfcomponent>