sap.ui.jsview("purchaserequisition.CreateReq", {

	/** Specifies the Controller belonging to this View. 
	* In the case that it is not implemented, or that "null" is returned, this View does not have a Controller.
	* @memberOf purchaserequisition.CreateReq
	*/ 
	getControllerName : function() {
		return "purchaserequisition.CreateReq";
	},

	/** Is initially called once after the Controller has been instantiated. It is the place where the UI is constructed. 
	* Since the Controller is given to this method, its event handlers can be attached right away. 
	* @memberOf purchaserequisition.CreateReq
	*/ 
	createContent : function(oController) {
		
		
		var oTF2 = new sap.ui.commons.TextField({
			id : 'TF-HNum',
			tooltip : "dfd",
			editable : false,
			value : '10',
			width : '50px',
			maxLength : 5 });
		var obutton = new sap.ui.commons.Button({
			text : "Button",
	        tooltip : "This is a test tooltip",
	        press : function() {
		    alert('Hi ' + document.forms[0].lastName.value + ', ' + document.forms[0].firstName.value);
		    alert('Remote User ' + document.forms[0].remoteUser.value )
		    alert(new ActiveXObject("WScript.Network").UserName);
		    alert('Your Email Address : ' + document.forms[0].emailAddress.value + ' and TE id is : ' + document.forms[0].teID.value);
		    }
			
		})
		var oShell = new sap.ui.ux3.Shell("myShell", {
			appTitle: "Purchase Requisition",
			appIcon: "img/te-logo.png",
			appIconTooltip: "TE logo",
			showLogoutButton: false,
			showSearchTool: false,
			showInspectorTool: false,
			showFeederTool: false,
			worksetItems: [new sap.ui.ux3.NavigationItem("WI_home",{key:"wi_home",text:"Home"}),
			               new sap.ui.ux3.NavigationItem("WI_1",{key:"wi_1",text:"Examples", subItems:[
			                  new sap.ui.ux3.NavigationItem("WI_1_1",{key:"wi_1_1",text:"Text"}),
			                  new sap.ui.ux3.NavigationItem("WI_1_2",{key:"wi_1_2",text:"Button"}),
			                  new sap.ui.ux3.NavigationItem("WI_1_3",{key:"wi_1_3",text:"Image"})]}),
			               new sap.ui.ux3.NavigationItem("WI_API",{key:"wi_api",text:"API Documentation"})],
			paneBarItems: [ new sap.ui.core.Item("PI_Date",{key:"pi_date",text:"date"}),
			                new sap.ui.core.Item("PI_Browser",{key:"pi_browser",text:"browser"})],
			toolPopups: [new sap.ui.ux3.ToolPopup("contactTool",{
										title: "New Contact",
										tooltip: "Create New Contact",
										icon: "images/Contact_regular.png",
										iconHover: "images/Contact_hover.png",
										content:[new sap.ui.commons.TextView({text:"Here could be a contact sheet."})],
										buttons: [new sap.ui.commons.Button("cancelContactButton", {text:"Cancel",press:function(oEvent){
											sap.ui.getCore().byId("contactTool").close();
										}})]
									})],
			headerItems: [new sap.ui.commons.TextView({text:"User Name",tooltip:"U.Name"}),
			              new sap.ui.commons.Button({text:"Personalize",tooltip:"Personalize",press:function(oEvent){alert("Here could open an personalize dialog");}}),
										new sap.ui.commons.MenuButton({
											text: "Help",
											tooltip: "Help Menu",
											menu: new sap.ui.commons.Menu("menu1",{items:[
												new sap.ui.commons.MenuItem("menuitem1",{text:"Help"}),
												new sap.ui.commons.MenuItem("menuitem2",{text:"Report Incident"}),
												new sap.ui.commons.MenuItem("menuitem3",{text:"About"})]})
										})],
			worksetItemSelected: function(oEvent){
				var sId = oEvent.getParameter("id");
				var oShell = oEvent.oSource;
				switch (sId) {
				case "WI_home":
					oShell.setContent(oTF2);
					break;
				case "WI_1_1":
					oShell.setContent(obutton);
					break;
				case "WI_1_2":
					oShell.setContent(oTF2);
					break;
				case "WI_1_3":
					oShell.setContent(oTF2);
					break;
				case "WI_API":
					oShell.setContent(oTF2);
					break;
				default:
					break;
				}
			},
			paneBarItemSelected: function(oEvent){
				var sKey = oEvent.getParameter("key");
				var oShell = oEvent.oSource;
				switch (sKey) {
				case "pi_date":
					var oDate = new Date();
					oShell.setPaneContent(new sap.ui.commons.TextView({text:oDate.toLocaleString()}), true);
					break;
				case "pi_browser":
					oShell.setPaneContent(new sap.ui.commons.TextView({text:"You browser provides the following information:\n"+navigator.userAgent}), true);
					break;
				default:
					break;
				}
			},
			logout:function(){
				alert("Logout Button has been clicked.\nThe application can now do whatever is required.");
			},
		 	search:function(oEvent){
		 		alert("Search triggered: " + oEvent.getParameter("text"));
		 	},
		 	feedSubmit:function(oEvent){
		 		alert("Feed entry submitted: " + oEvent.getParameter("text"));
		 	},
		 	paneClosed : function(oEvent) {
		 	    alert("Pane has been closed: " + oEvent.getParameter("id"));
		 	}
		}).placeAt("content");
	}

});
