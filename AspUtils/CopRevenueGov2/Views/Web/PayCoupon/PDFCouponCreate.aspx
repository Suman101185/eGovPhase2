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
    

string strAcctID, strEntityName, strEntityAddr, strScanLine, strPeriod, strAcctType;
        
    
void OpenPayCouponTemplate()
{
   
	sPath = Server.MapPath("~");
    
	//Set fso = Server.CreateObject("Scripting.FileSystemObject")
    using(StreamReader st = File.OpenText(sPath + @"\Views\web\PayCoupon\PDFCouponImageTemplate.htm"))
    {
	    sPayCouponTemplate =  st.ReadToEnd();
    }
	
	sPayCouponTemplate = sPayCouponTemplate.Replace("{NAME}", strEntityName); //Replace(sPayCouponTemplate, "{NAME}", strEntityName)
	sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR1}", strAddresses[0]); //Replace(sPayCouponTemplate, "{ADDR1}", strAddresses(0))
	if(strAddresses[2].Trim() == "")	//3rd Address Blank
    {
		if (strAddresses[1].Trim() == "" )	//'2rd Address Blank - City State Zip in 2nd Address
        {
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR2}", strAddresses[3] + ", " + strAddresses[4] + " " + strAddresses[5]); //Replace(sPayCouponTemplate,)
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR3}",strAddresses[1]);//  Replace(sPayCouponTemplate, "{ADDR3}", strAddresses(1))
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR4}", strAddresses[2]); //Replace(sPayCouponTemplate, "{ADDR4}", strAddresses(2))
    }
		else	//'2rd Address Filled - City State Zip in 3nd Address
        {
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR2}", strAddresses[1]);
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR3}", strAddresses[3] + ", " + strAddresses[4] + " " + strAddresses[5]);
			sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR3}", strAddresses[2]);
    }
        }
	else	//'3rd Address Filled - City State Zip in 4nd Address
        {
            sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR2}", strAddresses[1]);
            sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR3}", strAddresses[2]);
            sPayCouponTemplate = sPayCouponTemplate.Replace( "{ADDR4}",strAddresses[3] + ", " + strAddresses[4] + " " + strAddresses[5]);
        
			//sPayCouponTemplate = Replace(sPayCouponTemplate, "{ADDR2}", strAddresses(1))
			//sPayCouponTemplate = Replace(sPayCouponTemplate, "{ADDR3}", strAddresses(2))	
			//sPayCouponTemplate = Replace(sPayCouponTemplate, "{ADDR4}",  strAddresses[3] + ", " + strAddresses[4] + " " + strAddresses[5]);
        }
	sPayCouponTemplate = sPayCouponTemplate.Replace( "{AcctNum}", strAcctID);
    sPayCouponTemplate = sPayCouponTemplate.Replace( "{Entity Name}", strEntityName);
    sPayCouponTemplate = sPayCouponTemplate.Replace( "{Entity Street}", strEntityAddr);
    sPayCouponTemplate = sPayCouponTemplate.Replace( "{Scan Line}", strScanLine);

    
    //dim sDate as date = now
    sPayCouponTemplate = sPayCouponTemplate.Replace( "{Today}",  DateTime.Now.Date.ToString("MMMM d, yyyy"));
    
	//sPayCouponTemplate = Replace(sPayCouponTemplate, "{Today}", monthname(datepart("m", Now())) & " " & datepart("d", Now()) & ", " & datepart("yyyy", Now()))
	//sPayCouponTemplate = Replace(sPayCouponTemplate, "{Date}", strPeriod)
    
    sPayCouponTemplate = sPayCouponTemplate.Replace( "{Date}",  strPeriod);
	
	switch(strAcctType)
    {
		case "01":		//'"WAG"
			PopulateAccountInfo("8040", "Wage", "686-6600");
            break;
		case "02":		//'"ERN"
			PopulateAccountInfo("1648", "Earnings", "686-6600");
            break;
		case "03":		//'"NPT"
			PopulateAccountInfo("1393", "Net Profits", "686-6600");
            break;
		case "06":		//'"AMU"
			PopulateAccountInfo("124", "Amusement", "686-6600");
            break;
		case "08":		//'"PRK"
			PopulateAccountInfo("124", "Parking", "686-6600");
            break;
		case "09":		//'"COI"
			PopulateAccountInfo("124", "Coin Operated", "686-6600");
            break;
		case "11":		//'"POL"
			PopulateAccountInfo("60", "Police", "686-6600");
            break;
		case "14":		//'"VRT"
			PopulateAccountInfo("124", "Vehicle Rental", "686-6600");
            break;
		case "18":		//'"RTT"
			PopulateAccountInfo("124", "Realty Transfer", "686-6600");
            break;
		case "23":		//'"HOT"
			PopulateAccountInfo("53180", "Hotel", "686-6600");
            break;
		case "24":		//'"BPT"
			PopulateAccountInfo("1393", "Business Income and Receipts", "686-6600");
            break;
		case "27":		//'"TOB"
			PopulateAccountInfo("53250", "Tobacco", "686-6600");
            break;
		case "28":		//'"LIQ"
			PopulateAccountInfo("1018", "Liquor", "686-6600");
            break;
		case "29":		//'"SIT"
			PopulateAccountInfo("389", "School Income Tax", "686-6600");
            break;
		case "58":		//'"VPT"
			PopulateAccountInfo("124", "Valet Parking", "686-6600");
            break;
		case "60":		//'"REA"
			PopulateAccountInfo("8409", "Real Estate", "686-6442");
            break;
		case "76":		//'"OAT"
			PopulateAccountInfo("124", "Outdoor Advertizing", "686-6600");
            break;
		case "84":		//'"UOL"
			PopulateAccountInfo("1049", "U&O - Landlord", "686-6600");
            break;
		case "85":		//'"UOL"
			PopulateAccountInfo("1049", "U&O - Tenant", "686-6600");
            break;
		case "90":		//'"ASM"
			PopulateAccountInfo("1600", "Assessment Screen", "686-6600");
            break;
		case "91":		//'"GNP"
			PopulateAccountInfo("60", "Police BRI", "686-3055");
            break;
		case "97":		//'"GEN"
			PopulateAccountInfo("1600", "Entity Level Charges", "686-6600");
            break;
		case "98":		//'"GN2"
			PopulateAccountInfo("1600", "General", "686-6600");
            break;
		case "99":		//'"GN3"
			PopulateAccountInfo("1600", "Entity Level Charges", "686-6600");
            break;
        default:
            break;
	}

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
    using(StreamReader st = File.OpenText(sPath + @"\Views\web\paycoupon\PDFCouponDisplay.htm"))
    {
	    sPayCouponDisplay = st.ReadToEnd();
        st.Close();
    }    
    
    sPayCouponDisplay = sPayCouponDisplay.Replace("{PDFFILE}", @"..\CouponImages\" + sTmpPayCoup + ".pdf");
	Response.Write(VB.mid(sPayCouponDisplay,4));
}

