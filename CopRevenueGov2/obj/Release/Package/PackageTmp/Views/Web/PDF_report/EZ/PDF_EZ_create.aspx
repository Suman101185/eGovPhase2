<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

CopMvcUtil util = new CopMvcUtil();
RevFuncSrv rev_func_srv = new RevFuncSrv();
FuncSrv func_srv = new FuncSrv();
XMLUtil xmlProc = new XMLUtil();
string sPath= string.Empty; 
string sPayCouponTemplate = string.Empty;
string msCouponPath = string.Empty;
string msApp= string.Empty;

string strAddressesStr;
string [] strAddresses;


string var_NET_TAX, var_GROSS_TAX, var_ACTUAL_TAX, var_ESTIMATED_TAX, var_TOTAL_TAX, var_NPT_TAX_CREDIT;
string var_BPT_TAX_CREDIT, var_TOTAL_PAY_CREDITS, var_INTEREST_PENALTY, var_AMOUNT_OWED, var_REFUND, var_NPT_OVERPAY, var_BPT_OVERPAY, var_USER_ID, var_TAX_DUE;
string var_name, var_ein_ssn_label, var_ein_ssn_value, var_address, var_year, var_rate;
string var_PREPARER_NAME, var_PREPARER_PHONE, var_PREPARER_PHONE_EXT, var_PREPARER_EMAIL_ADDRESS, var_PREPARER_WHO;

    
void OpenPayCouponTemplate()
{
   
	sPath = Server.MapPath("~");
    
	//Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if (var_year == "2016")
    {
        using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\EZ\EZPDF2016.htm"))
        {
            sPayCouponTemplate = st.ReadToEnd();
        }
    }
    if (var_year == "2015")
    {
        using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\EZ\EZPDF2015.htm"))
        {
            sPayCouponTemplate = st.ReadToEnd();
        }
    }
    if (var_year == "2014")
    {
        using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\EZ\EZPDF2014.htm"))
        {
            sPayCouponTemplate = st.ReadToEnd();
        }
    }
    if (var_year == "2013")
    {
        using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\EZ\EZPDF2013.htm"))
        {
            sPayCouponTemplate = st.ReadToEnd();
        }
    }
    
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}", var_ein_ssn_label);
    
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_ein_ssn_value); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_address); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

    sPayCouponTemplate = sPayCouponTemplate.Replace("{NET_TAX}", var_NET_TAX); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{GROSS_TAX}", var_GROSS_TAX); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ACTUAL_TAX}", var_ACTUAL_TAX); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ESTIMATED_TAX}", var_ESTIMATED_TAX); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_TAX}", var_TOTAL_TAX); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NPT_TAX_CREDIT}", var_NPT_TAX_CREDIT); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_TAX_CREDIT}", var_BPT_TAX_CREDIT); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_PAY_CREDITS}", var_TOTAL_PAY_CREDITS); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", var_TAX_DUE); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INTEREST_PENALTY}", var_INTEREST_PENALTY); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

    sPayCouponTemplate = sPayCouponTemplate.Replace("{AMOUNT_OWED}", var_AMOUNT_OWED);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{REFUND}", var_REFUND);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{NPT_OVERPAY}", var_NPT_OVERPAY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{BPT_OVERPAY}", var_BPT_OVERPAY);     
    
    sPayCouponTemplate = sPayCouponTemplate.Replace("{USER_ID}", var_USER_ID); 

    sPayCouponTemplate = sPayCouponTemplate.Replace("{year}", var_year);  
    sPayCouponTemplate = sPayCouponTemplate.Replace("{rate}", var_rate); 
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_WHO}", var_PREPARER_WHO);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_NAME}", var_PREPARER_NAME);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_PHONE}", var_PREPARER_PHONE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_PHONE_EXT}", var_PREPARER_PHONE_EXT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PREPARER_EMAIL_ADDRESS}", var_PREPARER_EMAIL_ADDRESS);
   
	

	//TempDate = datepart("yyyy", Now) & datepart("m", Now) & datepart("d", Now) & datepart("h", Now) & datepart("m", Now) & datepart("s", Now)
        
    CString TempDate = DateTime.Now.Year.ToString();
    TempDate += DateTime.Now.Month.ToString();
    TempDate += DateTime.Now.Day.ToString();
    TempDate += DateTime.Now.Hour.ToString();
    TempDate += DateTime.Now.Minute.ToString();
    TempDate += DateTime.Now.Second.ToString();
    
        
	string sTmpPayCoup =  Session.SessionID + "_" + TempDate;
	
    using(StreamWriter st = File.CreateText(msCouponPath + sTmpPayCoup + ".htm"))
    {
	    st.WriteLine(sPayCouponTemplate );
        st.Close();
    }
     
   
    string sFileHTM = msCouponPath + sTmpPayCoup + ".htm";
    string sFilePDF = string.Empty;
    sFilePDF = msCouponPath + sTmpPayCoup + ".pdf";
    try
    {
        CopMvcPDFUtil HTMConverter = new CopMvcPDFUtil();
        HTMConverter.PdfFilePath = msCouponPath + sTmpPayCoup + ".pdf";
        HTMConverter.HtmlFilePath= sFileHTM;
        HTMConverter.OptionsString = "-nocenter -width 612 -height 792 -margin 0x0x0x0";
        HTMConverter.CallVeryPDF();
    }
    catch(Exception ex)
    {
        using(StreamWriter st = File.CreateText("CreateImage Error 2 - "))
        {
	        st.WriteLine( ex.Message + ex.StackTrace + VB.vbcrlf );
            st.Close();
        }        
    }

    File.Delete(sFileHTM);
    string sPayCouponDisplay = string.Empty;

    ////System.Diagnostics.Process.Start(sFilePDF);

    //string s = "window.open('2015.htm', 'popup_window', 'width=300,height=100,left=100,top=100,resizable=yes');";
    //ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

    //using (StreamReader st = File.OpenText(sPath + @"\Views\web\paycoupon\PDFCouponDisplay.htm"))
    using (StreamReader st = File.OpenText(sPath + @" \Views\web\PDF_report\PDFDisplay.htm"))
    {

        sPayCouponDisplay = st.ReadToEnd();
        st.Close();
    }

    sPayCouponDisplay = sPayCouponDisplay.Replace("{PDFFILE}", @"..\CouponImages\" + sTmpPayCoup + ".pdf");
    Response.Write(VB.mid(sPayCouponDisplay, 4));
}

