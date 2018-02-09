<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<%
//'EGOVWEB-74 Created 2011.03.29
string sCurrYear = string.Empty;
if(CopMvcUtil.GetString(this.Request.QueryString["y"]) == "")
{
	sCurrYear = DateTime.Now.Year.ToString();
}
else
{
	sCurrYear = CopMvcUtil.GetString(this.Request.QueryString["y"]);
}
%>

<html>
<head>
<title></title>
<link REL="stylesheet" TYPE="text/css" href="../../Content/Style/Font.css">
<link REL="stylesheet" TYPE="text/css" href="../../Content/Style/Object.css">
<script language="javascript" type="text/javascript" src="../../Content/Scripts/ispFunctions.js"></script>

<script language="javascript" type="text/javascript">
    var txtHeader = 'Taxpayer Information';
    var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
    var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';
    var sCurrYear = '<%= sCurrYear%>';
    var sFormXml = '<%= CopMvcUtil.Session("EOLFORMXML")%>';

    var negTaxDue = false;
    var gUserAddr = '<%=  CopMvcUtil.GetString(this.Request.ServerVariables["REMOTE_ADDR"]) %>';

</script>
<script language="javascript" type="text/javascript" src="../../Content/Scripts/Accounting.js"></script>


</head>
<body>

<%
     
    Html.RenderAction("AppHeader", "INC");
    
    Html.RenderAction("UOThankYou", "UO");
    
    Html.RenderAction("UOThankYou", "UO");
    
%>

    <script language="javascript" type="text/javascript" src="../../Content/Scripts/ispCoupon.js"></script>

<%
    
    Html.RenderAction("Progress", "INC");
    
    /*
    <!--#Include File="../../Inc/AppHeader.htm"-->
<!--#Include File="UO2011Form.htm"-->
<!--#Include File="UOThankYou.htm"-->
<!--#Include File="../../Inc/ispCoupon.js.htm"-->
<!--#Include File="../../Inc/Progress.htm"-->
     * */
    
    
               
%>


</body>
</html>
