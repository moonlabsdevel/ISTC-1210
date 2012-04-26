<cfparam name="getClientVariableList" default="" />

<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
	<head>
<meta name="title" content="MoonLabs Development Blog" />
<meta name="description" content="Exchange of information" />
<meta name="keywords" content=" Blog, MoonLabs, Rick Mooney, " />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
<link rel="icon" href="resources/ico.png" type="image/x-icon" />
<link href="css/blogStyle.css" type="text/css" rel="stylesheet" />
<script src="js/blogJS.js" type="text/javascript" ></script>
<script src="js/jquery-1.5.2.min.js/jquery-1.5.2.min.js" type="text/javascript"></script>
	
	
	
<cfoutput>	
	<title>
		#request.companyName#
	</title>
	</head>
<body>
<div class="article"> <!-- outer article -->	
 <header class="headdim">

<img src="./resources/cf.png" alt="" />
  </header>

	
	<div class="inner-article">	<!-- inner article -->	
		<div class="align">
			<div> <!-- content start -->
				
			</div> <!-- content end -->
				<div class="footernav">
					<ul>
						<li>
							<a href="admin/editBlogEntry.cfm">Add Blog</a>
						</li>
						<li>
							<a href="admin/editAccount.cfm">User Admin</a>
						</li>
						<li>
							<a href="admin/blogEntries.cfm">Blog List</a>
						</li>
						<li>
							<a href="./index.cfm">Home Page</a>
						</li>
					</ul>
					</div>		

	
	
				
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