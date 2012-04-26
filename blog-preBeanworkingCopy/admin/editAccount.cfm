<cfsilent>
	<!---	 sets variable existence	--->	
	<cfparam name="aErrors" default="#ArrayNew(1)#" />
	<cfparam name="aErrorsPW" default="#ArrayNew(1)#" />
	<cfparam name="Form.username" default="" />
	<cfparam name="Form.firstname" default="" />
	<cfparam name="Form.lastname" default="" />
	<cfparam name="Form.email" default="" />
	<cfparam name="Form.commit" default="" />
	
	<!---	initial load of zero "0" is set to facilitate form variable logic for variable persistence during validation and form processing	--->
	<cfparam name="Form.user_id" default="0" />
	<cfparam name="URL.user_id" default="" />
	<cfparam name="Form.userEditsubmit" default="" />
	<cfparam name="Form.bnsubmit" default="" />
	<cfparam name="Form.userSearch" default="" />
	<cfparam name="Form.userDeletesubmit" default="" />
	<cfparam name="URL.username" default="" />
	<cfparam name="Form.username" default="" />
	<cfparam name="userEdit" default="" />
	<cfparam name="blogAccountForm" default="" />
	
	<!--- sets up object (name & component path) to retrive variable persistence data via id specific query and form processing	
	<cfset objeditAccount = createObject("component","blog.model.users.UserGateway")/>--->
	
	
	
	<!--- retrive variable persistence data via id specific query (greater than "0" matches which were equal to the ID passed from userSearch.cfm URL pass ) and form processing	--->
	<cfif isNumeric(URL.user_id) AND URL.user_id GT 0 >
		
		<!--- sets retrived variable that was returned from id specific query (greater than "0" matches which were equal to the passed ID from userSearch.cfm URL pass) and for edit of user (form processing)	--->
		<cfset userEdit = application.daoUserGateway.usersBYID(URL.user_id)/>
		<cfif userEdit.recordcount GT 0>
			<cfset Form.username = userEdit.username/>
			<cfset Form.firstname = userEdit.firstname/>
			<cfset Form.lastname = userEdit.lastname />
			<cfset Form.email = userEdit.email />
			<cfset Form.commit = userEdit.active />
			
		<cfelse>
				<!--- not currently used --->
		</cfif>
	
	
	</cfif>
	
	
		
<!--- 
NAME: Rick Mooney
AUTHOR: moonlabsdevl
DESCRIPTION: ISTC-1210
CREATED:--->
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
	Account Admin
	</title>
	</head>
<body>
<!---	start of action confirmation	--->
<cfoutput>
<div  class="article">
			 <header class="headdim">

<img src="../resources/cf.png" alt="" />
  </header>
		<div  class="inner-article">
	<!--- this is where pass from editAccountProcess.cfm displays action confirmation for add/edit (future delete) starts  --->	
	<cfif IsDefined("confirmation") >
			<div Class="confirmation">
				<h1>User Confirmation:</h1>
					<!--- variable pass through logic determines detail of message--->
					<cfif This.editCheck EQ "editOKed"><h1>User account edit successful</h1></cfif>
					<cfif This.addCheck EQ "addOKed"><h1>Account creation successful!</h1></cfif>
					<dl>
		                 
						  <dt>Name:</dt>
		                    <dd>First: #Form.firstName# Last:  #Form.lastName#</dd>
		                  <dt>Email:</dt>
		                    <dd>#Form.eMail#</dd>
		                  <dt>Active:</dt>
		                    <dd>#Form.commit#</dd>
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
									<a href="../index.cfm">Home Page</a>
								</li>
							</ul>
						</div>
			</div>		
		<cfabort>
	</cfif>
<br />

