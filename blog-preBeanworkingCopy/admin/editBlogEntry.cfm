<cfsilent>
	<!---	 sets variables existence	--->
	<cfparam name="aErrors" default="#ArrayNew(1)#" />
	<cfparam name="FORM.blog_Title" default="Enter Desired Title" />
	
	<!---	Date auto load when creating new defaults to current for form date variable, variable persistence, validation and form processing	--->
	<cfparam name="FORM.date_Created" default="#now()#" />
	<cfparam name="FORM.blog_Author_id" default="" />
	<cfparam name="FORM.blog_bodyText" default="Blog text" />
	
	<!---	initial load of zero "0" is set to facilitate form variable logic for variable persistence during validation and form processing	--->
	<cfparam name="Form.blog_id" default="0" />
	
	<!---	edit or delete pass through which facilitates form variable logic, variable persistence, validation and for processing	--->
	<cfparam name="URL.blog_id" default="#Form.blog_id#" />
	
	<!--- sets up object (name & component path) to retrive variable persistence data via id specific query and form processing	
	<cfset gateway = createObject("component","UserGateway")/>--->
	
	<!--- retrive variable persistence data via id specific query (greater than "0" matches which were equal to the passed ID from blogEntries.cfm) and form processing	--->
	<cfif isNumeric(URL.blog_id) AND URL.blog_id GT 0>
		
		<!--- sets retrived variable that was returned from id specific query (greater than "0" matches which were equal to the passed ID from blogEntries.cfm) and for (delete or edit)form processing	--->
		<cfset post = application.daoBlogGateway.blogEntriesBYID(URL.blog_id)/>
		
		<cfif post.recordcount GT 0>
			<cfset FORM.blog_Title = post.title/>
			<cfset FORM.blog_Author_id = post.author_id/>
			<cfset FORM.date_Created = post.date_created />
			<cfset FORM.blog_bodyText = post.body_text />
		<cfelse>
			<cfset URL.blog_id = 0 />	
		</cfif>
		
	</cfif>
	<!--- more: sets variables existence	--->
	<cfparam name="Form.bnsubmit" default=""/>
	<cfparam name="Form.blog_id" default=""/>
	<cfparam name="Form.addBNsubmit" default=""/>
	<cfparam name="Form.deleteBnsubmit" default=""/>
	<cfparam name="Form.editBnsubmit" default=""/>	
	<cfparam name="URL.submitValue" default=""/>
	
	
	<!--- sets up (path & name) and retrieves all created authors for select option form auto load from query	--->

<cfset authorsOnUserID = application.daoUserGateway.getAuthors()/>

<!--- 
NAME: Rick Mooney
AUTHOR: moonlabsdevel
DESCRIPTION: ISTC-1210
CREATED:
--->
</cfsilent>

<!DOCTYPE HTML>
<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
	<head>
<meta name="title" content="TBD" />
<meta name="description" content="TBD" />
<meta name="keywords" content=" TBD, " />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<link rel="icon" href="../resources/ico.png" type="image/x-icon" />
<link href="../css/blogStyle.css" type="text/css" rel="stylesheet" />

	
	
	
	<title>
	Edit blog entry
	</title>
	</head>
<body>
<div class="article">
	 <header class="headdim">

<img src="../resources/cf.png" alt="" />
  </header>
	<div class=" inner-article">		
	
		<cfoutput>
			<cfif IsDefined("blog_Confirmation") >
				<!--- start of blog action confirmation entry form (style only)--->
				<form class="Form" name="blogEntryconfirmationForm" id="blogEntryconfirmationForm" action="editBlogEntry.cfm" method="post">
			
					<fieldset class="myfieldset">	
							<!--- this is where pass from editBlogEntryProcess displays action confirmation for add/delete/edit starts  --->	
							<div Class="confirmation">
								<h1>You Successfully Submitted request to: </h1>
								<!--- variable pass through logic determines detail of message--->
									<cfif Form.editBNsubmit EQ "edit"><br /><h1>EDIT</h1></cfif>	
					                 <cfif Form.deleteBNsubmit EQ "delete"><br /><h1>DELETE</h1></cfif>	
									 <cfif Form.addBNsubmit EQ "add"><br /><h1>ADD</h1></cfif>		
									<dl>
										<cfif Form.blog_id GT 0 >
											<dt>Blog id:</dt>
												<dd>#Form.blog_id#</dd>
										
										<cfelse>
													<dd></dd>
										</cfif>			
										<dt>Title:</dt>
					                    	<dd>#blog_Title#</dd>
						                <dt>Entry:</dt>
						                    <dd>#blog_bodyText#</dd>
						                <dt>On:</dt>
						                    <dd>#DateFormat(date_Created, "mmm dd, yyyy")#</dd>
									 	 <dt>at:</dt>
										 	 <dd>#timeFormat(date_created,"hh:mm T")#</dd>
					             
					                </dl>  		
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
											<a href="./index.cfm">Home Page</a>
										</li>
									</ul>
								</div>
				<br />
				
				</div>
					
				<br />
				</fieldset>
				</form>	
				
				<cfabort>
			</cfif>	
		</cfoutput>
								<!--- end of blog confirmation display --->
