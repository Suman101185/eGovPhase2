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


string var_MAX_TAX, var_VACANCY, var_EXEMPT, var_RESIDENTIAL, var_KOZ_CREDIT, var_TOTAL_DEDUCTIONS;
string var_PERIOD_TAX, var_FIXED_EXEMPTN, var_DELINQUENT, var_ADJUSTED_TAX, var_DISCOUNT, var_TAX_DUE, var_TOTAL_DUE, var_INTEREST_PENALTY;
string var_name, var_ein_ssn_label, var_ein_ssn_value, var_address, var_year, var_rate, var_acNo;
string var_PREPARER_NAME, var_PREPARER_PHONE, var_PREPARER_PHONE_EXT, var_PREPARER_EMAIL_ADDRESS, var_PREPARER_WHO;



void tobaccoPdfTemplate()
{

    sPath = Server.MapPath("~");

    //Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using (StreamReader st = File.OpenText(sPath + @"\Views\web\PDF_report\UO\UO.htm"))
    {
        sPayCouponTemplate = st.ReadToEnd();
    }

    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{name}", var_name); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_label}", var_ein_ssn_label);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ssn_value}", var_ein_ssn_value); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{address}", var_address);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{acc_id}", var_acNo);
    //
    sPayCouponTemplate = sPayCouponTemplate.Replace("{MAX_TAX}", var_MAX_TAX); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{VACANCY}", var_VACANCY); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{EXEMPT}", var_EXEMPT); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{RESIDENTIAL}", var_RESIDENTIAL); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{KOZ_CREDIT}", var_KOZ_CREDIT); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_DEDUCTIONS}", var_TOTAL_DEDUCTIONS); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{PERIOD_TAX}", var_PERIOD_TAX); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{FIXED_EXEMPTN}", var_FIXED_EXEMPTN); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
    sPayCouponTemplate = sPayCouponTemplate.Replace("{DELINQUENT}", var_DELINQUENT); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
    sPayCouponTemplate = sPayCouponTemplate.Replace("{ADJUSTED_TAX}", var_ADJUSTED_TAX); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))

    sPayCouponTemplate = sPayCouponTemplate.Replace("{DISCOUNT}", var_DISCOUNT);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TAX_DUE}", var_TAX_DUE);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{INTEREST_PENALTY}", var_INTEREST_PENALTY);
    sPayCouponTemplate = sPayCouponTemplate.Replace("{TOTAL_DUE}", var_TOTAL_DUE);
   
    //
   
    //
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
    
    //var_MAX_TAX = CopQueryString.GetString("a");
    var_MAX_TAX = CopQueryString.GetString("aa");
    var_VACANCY = CopQueryString.GetString("b");
    var_EXEMPT = CopQueryString.GetString("c");
    var_RESIDENTIAL = CopQueryString.GetString("d");
    var_KOZ_CREDIT = CopQueryString.GetString("e");
    var_TOTAL_DEDUCTIONS = CopQueryString.GetString("f");
    var_PERIOD_TAX = CopQueryString.GetString("g");
    var_FIXED_EXEMPTN = CopQueryString.GetString("h");
    var_DELINQUENT = CopQueryString.GetString("i");
    var_ADJUSTED_TAX = CopQueryString.GetString("j");
    var_DISCOUNT = CopQueryString.GetString("k");
    var_TAX_DUE = CopQueryString.GetString("l");
    var_INTEREST_PENALTY = CopQueryString.GetString("m");
    var_TOTAL_DUE = CopQueryString.GetString("n");

   
    //
    var_name = CopQueryString.GetString("q");
    var_ein_ssn_label = CopQueryString.GetString("r");
    var_ein_ssn_value = CopQueryString.GetString("s");
    var_address = CopQueryString.GetString("t");
    var_year = CopQueryString.GetString("u");
    var_acNo = CopQueryString.GetString("acNo");

    //
    var_PREPARER_NAME = CopQueryString.GetString("v");
    var_PREPARER_PHONE = CopQueryString.GetString("x");
    var_PREPARER_PHONE_EXT = CopQueryString.GetString("yy");
    var_PREPARER_EMAIL_ADDRESS = CopQueryString.GetString("z");
    var_PREPARER_WHO = CopQueryString.GetString("zz");

    tobaccoPdfTemplate();

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