</cfoutput>
<!--- end of action confirmation display --->
<cfoutput>

		
				 
	<!--- start of account edit form --->	

		<form class="Form" name="blogAccountForm" id="blogAccountForm" action="editAccountProcess.cfm"  method="post">
				
			<!---	change to hidden from text (helps determe logic and status during initial (create) edit, and future delete.)	
				Form variable place holder for form processing logic in "editAccountProcess.cfm"--->			
			<cfif URL.user_id GT 0 AND Form.user_id LT 1  >
					<label> <input type="hidden" name="user_id" value="#Trim(URL.user_id)#"/></label>	
			<cfelseif URL.user_id LT 1 AND Form.user_id GTE 1  >
					<label> <input type="hidden" name="user_id" value="#Trim(Form.user_id)#"/></label>
			</cfif>
				
			
								
			<fieldset class="myfieldset">
			
				<!--- logic style based on form status  --->
			    <legend><cfif URL.user_id GTE 1  OR Form.user_id GTE 1  >Update<cfelse>Create</cfif> Author Account</legend>
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
					<br>		
						<!--- Output on condition
							editAccountProcess (return) (array="#aErrors#" 
							Password specific (utility component return) array="#aErrorsPW#")	--->
						<div Class="asideError">
							<cfif ArrayLen(aErrors)OR ArrayLen(aErrorsPW )>				
								<cfif ArrayLen(aErrors)>
								    <p>* FORM ERRORS</p>
										<UL>	
											<cfloop array="#aErrors#" index="errorIndex">
												<li>#errorIndex#</li>
											</cfloop>
										</UL>	
								</cfif>
								<cfif ArrayLen(aErrorsPW )>
									<p>* PASSWORD DETAIL</p>
										<UL>
											<cfloop array="#aErrorsPW#" index="errorIndex">
												<li>#errorIndex#</li>
											</cfloop>
										</UL>
								</cfif>	
								
							</cfif>	
						</div>
					 <br />
		   			 <br />
					 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
				   <label>Username:
					<br><cfif URL.user_id GT 0 OR Form.user_id GT 0  >#Form.username#</cfif> 
						<input <cfif Form.user_id GT 0 OR URL.user_id GT 0> 
							type="hidden" 
							   <cfelse>
							 	type="text" value="#Form.username#" 
							   </cfif> 
								name="username" id="username"  size="60" maxlength="30"   placeholder="Enter Desired Username!" /></label>
					<br>
					
					
						 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
				    <label >First name:
					<br>
						<input  name="firstname" id="firstname" type="text" size="60" maxlength="30" autocomplete="on" value="#Form.firstname#" placeholder="Author's First Name!"/></label>
				    <br>
						 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
					<label>Last name:
					<br>
						<input  name="lastname" id="lastname" type="text" size="60" maxlength="30" autocomplete="on" value="#Form.lastname#" placeholder="Author's Last Name!"  /></label>
					<br>
						 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
				    <label>E-mail:
				     <br>
				    	<input name="email" id="email" type="text" size="60" maxlength="128" autocomplete="on" pattern="[A-Za-z0-9]\w{2,}@[A-Za-z0-9-]{3,}.[A-Za-z]{2,3}" value="#Form.email#" placeholder="Author's Email Address!"  /> </label>
					<br>
					
					 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
					<cfif Form.user_id GT 0 OR URL.user_id GT 0>
					<cfelse>
					<label>Password:
					</cfif> 
					    <br>
						<input <cfif Form.user_id GT 0 OR URL.user_id GT 0> type="hidden" 
							 	<cfelse>type="password" </cfif>  name="password" id="password"  size="60" autocomplete="on" placeholder="ENTER PASSWORD!"/></label>
					<br>
					 <!--- logic based display of default placeholder or passed data which is different for create or edit --->
					<cfif Form.user_id GT 0 OR URL.user_id GT 0>
					<cfelse> 
				    <label>Re-Enter Password:
					</cfif> 
				       <br />
					   <input <cfif Form.user_id GT 0 OR URL.user_id GT 0> type="hidden" 
					   			<cfelse> type="password"</cfif>   name="repassword" id="repassword" size="60" autocomplete="on" placeholder="RE-ENTER PASSWORD!" /></label>
				      <br />
			  
						<fieldset class="checkRadio" > <br />
							<legend >* Active </legend>
									 <!--- conditional display of radio buttons settings based on logic of default or passed data which is different for create or edit TRICKY!!!!!!!--->
								<label> 
									<input  type="radio" name="commit"  
									<cfif Form.user_id LTE 0 AND URL.user_id LTE 0>
										value="true"
									<cfelseif Form.user_id GT 0 OR URL.user_id GT 0>
										<cfif Form.commit EQ 1 >
											checked="checked" value="true"
										<cfelse>
											
											value="true"
										</cfif> 	
										
									</cfif> 			/> YES</label>
									

								<label> 
									<input type="radio" name="commit"  
									<cfif Form.user_id LTE 0 AND URL.user_id LTE 0>
										value="false"
									<cfelseif Form.user_id GT 0 OR URL.user_id GT 0>
										<cfif Form.commit EQ 0>
											checked="checked" value="false"
										<cfelse>
										
											value="false"
										</cfif>
									</cfif> 
												/> NO</label>
									 <br /> <br />
						
																				<!---		TESTING
																				<cfdump var="#userEdit#" >
																				<cfdump var="#blogAccountForm#" >--->
 							<!--- conditional display of buttons based on logic of default or passed data which is different for create or edit (future delete)--->		 
							<input <cfif URL.user_id GTE 1  OR Form.user_id GTE 1  >
							type="hidden" 
							<cfelse> 
								type="submit" 
								</cfif>
								name="bnsubmit" value="CREATE ACCOUNT" class="floatLeft"  />	
							
							<input type="hidden" name="userDeletsubmit" value="DELETE" class="floatLeft" />
						
							<input <cfif URL.user_id GTE 1  OR Form.user_id GTE 1  >
							type="submit"
							<cfelse>
								type="hidden" 
								 </cfif>
								 name="userUpdate"  value="UPDATE"  class="floatLeft"  />
				
					        <input <cfif URL.user_id GTE 1  OR Form.user_id GTE 1  >
							type="hidden" 
							<cfelse> 
								type="submit" 
								   </cfif>
								    name="userEditsubmit" value="EDIT USER" class="floatLeft" />

			 		<br />
					<br />
				
					<br />
		<!--- conditional redirect for user search if the user is not creating, and wanting to edit. --->			
		<cfif Form.user_id EQ 0  AND Form.bnsubmit EQ "search"  >		
	
			<cfinclude template="userSearch.cfm"/>	
		</cfif>	
				
			</fieldset>		
		</form>		
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
	

		<!------>
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