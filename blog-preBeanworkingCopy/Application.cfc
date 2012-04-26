<!--- 
 Filename: Application.cfc (The "Application Component")
 Created by: Rick Mooney (rimoon7699@go.minneapolis.edu)
 Purpose: Sets "constant" variables and page reuse includes consistent 
--->
<cfcomponent>
	<!---sets Pseudo-constructor <cfset this.dataSource = "blogrichard" />--->
<cfset this.name="ricksBlog"/>

<cfset this.sessionManagement="true"  /> 
<cfset this.clientManagement="true"  /> 
<cfset this.clientStorage="Registry"  />
<cfset this.loginStorage="session"  /> 
<cfset this.scriptProtect="true"  />


<cfset this.customtagpaths=getDirectoryFromPath(getCurrentTemplatePath())& "sn_blog_tags/"/>
<cfset this.mappings["/admin"] = getDirectoryFromPath(getCurrentTemplatePath())& "admin" />

<cfset this.mappings["/model"] = getDirectoryFromPath(getCurrentTemplatePath())& "model" />


<!--- TEST SETTING --->
	<!--- applicationTimeout = #CreateTimeSpan(days, hours, minutes, seconds)# set to 3 days --->
<cfset this.applicationTimeout=createTimespan(0,0,0,20)/>	
	<!--- sessionTimeout = #CreateTimeSpan(days, hours, minutes, seconds)# set to 20 minutes--->
<cfset this.sessionTimeout=createTimeSpan(0,0,0,20)/>
 
<!--- PRODUCTION SETTING 
	<!--- applicationTimeout = #CreateTimeSpan(days, hours, minutes, seconds)# set to 3 days --->
<cfset this.applicationtimeout=createTimespan(3,0,0,0)/>	
	<!--- sessionTimeout = #CreateTimeSpan(days, hours, minutes, seconds)# set to 20 minutes--->
<cfset this.sessionTimeout=createTimeSpan(0,0,20,0)/>
--->

 



<!--- ON APPLICATION START,  STARTS --->
<cffunction name="onApplicationStart" access="public" returnType="void" output="false" >
	<!---  USE IN THE RESPECTIVE QUERY:  <cfset application.datasource = application.dsn/> --->
		
		<cfset application.dsn ="blogrichard" />
		<cfset application.datasource = application.dsn/>
		<cfset application.daoUserGateway = createObject("component", "model.users.UserGateway").init(application.datasource)/>
		<cfset application.daoBlogGateway = createObject("component", "model.blog.BlogGateway").init(application.datasource)/>
		
		
		</cffunction>

<!--- ON SESSION START,  STARTS --->
<cffunction name="onSessionStart" access="public" returnType="void" output="false" >
  
	  
	
	
	</cffunction>

<!--- ON REQUEST START, STARTS  --->
<cffunction name="onRequestStart" access="public" returnType="void" output="false" >
	<cfargument name="targetPage" type="string" />
	
		<cfif isDefined("URL.reinit")> 

			<cfset onApplicationStart() />

	  	</cfif>
	  	
		
	   <!--- Any variables set here can be used by all our pages <cfreturn true>--->
	 	
 			<cfset var request.companyName = "Moon Labs Development"/>
			<cfset var request.companyDomain = "www.moonlabsdevl.com"/>
			<cfset var request.companyContact = "rimoon7699@go.minneapolis.edu"/>  	   
 		
		<!---
		<cfset request.daoUser = createObject("component", "model.users.UserGateway").init(request.datasource)/>
		<cfset request.daoBlog = createObject("component", "model.blog.BlogGateway").init(request.datasource)/>
		--->
	</cffunction>


<!--- ON REQUEST END, STARTS  --->
<cffunction name="onRequestEnd" access="public" returnType="void" output="false" >
	
	
	
		
		</cffunction>

<!--- ON SESSION END, STARTS  --->
<cffunction name="onSessionEnd" access="public" returnType="void" output="false" >
	
	
	
	
	
	</cffunction>

<!--- Missing Template, STARTS: THIS ONLY SEEMS TO WORK FOR TEMPLATES THAT ARE AT THE SAME DIRECTORY LEVEL OR HAVE A CALL TO A PAGE AT THIS CFC LEVEL; CURIOUS BECAUSE THE DATA SOURCE WORKS FOR ALL LEVELS OF APP....?????? 
<cffunction name="onMissingTemplate" returnType="boolean" output="false" >
	<cfargument name="targetpage" type="string" required="true" />	  
	    <cflog type="information" application="true" file="#this.name#" text="Missing Template: #arguments.targetpage#"/>
	  <cflocation url="404.cfm?missingtemplate=#urlEncodedFormat(arguments.targetpage)#" addToken="false" />
	 
</cffunction>--->

<!--- ON APPLICATION END, STARTS --->
<cffunction name="onApplicationEnd"   access="public" returnType="void" output="false" >
	<cfargument name="applicationTime" required="true" type="date" />	  
	  



</cffunction>


<!---
    
    Create model.blog.BlogGateway

BlogGateway will have an init() constructor that takes in the DSN name, just like UserGateway

Populate model.users.UserGateway with all of your user-specific Query functions

Populate model.blog.BlogGateway with all of your blog-specific Query functions

You will refactor your application to use UserGateway and BlogGateway anywhere that you are currently using createObejct to instead use the cached singleton components,

Read chapters 1 & 2 of OO ColdFusion
--->





</cfcomponent>