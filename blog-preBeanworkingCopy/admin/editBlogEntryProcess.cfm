<cfsilent>
	
	<!---  ensures structor data is already passed and returns user to "editBlogEntry.cfm"  if not  --->
<cfset aErrors = ArrayNew(1)/>
	<cfif StructIsEmpty(Form)>
			<cfset arrayAppend(aErrors, "Please fill out form") />
				<cfinclude template="editBlogEntry.cfm"/>
					<cfabort/>
	</cfif>
	
<!---	sets variable existence	--->	
<cfparam name="Form.blog_Title" type="string" />
<cfparam name="Form.date_Created" type="string" />
<cfparam name="Form.blog_bodyText" type="string" />
<cfparam name="Form.blog_Author_id"/>
<cfparam name="Form.addBNsubmit" default=""/>
<cfparam name="Form.deleteBnsubmit" default=""/>
<cfparam name="Form.editBnsubmit" default=""/>	
<cfparam name="URL.submitValue" default=""/>
</cfsilent>

<!---	sets error array and start of editBlogEntry validation	--->				
<cfset aErrors = ArrayNew(1)/>

	<!---	start of validation for editBlogEntry form	--->	
	<cfif Form.blog_Title IS NOT "" AND IsValid( "String", Form.blog_Title )>
		<cfset blog_Title = trim(Form.blog_Title)/>
			<cfelse>
				<cfset arrayAppend(aErrors, "You must enter a title.")/>
	</cfif>		

	<cfif Form.date_created IS NOT "" AND IsValid("date" , Form.date_Created )>
		<cfset  date_Created = trim(CreateODBCDateTime(Form.date_Created))/>
			<cfelse>
				<cfset arrayAppend(aErrors, "You must enter a date to publish. mm/dd/yyyy")/>
	
	</cfif>

	<cfif Form.blog_Author_id IS NOT "" AND IsValid( "Numeric" , Form.blog_Author_id )>
		<cfset  blog_Author_id = trim(Form.blog_Author_id)/>
			<cfelse>
				<cfset arrayAppend(aErrors, "If Author has valid ID number. Contact system admin to correct database entry error. Please re-enter Data.")/>
	
	</cfif>
								<!--- TESTING
							<cfdump var="#URL.submitValue#"/>
							<cfdump var="#submitValue#"/>
							<cfdump var="#form#"/>
							<cfdump var="#URL#"/>
							 --->
							 
<!---	end of validation for editBlogEntry form and 
start of logic for continuation of process	--->
			 
<cfif ArrayLen(aErrors)>
	<!---	return errors if any exist to editBlogEntry form page	--->
	<cfinclude template="editBlogEntry.cfm"/>
	
		<!---	logic for processing of delete: sets object/component path: sets name for pass of argument (to component function call)and return of argument and action with passed data to editBlogEntry.cfm page (confirmation display)) <cfset objdeleteBlogEntry = createObject('component','UserGateway')/>--->
		<cfelseif Form.deleteBnsubmit EQ "delete" AND Form.blog_id GT 0>
			
			<cfset deleteBlogEntryonBlog_ID = application.daoBlogGateway.deleteBlogEntry(blog_id="#Form.blog_id#")/>
				<cfset blog_Confirmation="blog_EntryConfirmation" />
				<cfinclude template="editBlogEntry.cfm"/>	
				<cfabort>
				
		<!---	logic for processing of edit or add: sets object/component path: sets name for pass of arguments (to component function call)and return of arguments and action with passed data to editBlogEntry.cfm page (confirmation display)) <cfset objcreateBlogEntry = createObject('component','UserGateway') />--->		
		<cfelseif Form.editBnsubmit EQ "edit" OR Form.addBNsubmit EQ "add">
			
			<cfset createBlogEntryonAuthor_ID = application.daoBlogGateway.createBlogEntry(blog_Author_id="#Form.blog_Author_id#", blog_id="#Form.blog_id#",  blog_bodyText="#Form.blog_bodyText#",  date_Created="#date_Created#", blog_Title="#Form.blog_Title#") />
				<cfset blog_Confirmation="blog_EntryConfirmation" />
				<cfinclude template="editBlogEntry.cfm"/>	
				<cfabort>
</cfif>
<!---  end of logic for continuation of process	--->
