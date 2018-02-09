<%
Response.Write "<script>"
Response.Write "var lMerchant_ID = " & Session("CC_Rev_MerchantID")
Response.Write "var lBPT_SourceCodeIndex = " & Session("CC_BPT_SourceCodeIndex")
Response.Write "var lBPT_LicenseFee = " & Session("CC_BPT_LicenseFee")
Response.Write "</script>"
%>
