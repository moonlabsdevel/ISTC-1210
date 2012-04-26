<cfsilent>
	<!---	sets variable existence  	--->
	<cfparam name="aErrors" default="#ArrayNew(1)#" />
	<cfparam name="aErrorsPW" default="#ArrayNew(1)#" />
	
    <cfparam name="URL.submitValue" default="delete"/>
	<cfparam name="deleteValue" default="delete"/>
	<cfparam name="editValue" default="edit"/>
	
 
			
<!--- 
NAME: Rick Mooney
AUTHOR: moonlabsdevel
DESCRIPTION: ISTC-1210
CREATED: Lists all bolgs allows selection of ADD, Edit, or Delete of entries
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
	Blog Listing
	</title>
	</head>
<body>
<div class="article">
		 <header class="headdim">

<img src="../resources/cf.png" alt="" />
  </header>
	<div class=" inner-article">	
	<!---	form set up to handle button submit for "adding new blog post"	--->
<cfoutput>
	<form class="Form" name="listblog_Entries" id="listblog_Entries"  action="editBlogEntry.cfm"  method="post">
				
		<fieldset class="myfieldset">
			<legend>Blog Entries</legend>
		<br/>
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
		<!--- table listing of "blogrichard BLOG_ENTRIES" table--->
			<br/><br/>
				<input type="submit" name="addBNsubmit" value="ADD" class="floatRight" /><br/><br/>
						<!---	--->
					<cfset getAllBlogEntries = application.daoBlogGateway.listblogEntries() />
						
					<cfset getmetaDataBlogEntries = getComponentMetaData('model.blog.BlogEntry') />
					<cfdump var="#getmetaDataBlogEntries#" >
					<cfset getmetaDataBlogGateway = getComponentMetaData('model.blog.BlogGateway') />
					<cfdump var="#getmetaDataBlogGateway#" >
						<table>
							<tr><th>TITLE</th><th>PUBLICATION DATE</th><th>AUTHOR</th><th>ACTION</th></tr> 
						<!--- cfloop: loops for each record of the query record set
								--->
								<cfloop query="getAllBlogEntries" >
						
										 <cfif CurrentRow MOD 2 IS 1>
											<cfset bgcolor="White">
										   <cfelse>
											<cfset bgcolor="cccccc">
										   </cfif>
							<tr bgcolor="#bgcolor#">
							<td >#getAllBlogEntries.TITLE#</td>
							<td>#DateFormat(getAllBlogEntries.date_Created, "mmm dd, yyyy")#</td>
							<td>#getAllBlogEntries.firstName# #getAllBlogEntries.lastName#</td>
							<td>
							<!---	allows selection and passing of selected query record for either edit or delete to editBlogEntry.cfm	--->
							<a href="editBlogEntry.cfm?blog_id=#getAllBlogEntries.blog_id#&submitValue=#URLEncodedFormat(trim(editValue))#" name="edit" id="edit"> edit	</a>
								
							
							<a href="editBlogEntry.cfm?blog_id=#getAllBlogEntries.blog_id#&submitValue=#URLEncodedFormat(trim(deleteValue))# " name="delete" id="delete" > delete </a> 

							
							</td>
							</tr> 
							</cfloop>
		
						</table>
		
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