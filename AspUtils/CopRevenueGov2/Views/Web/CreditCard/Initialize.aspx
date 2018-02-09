<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%
     CopMvcUtil util = new CopMvcUtil();
    RevFuncSrv rev_func_srv = new RevFuncSrv();
    FuncSrv func_srv = new FuncSrv();
    XMLUtil xmlProc = new XMLUtil();
'Posting Page to post XML as text/xml
  dim m_objHTTPXML
  dim m_objXML
  dim sXML
        
  set m_objXML = Server.CreateObject ("MSXML.DOMDocument")
	
	if Request.QueryString("a") = "" then
		'Get out
	else
		m_objXML.LoadXML Request.QueryString("a")
	end if
      
'  m_objXML.Load request
'"https://mylocalgov.com/demophiladelphia/onlinepaymenttest.asp"		
  Set m_objHTTPXML = Server.CreateObject("Microsoft.XMLHTTP")
'Sending Order Acknowledgement
  m_objHTTPXML.open "POST", Session("CC_SiteName"), False
  m_objHTTPXML.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
  m_objHTTPXML.send(m_objXML.xml)
        
  Response.Write m_objHTTPXML.ResponseText


  Response.End
%>