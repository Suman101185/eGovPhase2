<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<head>  
    <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="../../Content/Styles/bootstrap.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../Content/Styles/jPushMenu.css">
      <script src="../../Content/js/bcmath-min.js" type="text/javascript"></script>
    <script src="../../Content/js/pdf417-min.js" type="text/javascript"></script>
     
 
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script id="Script1" language="javascript" type="text/javascript">
        var strAcctID = '';
        //EDD Added function to print coupon
        function DoPrintCoupon() {
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, 'NPT', 'COUPON_FORM CPN_FORM', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, '3', 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
          
            if ((sCurrYear - 1) == 2015 || (sCurrYear - 1) == 2016 || (sCurrYear - 1) == 2017) {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT_2015, 'NPT_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "");
            }
            else {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT, 'NPT_INFO ACCOUNT_ID', '', 0), 'COUPON_FORM CPN_ACCOUNT', '');
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT, 'NPT_INFO PERIOD', '', 0), 'COUPON_FORM CPN_PERIOD', '')
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlNPT, 'NPT_INFO PERIOD', '', 0).substr(6, 4), "COUPON_FORM CPN_YEAR", "")

            }
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, $('#lblThankYouName').text(), 'COUPON_FORM CPN_NAME', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS1', '', '0'), 'COUPON_FORM CPN_ADDR', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ADDRESS2', '', '0'), 'COUPON_FORM CPN_ADDR2', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, "", 'COUPON_FORM CPN_ADDR3', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS CITY', '', '0'), 'COUPON_FORM CPN_CITY', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS STATE', '', '0'), 'COUPON_FORM CPN_STATE', '')
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlPayCoupon, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS ZIP', '', '0'), 'COUPON_FORM CPN_ZIP_CODE', '')
            
            var strPayPeriod = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_PERIOD', '')
            var strAcctType = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ACCOUNT_TYPE', '')
            strAcctID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ACCOUNT', '')
            var strAccountName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_NAME', '')
            var strAccountAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ADDR', '')
            var strAccountAddr2 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ADDR2', '')
            var strAccountAddr3 = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ADDR3', '')
            var strAccountCity = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_CITY', '')
            var strAccountState = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_STATE', '')
            var strAccountZip = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_ZIP_CODE', '')

            //  var strEntityID = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,'COUPON_FORM/CPN_ENTITY_ID', '')
            var i = 0
            var iTotal = 0
            var iDigit = 0
            var strScanID


            if (strAcctType == '60') {
                strCouponAddr = strBRTAddr
                strAcctID = strBRTAcct
            } else {
                //		strCouponAddr = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon,"ENTITY_INFO/ADDRESS1", "")  
            }  //if

            //	strPeriod = ddPCTaxPeriod.options(ddPCTaxPeriod.selectedIndex).innerText
            strPeriod = new Date(strPayPeriod)
            strPeriod = strPeriod.getMonth() + 1 + '/' + strPeriod.getDate() + '/' + strPeriod.getFullYear()
            strPayPeriod = strPayPeriod.substr(0, 2)
            //	strAcctType = strAcctType
            /*  if (ifreq == 'W') {
                 strPeriod = strPeriod
                 } else {
                 strPeriod = strPeriod + ', ' + ddPCTaxYear.options(ddPCTaxYear.selectedIndex).CODE
              } //if */

            //        make type 2 digits	
            if (new Number(strAcctType) < 10) {
                strAcctType = '0' + strAcctType
            } //if		

            //		  add sufffix for UOL, UOT	
            if (strAcctID.length == 7) {
                if (strAcctType == '84' || strAcctType == '85') {
                    if (strAcctID.substr(7, 8) == '  ') {
                        strAcctID.substr(7, 8) = '00'
                    } //if
                } // if
            } // if

            //		  make Account Id 12 bytes long	
            if (strAcctID.length == 12) {
                strScanID = strAcctID
            } //if
            if (strAcctID.length == 11) {
                strScanID = strAcctID + '0'
            } //if
            if (strAcctID.length == 10) {
                strScanID = strAcctID + '00'
            } //	if
            if (strAcctID.length == 9) {
                strScanID = strAcctID + '000'
            } //	if
            if (strAcctID.length == 8) {
                strScanID = strAcctID + '0000'
            } //	if
            if (strAcctID.length == 7) {
                strScanID = strAcctID + '00000'
            } //	if
            if (strAcctID.length == 6) {
                strScanID = strAcctID + '000000'
            } //	if
            if (strAcctID.length == 5) {
                strScanID = strAcctID + '0000000'
            } //	if
            if (strAcctID.length == 4) {
                strScanID = strAcctID + '00000000'
            } //	if
            if (strAcctID.length == 3) {
                strScanID = strAcctID + '000000000'
            } //	if
            if (strAcctID.length == 2) {
                strScanID = strAcctID + '0000000000'
            } //	if
            if (strAcctID.length == 1) {
                strScanID = strAcctID + '00000000000'
            } //	if
            if (strAcctType == '98') {
                strScanID = strAcctID
            }		//if

            //		  Make pay period 2 digits
            if (strPayPeriod < 10) {
                strPayPeriod = '0' + strPayPeriod
            } //if

            //		  Get today's date for due date
            HoldDate = new Date()
            holdmonth = HoldDate.getMonth()
            holdmonth = holdmonth + 1
            if (holdmonth < 10) {
                holdmonth = '0' + holdmonth
            } // if

            holdday = HoldDate.getDate()
            if (holdday < 10) {
                holdday = '0' + holdday
            } // if

            holdyear = HoldDate.getFullYear()
            twoyear = holdyear
            //		  find 2 digit year
            if (twoyear > 2000) {
                while (twoyear > 999) {
                    twoyear = twoyear - 1000
                }  //while
                while (twoyear > 99) {
                    twoyear = twoyear - 100
                }  //while
                if (twoyear < 10) {
                    twoyear = '0' + twoyear
                } //if
            } //if

            //		create dates for scan lines
            HoldDate = new String(holdmonth) + new String(holdday) + new String(twoyear)

            //  Format Period year
            twoyear = parent.$x.ispXmlGetFieldVal(parent.$g.xmlPayCoupon, 'COUPON_FORM CPN_YEAR', '')
            //		  find 2 digit year
            if (twoyear > 2000) {
                while (twoyear > 999) {
                    twoyear = twoyear - 1000
                }  //while
                while (twoyear > 99) {
                    twoyear = twoyear - 100
                }  //while
                if (twoyear < 10) {
                    twoyear = '0' + twoyear
                } //if
            } //if

            //		create century code for SIT accounts (in CCYY year, century code is 2nd C)\
            centurySIT = '0'
            if (holdyear < 1999) {
                centurySIT = '9'
            } //if

            if (strAcctType == '11') {
                strScanLine = '333' + strAcctType + HoldDate + '0000' + strScanID + '0000000000000000000000000000000000000000'
            } else if (strAcctType == '29') {
                //strScanLine = '333' + strAcctType + HoldDate + '00' + '00000' + strScanID + '0000000000000000000' + centurySIT + twoyear + '000000000000000'//Commented by SumanG
                strScanLine = '333' + strAcctType + HoldDate + '00' + '00000' + strScanID + '0000000000000000000' + strPayPeriod + twoyear + '000000000000000'//Newly added for change request 
            } else if (strAcctType == '84' || strAcctType == '85') {
                strScanLine = '333' + strAcctType + HoldDate + '00' + '00000000' + strScanID + '0000000000' + twoyear + strPayPeriod + '0000000000000000000000'
                //20100301 EHD Real Estate needs to have the 2 year code in the scan line
            } else if (strAcctType == '60') {
                strScanLine = '333' + strAcctType + HoldDate + '0000' + '0000' + strScanID + '0000000000000000000' + twoyear + '0' + strPayPeriod + '00000000000000'
            } else if (strAcctType == '98') {
                strScanLine = '333' + strAcctType + HoldDate + '0000' + strScanID + '000000000000000000000000000000000000000'
            } else {
                strScanLine = '333' + strAcctType + HoldDate + '00' + '000000' + strScanID + '000000000000000000' + strPayPeriod + twoyear + '000' + '00000000000000000000'
            } //if

            //TODO Fix Check Digit Routine
            //Check digit routine
            //Even numbers added together for a running total
            if (strAcctType == '98') {
                for (i = 1; i < 59; i = i + 2) {
                    iTotal = iTotal + parseInt(strScanLine.substr(i, 1))
                }  //for
                //Odd numbers Multiplied by 2 then the 2 digit answer is added together then added to the running total
                // 3 * 2 = 6 add 6 (0 + 6) ; 6 * 2 = 12 add 3 (1 + 2)
                for (i = 0; i < 59; i = i + 2) {
                    iDigit = parseInt(strScanLine.substr(i, 1)) * 2
                    if (iDigit.toString().length == 2) {
                        iDigit = parseInt(iDigit.toString().substr(0, 1)) + parseInt(iDigit.toString().substr(1, 1))
                    } 	//if
                    iTotal = iDigit + iTotal
                }
            }
            else {
                for (i = 1; i < 66; i = i + 2) {
                    iTotal = iTotal + parseInt(strScanLine.substr(i, 1))
                }  //for
                //Odd numbers Multiplied by 2 then the 2 digit answer is added together then added to the running total
                // 3 * 2 = 6 add 6 (0 + 6) ; 6 * 2 = 12 add 3 (1 + 2)
                for (i = 0; i < 66; i = i + 2) {
                    iDigit = parseInt(strScanLine.substr(i, 1)) * 2
                    if (iDigit.toString().length == 2) {
                        iDigit = parseInt(iDigit.toString().substr(0, 1)) + parseInt(iDigit.toString().substr(1, 1))
                    } 	//if
                    iTotal = iDigit + iTotal
                }
            }  //for
            //Take the ones position and subtract from 10
            if (parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1)) == 0) {
                iTotal = 0
            } else {
                iTotal = 10 - parseInt(iTotal.toString().substr(parseInt(iTotal.toString().length) - 1, 1))
            } 	//if

            if (strAcctType == '98') {
                strScanLine = strScanLine.substr(0, 58) + iTotal
            }
            else
                strScanLine = strScanLine.substr(0, 67) + iTotal
            generate('203' + strScanLine);
            
            tempParameters = 'a=' + strAcctID + '&b=' + strAccountName + '&c=' + strAccountAddr + '&d=' + strScanLine + '&e=' + strPeriod + '&f=' + strAcctType + '&h=' + '../Uploads/Net_Profits' + "_" + strAcctID + '.png' + '&i=' + 'ThankYou' + '&g=' + strAccountAddr + '|' + strAccountAddr2 + '|' + strAccountAddr3 + '|' + strAccountCity + '|' + strAccountState + '|' + strAccountZip
            tempParameters = tempParameters.replace(/#/g, '~LBSIGN~')
            if (navigator.userAgent.indexOf("Firefox") > 0) {
                parent.setFrameUrl('PayCoupon/PDFCouponCreate_Firefox?y=' + tempParameters);
            }
            else {
                parent.setFrameUrl('PayCoupon/PDFCouponCreate?y=' + tempParameters);
            }
        }		//DoPrintCoupon

        function generate(data) {
            debugger;
            PDF417.init(data);

            var barcode = PDF417.getBarcodeArray();
            var link;
            // block sizes (width and height) in pixels
            var bw = 1;
            var bh = 2;

            // create canvas element based on number of columns and rows in barcode
            var canvas = document.createElement('canvas');
            canvas.width = bw * barcode['num_cols'];
            canvas.height = bh * barcode['num_rows'];
            // parent.document.getElementById('imagedata').appendChild(canvas);

            var ctx = canvas.getContext('2d');

            // graph barcode elements
            var y = 0;
            // for each row
            for (var r = 0; r < barcode['num_rows']; ++r) {
                var x = 0;
                // for each column
                for (var c = 0; c < barcode['num_cols']; ++c) {
                    if (barcode['bcode'][r][c] == 1) {
                        ctx.fillRect(x, y, bw, bh);
                    }
                    x += bw;
                }
                y += bh;
            }

            link = canvas.toDataURL();

            link = link.replace('data:image/png;base64,', '');
            $.ajax({
                type: 'POST',
                url: '../../Returns/Upload',
                data: '{ "imageData" : "' + link + '","AccountId":"' + strAcctID + '","Form":"Net_Profits" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    //alert('Image saved successfully !');
                }
            });


        }

        
        function DoPrint() {
            $('#btnPrint').css('visibility', 'hidden');
            $('#btnNPTThankYou').css('visibility', 'hidden');
            window.print();
            $('#btnPrint').css('visibility', 'visible');
            $('#btnNPTThankYou').css('visibility', 'visible');
        }
    </script>
