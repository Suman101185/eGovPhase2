<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<% 
    Response.Write("<script>");
    Response.Write("var lMerchant_ID = " + COPSession.CC_Rev_MerchantID );
    Response.Write("var lBPT_SourceCodeIndex = " +  COPSession.CC_BPT_SourceCodeIndex);
    Response.Write("var lBPT_LicenseFee = " + COPSession.CC_BPT_LicenseFee);
    Response.Write("</script>");
%>