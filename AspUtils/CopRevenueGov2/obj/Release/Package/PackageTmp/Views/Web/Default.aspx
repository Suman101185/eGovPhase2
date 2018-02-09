<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<% Response.Buffer = true; %>
<%
    Session["Redirect"] = "";
    if(Request.QueryString.Count != 0 )
    {
	    if(Request.QueryString["coupon"] == "yes")
        { 
			Session["Redirect"] = "COUPON";
        }
    }

  %>


<html>
<head>
<title><%= COPSession.TITLE %></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script id="clientEventHandlersJS" language="javascript" type="text/javascript">
<!--
    var DocHeight;

    var gTitle = '<%= COPSession.TITLE %>';
    var gEnvironment = '<%= COPSession.ENVIRONMENT %>';
    var gUserAddr = '<%  Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>';
    var gMerchant_ID = '<%= COPSession.CC_Rev_MerchantID %>';
    var gBPT_SourceCodeIndex = '<%= COPSession.CC_BPT_SourceCodeIndex %>';
    var gBPT_LicenseFee = '<%= COPSession.CC_BPT_LicenseFee %>';

    /*
    
    var agt = navigator.userAgent.toLowerCase()
    var is_major = parseInt(navigator.appVersion)
    
    if (agt.indexOf('msie') != -1 && agt.indexOf('opera') == -1) {		//Internet Explorer
        if(is_major == 4 && agt.indexOf('msie 5') != -1) {				//Version 5
        } else if (is_major == 4 && agt.indexOf('msie 5.5') != -1) {	//Version 5.5
        } else if (is_major == 4 && agt.indexOf('msie 6.') != -1) {		//Version 6.
        } else if (is_major == 4 && agt.indexOf('msie 7.') != -1) {		//Version 7.
        } else {
    //		document.location.href = 'browser.htm'
        }		//if
    } else {
        document.location.href = 'browser.htm'
    }		//if
    */

    /* temporarrily disable to work on Sunday
    var CurrDate = new Date()
    
    if ((CurrDate.getDay() == 0) &&
            (CurrDate.getHours() > 7 && CurrDate.getHours() < 14)) {
    
        document.location.href = 'maintenance.htm'
    }		//if
    */
    function window_onload() {
        MenuWin.height = Main.scrollHeight - 60;
    }


    //-->
</script>
</head>
<!--<frameset cols="156,*" frameborder="0" border="0" framespacing="0" id="Main">   <frameset rows="*,30"> 		<frame name="MenuWin" src="Menu/Menuasp" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0">    <frame name="IspWin" src="Is_Partner.htm" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" id="NavWin">	</frameset>  <frameset rows="64,*,00">    <frame name="HeaderWin" src="Header.asp" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" border="0" framespacing="0" id="HeaderWin">    <frame name="DocWin" src="Main.htm" scrolling="auto" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" id="DocWin">    <frame name="NavWin" src="Menu/Navigation.asp" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" id="NavWin">  </frameset>  <noframes>  <body bgcolor="#FFFFFF" LANGUAGE="javascript" onload="return window_onload()">  </body>  </noframes></frameset>-->

<frameset id="Main" rows="105,*" frameborder="0" border="0" framespacing="0" > 
  <frame tabindex="0" name="HeaderWin" id="HeaderWin" src="Header" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" border="0" framespacing="0" >
  <frameset name=MenuFrameSet cols="180,*"> 
	  <frameset rows="*,30"> 
			<frame tabindex="0" name="MenuWin" id="MenuWin" src="Menu/Menu" scrolling="auto" frameborder="0" noresize marginwidth="0" marginheight="0" >
			<frame name="IspWin" id="IspWin" src="Is_Partner" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" >
	  </frameset>
	  <frameset id="RightFrame" name="RightFrame" rows="*,34">
		<frame tabindex="0" name="DocWin" id="DocWin" src="Login/MainAsp" scrolling="auto" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" >
		<frame name="NavWin" id="NavWin" src="Menu/Navigation" scrolling="no" frameborder="0" noresize marginwidth="0" marginheight="0" framespacing="0" border="0" id="NavWin" tabIndex="-1" > 
  </frameset>
  <noframes>
  <body bgcolor="#FFFFFF" LANGUAGE="javascript" onload="return window_onload()">
  </body>
  </noframes>
</frameset>
</html>
