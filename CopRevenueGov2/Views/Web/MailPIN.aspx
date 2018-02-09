<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();

XmlDocument xmlReqDoc = new XmlDocument();
XmlDocument objReply = new XmlDocument();

protected void ispMailReply()
{
    string strLetter, strAddress, strSubject, strFileToSend, strMsg = string.Empty;

	strLetter = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "DATA", "", 0);
	strAddress = xmlProc.ispXmlGetFieldVal(xmlReqDoc, "ADDRESS", "", 0);

	strLetter = ispReplace(strLetter, "&GT&", ">");
	strLetter = ispReplace(strLetter, "&LT&", "<");
	strLetter = ispReplace(strLetter, "[EMAIL_CITY_SEAL]", CopMvcUtil.Session("EMAIL_CITY_SEAL"));
	strLetter = ispReplace(strLetter, "[EMAIL_SPACER]", CopMvcUtil.Session("EMAIL_SPACER"));

	CopRevenueGov2.Service.Persits_MailSender objEmail = (CopRevenueGov2.Service.Persits_MailSender)VB.CreateObject("Persits.MailSender");

		if (xmlProc.ispXmlGetFieldVal(xmlReqDoc, "FUNCTION", "", 0) == "COMMENT" )
         {
			string [] temp = CopMvcUtil.Session("EMAIL_COMMENTS_TO").Split(',');
            
			for(int i = 0; i< temp.Length; i++)
            {
				objEmail.AddAddress(temp[i]);
			}
                            
						
			temp = CopMvcUtil.Session("EMAIL_COMMENTS_TO").Split(','); //split(Session("EMAIL_COMMENTS_CC"), ",")
			for(int i = 0; i< temp.Length; i++)
            {
				objEmail.AddCC(temp[i]);
			}
			
			strSubject = "Comments and Feedback";	//'parent.$x.ispXmlGetFieldVal(xmlReqDoc, "SUBJECT", "", 0)
			strFileToSend = rev_func_srv.WriteEmailFile("Comments.htm", strLetter);
        }
		else
        {
			objEmail.AddAddress(strAddress);
			strSubject = "Taxpayer Information";  //'MUST HAVE UNDERSCORE
			if(xmlProc.ispXmlGetFieldVal(xmlReqDoc, "FUNCTION", "", 0) == "NEWREG")
            {
                strFileToSend = rev_func_srv.WriteEmailFile("NewReg.htm", strLetter);
            }
			else if(xmlProc.ispXmlGetFieldVal(xmlReqDoc, "FUNCTION", "", 0) == "NEWPIN" )
            {
				strFileToSend = rev_func_srv.WriteEmailFile("NewPin.htm", strLetter);
            }
			else if(xmlProc.ispXmlGetFieldVal(xmlReqDoc, "FUNCTION", "", 0) == "FORGOTPIN" )
            {
				strFileToSend = rev_func_srv.WriteEmailFile("ForgotPin.htm", strLetter);
            }
			else
            {
				strFileToSend = rev_func_srv.WriteEmailFile("Misc.htm", strLetter);
			}
		}

        
        objEmail.Host =ConfigurationManager.AppSettings["ServerName"].ToString();
        objEmail.From = ConfigurationManager.AppSettings["MailFrom"].ToString();
		objEmail.Subject = strSubject + " " + CopMvcUtil.Session("ENVIRONMENT");
		objEmail.Body = strLetter;
		objEmail.IsHTML = true;
		objEmail.Send();
	
	objEmail= null;
	
	xmlProc.ispXmlSetFieldVal(xmlReqDoc, strFileToSend, "DATA", "", 0);
	xmlProc.ispXmlSetFieldVal(xmlReqDoc, strMsg, "ADDRESS", "", 0);
}

    
    
protected string ispReplace(string sInput, string sFind, string sReplace)
{
	return sInput.Replace(sFind, sReplace);
}

</script>


<%

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/xml";

    rev_func_srv.CreateXmlBufferObj(xmlReqDoc, util.GetString(Request), false);

    ispMailReply();

    Response.Write( xmlProc.XMLToString(xmlReqDoc));
    Response.End();

%>