void  PopulateAccountInfo(string sPOBox, string SAccountName, string sPhone)
{
	sPayCouponTemplate = sPayCouponTemplate.Replace("{BOX}", sPOBox);               //Replace(sPayCouponTemplate, "{BOX}", sPOBox)
	sPayCouponTemplate = sPayCouponTemplate.Replace("{AcctID}",SAccountName);       //Replace(sPayCouponTemplate, "{AcctID}", SAccountName)
	sPayCouponTemplate = sPayCouponTemplate.Replace("{PHONE}", " (215) " + sPhone); //Replace(sPayCouponTemplate, "{PHONE}", " (215) " & SPhone)
}

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

    strAcctID = CopQueryString.GetString("a").Replace( "~LBSIGN~", "#"); //Replace(Request.QueryString("a"), "~LBSIGN~", "#")
    strEntityName = ispProperCase(CopQueryString.GetString("b").Replace("~LBSIGN~", "#")); //ispProperCase(Replace(Request.QueryString("b"), "~LBSIGN~", "#"))
    strEntityAddr = ispProperCase(CopQueryString.GetString("c").Replace("~LBSIGN~", "#")); //ispProperCase(Replace(Request.QueryString("c"), "~LBSIGN~", "#"))
    strScanLine = CopQueryString.GetString("d").Replace("~LBSIGN~", "#"); // Replace(Request.QueryString("d"), "~LBSIGN~", "#")
    strPeriod = CopQueryString.GetString("e").Replace("~LBSIGN~", "#"); // Replace(Request.QueryString("e"), "~LBSIGN~", "#")
    strAddressesStr = CopQueryString.GetString("g").Replace("~LBSIGN~", "#");//Replace(Request.QueryString("g"), "~LBSIGN~", "#")
    strAcctType = VB.mid(strScanLine,4,2);
    strAddresses = strAddressesStr.Split('|');
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
