<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<%
string rowColor = "White";
%>

<HTML>
<head> &nbsp; </head>
<BODY>

<TABLE width=10.5in>
	<TR>
		<TD><B>Server Variables</B></TD>
		<TD><B>Value</B></TD>
	</TR>
	<% foreach( string name in Request.ServerVariables){ %> 
	<%
     if( rowColor == "Cyan" )
     { 
         rowColor = "White";
     } 
     else
     { 
         rowColor = "Cyan";
     }
     %>
	<TR  bgcolor= <%= rowColor %>>
		<TD><B><%= name %></B></TD>
		<TD><%= Request.ServerVariables[name] %></TD>
	</TR>
	<% } %> 
</TABLE>
<BR>
<BR>

<TABLE width=10.5in>
	<TR>
		<TD><B>Session Variables</B></TD>
		<TD><B>Value</B></TD>
	</TR>
	<TR><TD><P><%= Session.Contents.Count %></P></TD>
		<TD></TD></TR>
	<% 
    foreach(string name in Session.Contents)
        { 
    %> 
	<%
        if(rowColor == "Red")
        {
            rowColor = "White";
        }
        else 
        {
        rowColor = "Red";
        }
    %>
	<TR  bgcolor= <%= rowColor%>>
		<TD><B><%= name %></B></TD>
		<TD><%= Session[name] %></TD>
	</TR>
	<% } %> 
</TABLE>

</BODY>
</HTML>
