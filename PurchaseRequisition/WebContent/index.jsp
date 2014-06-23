<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Hashtable,javax.naming.Context,javax.naming.NamingEnumeration,javax.naming.NamingException,javax.naming.directory.DirContext,javax.naming.directory.InitialDirContext,javax.naming.directory.SearchControls,javax.naming.directory.SearchResult,java.security.Principal,java.util.Enumeration,javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	       
		<script src="resources/sap-ui-core.js"
				id="sap-ui-bootstrap"
				data-sap-ui-libs="sap.ui.commons,sap.ui.ux3,sap.ui.table,sap.suite.ui.commons,sap.m"
				data-sap-ui-theme="sap_bluecrystal">
		</script>
		<!-- add sap.ui.table,sap.ui.ux3 and/or other libraries to 'data-sap-ui-libs' if required -->

		<script>
				<%
					if(request == null)
						System.out.println("Request is null");
					if(request.getHeaderNames() == null)	
						System.out.println("getUserPrincipal is null");
					else {
						Enumeration headerEnum = request.getHeaderNames();
						while(headerEnum.hasMoreElements()) {
							String name = (String) headerEnum.nextElement();
							System.out.println("Here " + name + " -- "+ (String) request.getHeader(name));
						//	System.out.println(request.getIntHeader("user-agent"));
							
						}
					}
					Cookie[] cook = request.getCookies();
					
					if(request.getRemoteUser() != null) 
						System.out.println("request.getRemoteUser() --> " + request.getRemoteUser());
					else 
						System.out.println("request.getRemoteUser() is null");	
					Principal p = request.getUserPrincipal();
					//String teId = p.getName();
    				String teId = (String) System.getProperty("user.name");
    				String lastName = "";
    				String firstName = "";
    				String emailAddress = "";
    				
					// Set up environment for creating initial context
				     Hashtable env = new Hashtable();
			
				     env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
			
				     // Connect to my domain controller
				     env.put(Context.PROVIDER_URL, "ldap://ldap.tycoelectronics.com:389");
				    
				     // Specify GSSAPI as the SASL provider
				     env.put(Context.SECURITY_AUTHENTICATION, "simple");
				     env.put(Context.SECURITY_PRINCIPAL, "hitesh.anand@te.com");
				    env.put(Context.SECURITY_CREDENTIALS, "Hituseju03");
			
				     try {
				           // Create the initial directory context
				          DirContext ctx = new InitialDirContext(env);
				         
				          // Create the search controls           
				          SearchControls searchCtls = new SearchControls();
				          
				          //Specify the attributes to return
				          String returnedAtts[]={"sn","givenName","mail"};
				          searchCtls.setReturningAttributes(returnedAtts);
				          
				          //Specify the search scope
				          searchCtls.setSearchScope(SearchControls.SUBTREE_SCOPE);
			
				          //specify the LDAP search filter
				          String searchFilter = "cn=" + teId;
			
				          //Specify the Base for the search
				          String searchBase = "dc=tycoelectronics,dc=com";
				          
				          
				          //initialize counter to total the results
				          int totalResults = 0;
			
			
				          // Search for objects using the filter
				          //NamingEnumeration answer = ctx.search(searchBase, searchFilter, searchCtls);
				          NamingEnumeration answer = ctx.search(searchBase, searchFilter, searchCtls);
				          
				          //Loop through the search results
				          while (answer.hasMoreElements()) {
				              SearchResult sr = (SearchResult)answer.next();
								
				               totalResults++;
				               
				               System.out.println(" Round " + totalResults);
				               
				               if(sr.getAttributes() != null) {
				               		if(sr.getAttributes().get("sn") != null)
				               			lastName = (String) sr.getAttributes().get("sn").get(); 
				               		if(lastName == null) {
				               			lastName = "";
				               		}
				               	
					               	if(sr.getAttributes().get("givenName") != null)
					               		firstName = (String) sr.getAttributes().get("givenName").get(); 
					               	if(firstName == null) {
					               		firstName = "";
					               	}
				               	
					               	if(sr.getAttributes().get("mail") != null)
					               		emailAddress = (String) sr.getAttributes().get("mail").get(); 
					               	if(emailAddress == null) {
					               		emailAddress = "";
					               	}
				               }
				               
			
				          }			
				          ctx.close();		
			
			
				         } catch (NamingException e) {
				        e.printStackTrace();
				         }
	
				%>
				
				sap.ui.localResources("purchaserequisition");
				var view = sap.ui.view({id:"idCreateReq1", viewName:"purchaserequisition.CreateReq", type:sap.ui.core.mvc.ViewType.JS});
				view.placeAt("content");
				
		</script>
		
		<script>
		function GetUserName() {
			alert('here1');
		    var wshell = ActiveXObject && new ActiveXObject("WScript.Shell");
		    alert('here2');
		    return wshell && wshell.ExpandEnvironmentStrings("%USERNAME%");
		    alert('here3');
		}
		</script>

	</head>
	<body class="sapUiBody" role="application">
		<form>
		<div id="content"></div>
		<input type="hidden" name = "teID" id = "teID" value="<%=teId %>" />
		<input type="hidden" name = "lastName" id = "lastName" value="<%=lastName %>" />
		<input type="hidden" name = "firstName" id = "firstName" value="<%=firstName%>" />
		<input type="hidden" name = "emailAddress" id = "emailAddress" value="<%=emailAddress %>" />
		<input type="hidden" name = "remoteUser" id = "remoteUser" value="<%=request.getRemoteUser() %>" />
		</form>
	</body>
</html>