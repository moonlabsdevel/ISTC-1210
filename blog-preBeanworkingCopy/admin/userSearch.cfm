<cfsilent>
<cfset aErrors = ArrayNew(1)/>
	<cfif StructIsEmpty(Form)>
			<cfset arrayAppend(aErrors, "Please fill out form") />
				<cfinclude template="editAccount.cfm"/>
					<cfabort/>
	</cfif>
	<!---	sets variable existence  	--->	
	<cfparam name="aErrors" default="#ArrayNew(1)#" />
	<cfparam name="Form.userEditsubmit" default="" />
	<cfparam name="Form.bnsubmit" default="" />
	<cfparam name="Form.userSearch" default="" />
	<cfparam name="Form.userDeletesubmit" default="" />
	<cfparam name="URL.user_id"  default=""  />
	<cfparam name="Form.user_id"  default=""  />
	<cfparam name="searchUsers"  default=""  />
	<cfparam name="Form.searchType"  default="" />
	<cfparam name="Form.searchFor"  default="" />
	<cfparam name="Form.userUpdate" default="" />	
	<cfparam name="recordcount"  default="" />
	

	
<!--- 
NAME: Rick Mooney
AUTHOR: moonlabsdevel
DESCRIPTION: ISTC-1210
CREATED:
cfsilent Suppresses output produced by CFML within a tag’s scope.--->

</cfsilent>
<!DOCTYPE HTML>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
	<head>
<meta name="title" content="TBD" />
<meta name="description" content="TBD" />
<meta name="keywords" content=" TBD, " />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<link href="../css/blogStyle.css" type="text/css" rel="stylesheet" />

	
	
	<title>
	USER SEARCH
	</title>
	</head>
<body>
<div class="article">
			 <header class="headdim">

<img src="../resources/cf.png" alt="" />
  </header>
	<div class=" inner-article">	
<cfoutput>

	<cfif  Form.userUpdate EQ "update" > 
	<!--- user search form begins --->
	<form class="Form" name="userSearch" action="userSearchProcess.cfm" method="post">
		
		<fieldset  class="myfieldset">
		    <legend>USER SEARCH</legend>
			<div class="fnav">
				<ul>
					<li>
						<a href="editBlogEntry.cfm">Add Blog</a>
					</li>
					<li>
						<a href="editAccount.cfm">User Admin</a>
					</li>
					<li>
						<a href="blogEntries.cfm">Blog List</a>
					</li>
					<li>
						<a href="../index.cfm">Home Page</a>
					</li>
				</ul>
				</div>	<br /><br /><br />
					<label   for="searchType" >Search On: </label>
						<select  autocomplete="on" id="searchType" name="searchType" style="size:35px;" >
							<option value="userName"    >Username</option>
							<option value="firstName"    >First Name</option>
							<option value="lastName" >Last Name</option>
							<option value="eMail" >Email</option>
							</select><br />
						<UL>
						<!--- errors returned from userSearchProcess.cfm --->
						<cfloop array="#aErrors#" index="errorIndex">
							<li>#errorIndex#</li>
						</cfloop>	
						</UL>	<br />
					      
				<label for="searchFor"> Search For
					<input autocomplete="on" type="text" id="searchFor" name="searchFor" value="" />
					</label> 
					<br /><p>% = Wildcard</p><br />
					
				<label>
					<input type="submit" name="bnsubmit" value="SEARCH" />
					</label> 
					<br /><br />
	
	
		<div class="fnav">
				<ul>
					<li>
						<a href="editBlogEntry.cfm">Add Blog</a>
					</li>
					<li>
						<a href="editAccount.cfm">User Admin</a>
					</li>
					<li>
						<a href="blogEntries.cfm">Blog List</a>
					</li>
					<li>
						<a href="../index.cfm">Home Page</a>
					</li>
				</ul>
				</div>
			</fieldset>
	</form>

		<!--- conditional display of search results will not show until greater than 1    --->
	<cfelseif Form.bnsubmit IS "search" AND searchUsers.recordcount GTE 1 >
	
	
		<form class="Form" name="userSelect" action="userSearchProcess.cfm" method="post">
				<br />
				<fieldset  class="myfieldset"><br /><br />
				    <legend>USER SEARCH</legend>
			<div class="fnav">
				<ul>
					<li>
						<a href="editBlogEntry.cfm">Add Blog</a>
					</li>
					<li>
						<a href="editAccount.cfm">User Admin</a>
					</li>
					<li>
						<a href="blogEntries.cfm">Blog List</a>
					</li>
					<li>
						<a href="../index.cfm">Home Page</a>
					</li>
				</ul>
				</div>					
				<br />
				
			<table>
				<p>Select ID for edit</p>
					<tr><th>ID</th><th>USERNAME</th><th>FIRST NAME</th><th>LAST NAME</th><th>EMAIL</th><th>ACTIVE</th></tr> 
							<!--- cfloop: loops for each record of the query record set --->
					 	
					<cfloop query="searchUsers">
												<!--- the expression "currentrow MOD 2" will evaluate 
												to false for each row whose number is evenly divisible by 2. --->			
											 <cfif CurrentRow MOD 2 IS 1>
												<cfset bgcolor="White">
											   <cfelse>
												<cfset bgcolor="cccccc">
											   </cfif>
					<tr bgcolor="#bgcolor#">
							<td ><a href="editAccount.cfm?user_ID=#URLEncodedFormat(Trim(searchUsers.user_id))#"> #searchUsers.user_id#</a></td><td >#searchUsers.userName#</td><td>#searchUsers.firstName#</td><td>#searchUsers.lastName#</td><td>#searchUsers.eMail#</td><td>#YesNoFormat(searchUsers.active)#</td></tr>  
						
					</cfloop>
					<!--- passes search result user id that will be edited to editAccount.cfm page via URL
						
							URLEncodedFormat: Generates a URL-encoded string replaces spaces with %20, and non-alphanumeric characters
							with equivalent hexadecimal escape sequences. Passes arbitrary strings within 
							a URL (ColdFusion automatically decodes URL parameters that are passed to a page).
		   					Trim: Removes leading and trailing spaces and control characters from a string.
					--->
				</table>
				
				
				<br />
			<div class="fnav">
				<ul>
					<li>
						<a href="editBlogEntry.cfm">Add Blog</a>
					</li>
					<li>
						<a href="editAccount.cfm">User Admin</a>
					</li>
					<li>
						<a href="blogEntries.cfm">Blog List</a>
					</li>
					<li>
						<a href="../index.cfm">Home Page</a>
					</li>
				</ul>
				</div>	
						</fieldset>
	</form>
	</cfif>		
	</div><!-- end of inner-article -->
	
		<div class="clr_bth"><!--Begin outer footer -->
		  		<footer>
		   
		    	
		   
					<div ><!-- begin inner footer -->
					<p>&nbsp;This Site Produced Exclusively for DCTC ISTC1210.&nbsp;&nbsp;
		 Contact
		 <a href="#request.companyContact#"> Moon Labs</a>
		 			</p>
					</div><!-- end of inner footer --> 
			
				</footer>
				<p class="copy"> #request.companyName#  Copyright &copy; #year(now())# &nbsp; #request.companyDomain# &nbsp;</p>
				
			</div><!-- end of outer footer -->
		</div><!-- end of outer article -->
</body>
</cfoutput>	
</html>