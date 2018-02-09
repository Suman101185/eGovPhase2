<%@ Language=VBScript %>

<%
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

'Writing our javascript to the page
'	Response.Write "<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>" & vbcrlf
'	Response.Write "<!--" & vbcrlf
'	Response.Write "//Var for MyLocalGov to store returning XML into" & vbcrlf
'	Response.Write "var mlgCCXML = new ActiveXObject('MSXML.DOMDocument')" & vbcrlf

'	Response.Write "function window_onunload() {" & vbcrlf
'	Response.Write "	if (mlgCCXML.xml == '') {" & vbcrlf
'	Response.Write "		mlgCCXML.loadXML('<data>Padded data from Revenue, Not MyLocalGov</data>')" & vbcrlf
'	Response.Write "	}		//if" & vbcrlf
'	Response.Write "	opener.parent.DocWin.DisplayCCxml()" & vbcrlf
'	Response.Write "	opener.parent.DocWin.ispHideProgress()" & vbcrlf
''	Response.Write "	window.close()" & vbcrlf
'	Response.Write "}		//window_onunload" & vbcrlf


'	Response.Write "//-->" & vbcrlf
'	Response.Write "</SCRIPT>" & vbcrlf

''	Response.Write m_objXML.xml
  Response.End
%>
