<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>
<!--#include file=../../inc/ispXmlProcSrv.js.htm -->
<!--#include file=../../inc/ispFunctionsSrv.vb.htm -->
<!--#include file=../../inc/ispRevFuncSrv.vb.htm -->
<%

with Response
	.CacheControl = "no-cache"
	.AddHeader "Pragma", "no-cache"
	.Expires = 0
	.ContentType = "text/xml"
end with

dim msApp
msApp = "ER"

dim a, i, j, k, lComplexNode, lSimpleNode, lStrExport, lStrTemp, lLen
dim xmlTmplDoc, xmlReqDoc, strBufferv, gsDebug, gsDebugUp, xmlOut
dim objERNReturn, objEmail
dim sma, eERN, page1, inAcctNo, lsFunction
'on error resume next

CreateXmlBufferObj xmlOut, Server.MapPath("..\..\xml\ERNReturn.xml"), false
CreateXmlBufferObj xmlReqDoc, Request, false
inAcctNo = ispXmlGetFieldVal(xmlReqDoc, "ERN_INFO/ACCOUNT_ID", "", 0)
lsFunction = ispXmlGetFieldVal(xmlReqDoc, "ERN_INFO/RETURN_STATUS", "", 0)

set objERNReturn = CreateObject("EOL.ERNForm")
if objERNReturn is nothing then
	DoError "ERNReturn", "5030001", "", _
			"Object not loaded: 'EOL.ERNForm'", xmlOut, msApp
end if
objERNReturn.ServerAddress = Session("SagAddress")

CallRTTIE028

if ispXmlGetFieldVal(xmlOut, "ERN_INFO/ACCOUNT_ID", "", 0) = "" then
	ispXmlSetFieldVal xmlOut, inAcctNo, "ERN_INFO/ACCOUNT_ID", "", 0
end if

ispXmlSetFieldVal xmlOut, lsFunction, "ERN_INFO/RETURN_STATUS", "", 0

LogInformation xmlOut, msApp, "Response"
ispXmlSetFieldVal xmlReqDoc, gsDebugUp, "DEBUG", "", 0

WriteDebugFile session("AccNum") & "." & msApp & ".debug.txt", _
		"<DEBUGINFO>" & vbCrLf & "<REQUSET>" & Replace(xmlReqDoc.xml, "<?xml version=""1.0""?>", "") & "</REQUSET>" _
		& vbCrLf & vbCrLf & vbCrLf & _
		"<RESPONSE>" & Replace(xmlOut.xml, "<?xml version=""1.0""?>", "") & "</RESPONSE>" & vbCrLf & "</DEBUGINFO>"

ExitAsp

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub ExitAsp()

	set objERNReturn = nothing
	set objEmail = nothing
	set xmlOut = nothing
	set xmlTmplDoc = nothing
	set xmlReqDoc = nothing

	Response.End
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub CallRTTIE028()
	dim bLoop, sXMLData, lXML, lBufferArea, iTry
	on error resume next

	sma = Space(79)

	BR_PopulateBuffer xmlReqDoc, "ERN_INFO", eERN
	BR_PopulateBuffer xmlReqDoc, "ERN_PG1", page1	
	
	bLoop = false
	
	iTry = 0

	do
		a = objERNReturn.RTTIE028(sma, eERN, page1)
	'test
	'Response.Write xmlOut.xml
	'Response.End
	'

		if objERNReturn.ErrorNumber = 148 then
		
		elseif objERNReturn.ErrorNumber <> 0 then
			DoError "ERNReturn", "5030003:" & objERNReturn.ErrorNumber, _
					"", "SAG: " & objERNReturn.ErrorMessage, xmlOut, msApp

			bLoop = true
		else
			bLoop = true
			iTry = 0
		end if
		iTry = iTry + 1
	loop until bLoop = true or iTry = 5
'Response.Write "<xml>" & sma & "</xml>"
'Response.End		
'Err.Description
	if iTry = 5 then
		DoError "ERNReturn", "5030004", "", _
				"SAG: Mainframe is busy, Submit again...", xmlOut, msApp
	end if

	if objERNReturn.ErrorNumber = 0 then	
		populateXML "ERROR_INFO", sma, xmlOut, xmlOut
		populateXML "ERN_INFO", eERN, xmlOut, xmlOut			
		populateXML "ERN_PG1", page1, xmlOut, xmlOut	
	end if	

	ispXmlSetFieldVal xmlOut, sma & eERN & page1, "DEBUG", "", 0	
	
	Response.Write xmlOut.xml
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Sub BR_PopulateBuffer(oXML, sSection, vData)
dim i, j, k, lTmplXML, lChildNode, sTemp, sData, liSectCounter
dim lYear, lMonth, lDay
'on error resume next

	set lTmplXML = Server.CreateObject("Microsoft.XMLDOM")

	lTmplXML.loadXML(ispXmlGetRecordXml(oXML, sSection, 0))
	liSectCounter = ispXmlGetRecCount(OXML, sSection, "")
	for j = 0 to lTmplXML.documentElement.getAttributeNode("OCCURS").text - 1
		sTemp = ""
		sData = ""
		if j => liSectCounter then
			sData = sData & space(lTmplXML.documentElement.getAttributeNode("LENGTH").text)
		else
			for k = 0 to lTmplXML.documentElement.childNodes.length - 1
				set lChildNode = lTmplXML.documentElement.childNodes.item(k)
				sTemp = ucase(trim(oXML.documentElement. _
						getElementsByTagName(sSection).item(j) _
						.childNodes.item(k).text))
				if lChildNode.attributes.getNamedItem("TYPE").text = "N" then
					stemp = Replace(stemp, ".", "")
					sData = sData & string(lChildNode.attributes.getNamedItem("LENGTH").text - len(sTemp),"0") _
							& sTemp
				elseif  lChildNode.attributes.getNamedItem("TYPE").text = "C" then
'					if IsNumeric(sTemp) then
'						if sTemp <> 0 then
							stemp = Replace(stemp, ".", "")
							stemp = Replace(stemp, ",", "")
							stemp = Replace(stemp, "$", "")
'							sTemp = mid(FormatCurrency(sTemp, 2, false, false,  0), 0)
'						end if
'					end if
					sData = sData & string(lChildNode.attributes.getNamedItem("LENGTH").text - len(sTemp),"0") _
							& sTemp
'					sData = sData & sTemp _
'							& space(lChildNode.attributes.getNamedItem("LENGTH").text - len(sTemp))
				elseif  lChildNode.attributes.getNamedItem("TYPE").text = "D" then
					if IsDate(sTemp) then
						lYear = Year(stemp)
						lMonth = Month(stemp)
						lDay = Day(stemp)
							
						if len(lYear) < 4 then
							if lYear < 20 then
								lYear = "20" & lYear
							else
								lYear = "19" & lYear
							end if
						end if
							
						if len(lMonth) < 2 then
							lMonth = "0" & lMonth
						end	if
							
						if len(lDay) < 2 then
							lDay = "0" & lDay
						end	if
						sTemp = lYear & lMonth & lDay
					else
						sTemp = ""
					end if
					sData = sData & sTemp _
							& space(lChildNode.attributes.getNamedItem("LENGTH").text - len(sTemp))
				else
					sData = sData & sTemp _
							& space(lChildNode.attributes.getNamedItem("LENGTH").text - len(sTemp))
				end if
			next
		end if

		if IsArray(vData) then
			redim preserve vdata(j)
			gsDebugUp = gsDebugUp & sData
			vData(j) = sData
		else
			gsDebugUp = gsDebugUp & sData
			vData = sData
		end if
	next
end sub

%>