//////void  PopulateAccountInfo(string sPOBox, string SAccountName, string sPhone)
//////{
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{BOX}", sPOBox);               //Replace(sPayCouponTemplate, "{BOX}", sPOBox)
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{AcctID}",SAccountName);       //Replace(sPayCouponTemplate, "{AcctID}", SAccountName)
//////    sPayCouponTemplate = sPayCouponTemplate.Replace("{PHONE}", " (215) " + sPhone); //Replace(sPayCouponTemplate, "{PHONE}", " (215) " & SPhone)
//////}

string ispProperCase(string val)
{
    string sTng;
    string [] vTmp;
    
    int i=0;
	
	if(val == "" )
    {
		sTng = val;
    }
	else
    {
		vTmp = val.Split(' ');
		sTng =  VB.Left(vTmp[0], 1).ToUpper();//  Ucase(left(Vtmp(0),1))
        
		if(vTmp[0].Length > 1 )
        {
			sTng = sTng + VB.mid(vTmp[0],2).ToLower();  //LCase(mid(vTmp(0),2))
		}
		
		for(i = 0; i < vTmp.Length; i++)
        {
			sTng = sTng + " " +  VB.mid(vTmp[i],1).ToUpper();  //    Ucase(left(vTmp(i),1))
			if(vTmp[i].Length > 1 )
            {
				sTng = sTng + VB.mid(vTmp[i],2).ToLower(); //LCase(Mid(vTmp(i),2))
			}
        }	
			
    }

    return sTng;
	
}

</script>


<%

	Response.CacheControl = "no-cache";
	Response.AddHeader("Pragma", "no-cache");
	Response.Expires = 0;
	Response.ContentType = "text/html";

    msApp = "CC";
    msCouponPath = COPPaths.COUPON_PATH;

    var_NET_TAX = CopQueryString.GetString("a");
    var_GROSS_TAX = CopQueryString.GetString("b");
    var_ACTUAL_TAX = CopQueryString.GetString("c");
    var_ESTIMATED_TAX = CopQueryString.GetString("d");
    var_TOTAL_TAX = CopQueryString.GetString("e");
    var_NPT_TAX_CREDIT = CopQueryString.GetString("f");
    var_BPT_TAX_CREDIT = CopQueryString.GetString("g");
    var_TOTAL_PAY_CREDITS = CopQueryString.GetString("h");
    var_TAX_DUE = CopQueryString.GetString("i");
    var_INTEREST_PENALTY = CopQueryString.GetString("j");
    var_AMOUNT_OWED = CopQueryString.GetString("k");
    var_REFUND = CopQueryString.GetString("l");
    var_NPT_OVERPAY = CopQueryString.GetString("m");
    var_BPT_OVERPAY = CopQueryString.GetString("n");   
    
    var_USER_ID = CopQueryString.GetString("zzz");
    //
    var_name = CopQueryString.GetString("q");
    var_ein_ssn_label = CopQueryString.GetString("r");
    var_ein_ssn_value = CopQueryString.GetString("s");
    var_address = CopQueryString.GetString("t");
    var_year = CopQueryString.GetString("u");
    var_rate = CopQueryString.GetString("w");
    //
    var_PREPARER_NAME = CopQueryString.GetString("v");
        var_PREPARER_PHONE = CopQueryString.GetString("x");
         var_PREPARER_PHONE_EXT = CopQueryString.GetString("yy");
         var_PREPARER_EMAIL_ADDRESS = CopQueryString.GetString("z");
         var_PREPARER_WHO = CopQueryString.GetString("zz");
    
    OpenPayCouponTemplate();

    //Delete all coupon files associate with this session
    //Set fso = Server.CreateObject("Scripting.FileSystemObject")


    DirectoryInfo Folder = new DirectoryInfo(COPPaths.COUPON_PATH); 
    DateTime qDate = DateTime.Now.AddHours(-1);
    int iCounter=0;
    if(Folder.Exists == false)
    {
        Folder.Create();
    }
    
    foreach(FileInfo i in Folder.GetFiles())
    {
	    iCounter = iCounter + 1;
    
	    if(i.LastWriteTime <= qDate)
        {
            File.Delete(COPPaths.COUPON_PATH + i.Name);
	    }
	    if(iCounter == 21 )
        {
		    break;
        }
    }


%>
