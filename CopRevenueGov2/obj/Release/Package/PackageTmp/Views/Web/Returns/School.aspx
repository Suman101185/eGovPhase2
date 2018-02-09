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
    <link href="../Content/Styles/framestyle.css" rel="stylesheet" type="text/css" />
 
    <script type="text/javascript" language="javascript" src="../Content/Scripts/JqueryMin.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispXmlProc.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispFunctions.js"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/ispCoupon.js"></script>
    <script src="../Content/Scripts/Accounting.js" type="text/javascript" language="javascript"></script>
    <script type="text/javascript" language="javascript" src="../Content/Scripts/jquery.browser.min.js"></script>
    
    <title></title>


</head>
<body>

    <%     

Html.RenderAction("SchoolThankYou", "Returns", new { id  = sCurrYear });
Html.RenderAction("Progress", "INC");

  if (sCurrYear == "2011")
  {
    Html.RenderAction("School2010", "Returns");
  }
  if (sCurrYear == "2012")
  {
    Html.RenderAction("School2011", "Returns");
  }
  if (sCurrYear == "2013")
  {
    Html.RenderAction("School2012", "Returns");
  }   
 
  if (sCurrYear == "2014")
  {
      Html.RenderAction("School2013", "Returns");
  }
  else if (sCurrYear == "2015")
  {
      Html.RenderAction("School2014", "Returns");
  }
  else if (sCurrYear == "2016")
  {
      Html.RenderAction("School2015", "Returns");
  }
  else if (sCurrYear == "2017")
  {
      Html.RenderAction("School2016", "Returns");
  }
  else if (sCurrYear == "2018")
  {
      Html.RenderAction("School2017", "Returns");
  }   
      
    %>
</body>
</html>