<cfoutput>	

		<!--- start of actual blog form --->
	<form class="Form" name="blogEntryForm" id="blogEntryForm" action="editBlogEntryProcess.cfm" method="post">
		<!---	change to hidden from text (helps determe logic and status during initial (create) edit, and delete.)	--->
		<input type="hidden" name="blog_id" value="#URL.blog_id#"/>
		<fieldset class="myfieldset">
			<!--- logic style based on form status  --->
			<legend> <cfif URL.blog_id EQ 0>Add/Create<cfelseif URL.blog_id  GTE 1 AND (URL.submitValue IS "edit" OR Form.editBnsubmit IS "edit")   >Edit <cfelse>Delete</cfif> Blog Entry</legend>
									<br>
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
							<br />	<!---	displays passed errors from "editBlogEntryProcess.cfm"	--->	
						<div Class="asideError">
								
							<cfif ArrayLen(aErrors)>
							    <p>* BLOG ENTRY ERRORS</p>
									<UL>	
										<cfloop array="#aErrors#" index="errorIndex">
											<li>#errorIndex#</li>
										</cfloop>	
										</UL>	
							</cfif>
						
						</div>
 </cfoutput>			
			<br />
<cfoutput >
	<br /><br />
	
			<label>Title:<br /><!--- display default placeholder etc or retrieved id match query result of edit/deleted blog entry --->
				<input name="blog_Title" id="blog_Title" type="text" size="40" maxlength="30" placeholder="Enter Desired Title" Required value="#FORM.blog_Title#"/>
			</label>
			<br />
		    
			<br />
			<label>Publish Date:<br /><!--- display current date or date of edit/deleted blog entry --->
				<input name="date_Created" id="date_Created" type="text" size="40" maxlength="30" autocomplete="on" pattern="^(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d$"   placeholder="eg. mm/dd/yyyy" Required value="#dateFormat(Form.date_created,"mm/dd/yyyy")#"/>
			</label>
		    <br />
			
			<br />
						
			<label>Author:
			<br /><!--- sets up (path & name) and retrieves all created 
							authors for select option form auto load from query	
						<cfinvoke component="UserGateway" method="getAuthors" returnvariable="authorsOnUserID">	--->
				<select name="blog_Author_id" id="blog_Author_id">
					<cfloop query="authorsOnUserID">
						
						<option   value="#authorsOnUserID.User_id# " <cfif FORM.blog_Author_id EQ authorsOnUserID.User_ID>selected="selected"</cfif>   >#authorsOnUserID.firstName#  #authorsOnUserID.lastName#</option>
						
					</cfloop>
				</select>
			</label>
			<br />
			 
			<br />
			<label>Body:
			<br /><!--- display default placeholder etc or retrieved id match query result of edit/deleted blog entry --->
				<textarea name="blog_bodyText"   id="blog_bodyText"   placeholder="Blog text"    rows="7" cols="60" value="blog_bodyText">#FORM.blog_bodyText#</textarea>    	
			</label>
			<br />	
			<br />
			<!--- logic conditional button displays add/edit/deleted blog entry --->
<input name="addBnsubmit"  class="floatleft"  <cfif Form.addBnsubmit IS NOT "add" AND (URL.submitValue IS "edit" OR URL.submitValue IS "delete") >type="hidden"<cfelse> type="submit" value="ADD"</cfif> />
<input name="editBnsubmit"  class="floatleft"  <cfif URL.submitValue IS NOT "edit" AND Form.editBnsubmit IS NOT "edit"  >type="hidden"<cfelse> type="submit" value="EDIT"</cfif> />		
<input name="deleteBnsubmit"  class="floatleft" <cfif URL.submitValue IS NOT "delete" AND Form.deleteBnsubmit IS NOT "delete" >type="hidden"<cfelse>type="submit" value="DELETE"</cfif>
	
		
		
<br /><br /><br />
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