</head>
<body>
    <div id="divNPTThankYou" style="display: none;" class="container-fluid no-padding">
    <div class="block3">
        <div class="container thank-you-page-padding">
        <div class="row">
        <div class="col-lg-12 col-md-12">   
       	<div class="blue_base_box">
               <h2>Taxpayer Information  |   <span>thank you </span>  </h2>
            <div class="inner_white-panel">
           <div class="contentsection">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                    <div class="well" style="padding-bottom:5px !important; padding-top:5px !important; margin-bottom:5px !important;">
                        <div class="row">                          
                            <div class="col-lg-12 templateclass">
                                <h4 id="hdrThankYou">Your Return is now being processed.
                                        <br>
                                    You may want to print a copy of this page for your records.<br>
                                    Thank you for filing your <script>document.write(sCurrYear - 1)</script> Net Profit Tax Return online.</h4>
                            </div>
                        </div>
                    </div>
                </div>

                    <div class="row">
                        <div class="">
                            <table class="table table-condensed table-striped custom_table03" style="margin-bottom:5px !important;">
                                <tbody>
                                    <tr>
                                        <td width="10%" class="text-left">Name</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label id='lblThankYouName'></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>

                                    <tr class="odd">
                                        <td width="10%" class="text-left">Account No</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">
                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label  id='lblAcctNo'></label>

                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="20%" class="text-left">Your Confirmation No. is</td>
                                        <td  class="text-left">
                                            <form class="form-horizontal">

                                                <div class="form-group no-margin">
                                                    <div>
                                                        <label id="lblConfirmNo"></label>

                                                    </div>
                                                </div>

                                            </form>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <h3 class="text-center" style="margin-top:8px; margin-bottom:8px;">Payment Option</h3>
                        <div><% Html.RenderAction("CCPage", "CreditCard"); %> </div>
                       

                         <div class="well" style="padding-bottom:2px !important; padding-top:2px !important; margin-bottom:5px !important;">
                            <div class="row">

                                <div class="col-lg-12 templateclass">

                             <p>Coupon: <a class="btn btn-default submit_button" style="margin-top:0 !important;" onclick="DoPrintCoupon()">Print Coupon </a>
                 Attach a check for	the amount due, payable to the "City of Philadelphia" and mail the coupon and check to:
                                   <br />
                                        Philadelphia Department
				of Revenue<br>
                                        P.O. Box 1393<br>
                                        Philadelphia, PA 19105-9731
                                    </p>
                                  
                                </div>
                            </div>
                        </div>

                        

                        <div class="well" style="padding-bottom:2px !important; padding-top:2px !important; margin-bottom:5px !important;">
                            <div class="row">

                                <div class="col-lg-12 templateclass">
                                    <h5 style="margin-top:5px; margin-bottom:5px;">Others</h5>
                                    <p>
                                        if you do not want to pay by credit card and you do not
				have a coupon, print a copy of this page to mail with your payment to the address noted
				above.
                                    </p>

                                    <p>
                                        We would appreciate your comments / feedback concerning your online experience.<br>
                                        Please enter your comments / feedback below:
                                    </p>
                                </div>
                            </div>
                            <div class="">
                                <table class="table table-condensed table-striped custom_table03">
                                    <tbody>
                                        <tr>
                                            <td width="90%" class="text-left" style="border-top: 0;">
                                                <form class="form-horizontal">
                                                    <div class="form-group no-margin">
                                                        <div>
                                                           <textarea class="form-control input-sm" id="txaComments"  name="txaComments"></textarea>
                                                        </div>
                                                    </div>

                                                </form>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <form class="form-horizontal school_form">
                                <div class="form-group submit-button-for-print">
                                    <div class="col-sm-offset-3 col-sm-9  text-right">
                                     <input type="button" class="btn btn-default submit_button" value="Print" id="btnPrint" name="btnPrint" onclick="DoPrint()"/>
                                     <input type="button" class="btn btn-default submit_button" value="Thank You" id="btnNPTThankYou" name="btnNPTThankYou" onclick="DoThankYou()"/>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
             </div>

             <div class="clearfix"></div>
            </div>
        </div>
        </div>
       </div>
        <div class="clearfix"></div>
        </div>
    </div>
</div>

</body>
</html>



