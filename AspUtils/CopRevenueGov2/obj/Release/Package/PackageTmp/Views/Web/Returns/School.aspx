<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<script runat="server">
</script>

<%
string sCurrYear = string.Empty;

if( CopMvcUtil.GetString(this.Request.QueryString["y"]) == "")
{
	sCurrYear = DateTime.Now.Year.ToString();
}
else
{
	sCurrYear = this.Request.QueryString["y"];
}

%>

<html>
<head>


<script type="text/javascript" language="javascript">

    var txtHeader = 'Taxpayer Information';
    var mToday = '<%= VB.FormatDateTime(DateTime.Now, 2)%>';
    var mTime = '<%= VB.FormatDateTime(DateTime.Now, 4)%>';

</script>

<link type="text/css" rel="Stylesheet" href="Content/Styles/Font.css" />
<link type="text/css" rel="Stylesheet" href="Content/Styles/Object.css" />
<script type="text/javascript" language="javascript" src="Content/Scripts/JqueryMin.js"></script>
<script type="text/javascript" language="javascript" src="Content/Scripts/ispXmlProc.js"></script>
<script type="text/javascript" language="javascript" src="Content/Scripts/ispFunctions.js"></script>
<script type="text/javascript" language="javascript" src="Content/Scripts/ispCoupon.js"></script>

<title></title>


</head>
<body>

<%
     
Html.RenderAction("AppHeader", "INC");
Html.RenderAction("SchoolThankYou", "Returns");
Html.RenderAction("Progress", "INC");
       
    
  if(sCurrYear == "2003")
  {
       Html.RenderAction("PageMaintenance", "Home");
  }
  else if (sCurrYear == "2004")
  {
      Html.RenderAction("PageMaintenance", "Home");
  }
  else if (sCurrYear == "2005")
  {
      Html.RenderAction("PageMaintenance", "Home");
  }
  else if (sCurrYear == "2006")
  {
      Html.RenderAction("PageMaintenance", "Home");
  }
  else if (sCurrYear == "2007")
  {
      Html.RenderAction("School2006", "Returns");
  }
  else if (sCurrYear == "2008")
  {
      Html.RenderAction("School2007", "Returns");
  }
  else if (sCurrYear == "2009")
  {
      Html.RenderAction("School2008", "Returns");
  }
  else if (sCurrYear == "2010")
  {
      Html.RenderAction("School2009", "Returns");
  }
  else if (sCurrYear == "2011")
  {
      Html.RenderAction("School2010", "Returns");
  }
  else if (sCurrYear == "2012")
  {
      Html.RenderAction("School2011", "Returns");
  }                
  else if (sCurrYear == "2013")
  {
      Html.RenderAction("School2012", "Returns");
  }  
  else if (sCurrYear == "2014")
  {
      Html.RenderAction("School2012", "Returns");
  }          
      
 %>
	
</body>
</html>

