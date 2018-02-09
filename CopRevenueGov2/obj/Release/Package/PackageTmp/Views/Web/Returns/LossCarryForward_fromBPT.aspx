<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>    
    <title></title>
    <!-- Bootstrap Core CSS -->
    <link href="../Content/Styles/bootstrap.css" rel="stylesheet">
     <script src="../Content/Scripts/JqueryMin.js" type="text/javascript"></script>     
    <script src="../Content/Scripts/ispFunctions.js" type="text/javascript"></script>
    <!-- Custom CSS -->
    <link href="../Content/Styles/copegov.css" rel="stylesheet">
    <link href="../Content/Styles/style.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../Content/Styles/jPushMenu.css"/>
  
    <script ID="clientEventHandlersJS" LANGUAGE="javascript">

        var gUserAddr = '<%Response.Write(Request.ServerVariables["REMOTE_ADDR"]);%>'
        var txtHeader = 'Taxpayer Information'
        var sBPT = 'BPT Return :'
        var sBIRT = 'BIRT Return :'
        var sBPT_long = 'Business Privilege Tax'
        var sBIRT_long = 'Business Income and Receipts Tax'

        function isLoaded() {
            if (parent.DocWin.document.readyState != 'complete') {
                setTimeout('isLoaded()', 100)
            } 	//if
        } 	//isLoaded

        function DisplayLCF() {
            debugger;
            parent.$g.loadXmlSync('XML/LossCarryForward', parent.$g.parseXml_xmlLcf);          
           // setTimeout('isLoaded()', 100)          
           $('#AppHeader1').html(txtHeader + '|Loss Carry Forward Form');
           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlLcf, parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0), 'LCF_INFO ACCOUNT_ID', '', 0)
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlLcf, new Date().getFullYear() - 1, 'LCF_INFO YEAR_X', '', 0)
            ispCallXMLForm(parent.$g.xmlLcf, parent.$g.xmlLcf, "Returns/LossCarryForwardReturn", "")
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'ERROR_INFO MESSAGE', "", 0) == "") {
                PopulateLcf()
            } else {	//Mainframe Error
              
                $('#lblAccountName').text('')
               
                $('#lblAccountNumber').text('')
              
                $('#lblYearCurrent').text('')
              
                $('#lblLcfAmount').text('')
                
                $('#lblIncomeLoss').text('')
               
                $('#lblYearMinus1').text('')
              
                $('#lblYearMinus1Amount').text('')
                
                $('#lblYearMinus2').text('')
               
                $('#lblYearMinus2Amount').text('')
              
                $('#lblYearMinus3').text('')
             
                $('#lblYearMinus3Amount').text('')
               
                $('#lblYearMinus4').text('')
               
                $('#lblEstimatedTax').text('')
               
                $('#AppError').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'ERROR_INFO MESSAGE', "", 0))
            } 	//if
        } 	//DisplayLCF

        function PopulateLcf() {
            debugger;

            sFirstName = ''
            sMIName = ''
            sLastName = ''
            //LCF Header
            //if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO TYPE', '', 0) == 1) {
      
            //    $('#lblAccountName').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0))
            //} else {
            //    sEntityName = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'NAME_ADDRESS NAME', '', 0).split('*')
            //    sLastName = sEntityName[0]
            //    if (sEntityName[1]) {
            //        sFirstName = sEntityName[1] + ' '
            //    }		//if
            //    if (sEntityName[2]) {
            //        sMIName = sEntityName[2].substr(0, 1) + ' '
            //    }		//if
            
            //    $('#lblAccountName').text(sFirstName + sMIName + sLastName);

            //}		//if
          
            //$('#lblAccountNumber').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, 'ENTITY_INFO ACCOUNT_ID', "", 0));

            //Loss Carry Forward Amount
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2011) {
             
                $('#lblYearCurrent').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) + ' ' + sBIRT_long);
            } else {
           
                $('#lblYearCurrent').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) + ' ' + sBPT_long);
            }		//if
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT', "", 0) == '') {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO AMOUNT', "", 0) == '') {
             
                    $('#lblLcfAmount').text('$0.00');
                } else {
                
                    $('#lblLcfAmount').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO AMOUNT', "", 0));
                } 	//if
            } else {
       
                $('#lblLcfAmount').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT', "", 0));
            }		//if
            //Income/Loss Line
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2014) {
         
                $('#lblIncomeLoss').text(sBIRT);
            } else if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2012) {
            
                $('#lblIncomeLoss').text(sBIRT + '/' + sBPT);
            } else {
              
                $('#lblIncomeLoss').text(sBPT);
            }		//if
            //Past Returns
            var oLbl, LcfInfo_Year
            //for (idx = 1; idx < 4; idx++) {
            //    oLbl = '#lblYearMinus' + idx
            //    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) < 2012) {
                 
            //        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) + ' ' + sBPT);
            //    } else {                    
                   
            //        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) + ' ' + sBIRT);
            //    }		//if
            //    oLbl = '#lblYearMinus' + idx + 'Amount'
            //    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idx, "", 0) == '') {
            //        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idx, "", 0) == '') {
                      
            //            $(oLbl).text('$00.00');
            //        } else {
                       
            //            $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idx, "", 0));
            //        }		//if
            //    } else {
                 
            //        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idx, "", 0));
            //    } 	//if
            //} 	//for

            var flag = false; var year = '';

            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0) > 2012) {
                for (id = 3; id >= 1; id--) {
                    oLbl = '#lblYearMinus' + id

                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + id, "", 0) != 'RETURN NOT FILED') {
                        flag = true;
                        year = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + id, "", 0);
                    }
                    else {

                        $('#lblYearMinus' + id).css('display', 'none');
                        $('#lblYearMinus' + id + 'Amount').css('display', 'none');

                    }

                    $('#lblYearCurrent').css('display', 'none');
                    $('#lblLcfAmount').css('display', 'none');

                    //$(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idx, "", 0) + ' ' + sBIRT);
                }		//if
                //if
                var count = '';
                if (year != '') {
                    count = year - 2012;
                }
                for (idxx = count; idxx >= 1; idxx--) {
                    oLbl = '#lblYearMinus' + idxx
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idxx, "", 0) < 2012) {

                        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idxx, "", 0) + ' ' + sBPT);
                    } else {

                        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + idxx, "", 0) + ' ' + sBIRT);
                    }		//if
                    oLbl = '#lblYearMinus' + idxx + 'Amount'
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idxx, "", 0) == '') {
                        if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idxx, "", 0) == '') {

                            $(oLbl).text('$00.00');
                        } else {

                            $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + idxx, "", 0));
                        }		//if
                    } else {

                        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO COMMENT_' + idxx, "", 0));
                    } 	//if
                }
                for (i = 1; i <= 3; i++) {
                    if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + i, "", 0) == year) {
                        oLbl = '#lblYearMinus' + i;
                        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR_' + i, "", 0) + ' ' + sBIRT);
                        oLbl = '#lblYearMinus' + i + 'Amount';
                        $(oLbl).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO INCOME_' + i, "", 0));
                    }
                }
            }
            else {
                $('#lblYearMinus1').css('display', 'none');
                $('#lblYearMinus1Amount').css('display', 'none');
                $('#lblYearMinus2').css('display', 'none');
                $('#lblYearMinus2Amount').css('display', 'none');
                $('#lblYearMinus3').css('display', 'none');
                $('#lblYearMinus3Amount').css('display', 'none');
                $('#lblYearCurrent').css('display', 'none');
                $('#lblLcfAmount').css('display', 'none'); 

            }


            lblYearMinus4.innerText = parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO YEAR', "", 0);
            if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO EST_PAID_X', "", 0) == '') {
              
                $('#lblEstimatedTax').text('$00.00');
            } else {                
                $('#lblEstimatedTax').text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlLcf, 'LCF_INFO EST_PAID_X', "", 0));
            } 	//if
        } 	//PopulateLcf

        function PrintLcf() {           
            $('#btnPrintLcf').css('visibility', 'hidden');
            $('#AppError').text('');
            window.print();           
            $('#btnPrintLcf').css('visibility', 'visible');           

        } 	//PrintLcf
        function BackLF() {
            debugger;
            $('#losscarryforward').css('display', 'none');
            if (Sch == 'A') {
                $('#BPT_SchdA').css('display', 'block');
            }
            else if (Sch == 'B') {
                $('#BPT_SchdB').css('display', 'block');
            }
           
            //parent.setFrameUrl('Returns/BPT_LF/BPTlf?y=' + 2017);
        }
</script>
</head>
<body onload="DisplayLCF()">
   <div id="losscarryforward" style="display:none" >

       <%-- <div class="block3">

            <div class="container-fluid">

                <div class="row">
        <div class="col-lg-12 col-md-12">
            <div style="display: block;" id="tab1" class="blue_base_box">
               <h2><span id="AppHeader1">&nbsp;</span>  </h2>
                <div class="inner_white-panel">
                <div class="contentsection">
                     <div class="row">--%>


                        <div class="col-lg-12">
                   <%-- <div class="clearfix"></div>
                      <br>--%>
                    <div class="row">


                        <div class="col-lg-12 templateclass">
                      <div class="ploss">
           
            <h6><strong><label id="AppHeader1">TAX Filing Information</label></strong></h6>
            
            <%--<h5><label style="width:100%" id="lblAccountName"><strong>John Q Sample</strong></label><span><strong>Account # :</strong></span>
                <label style="width:100%" id="lblAccountNumber">9999999</label></h5>--%>
            
            <p ><label id="lblYearCurrent">Loss carry forward available for the  2012 Business Income and Receipts Tax return</label> </p>
               
            
            <h5 id="lblLcfAmount"><strong>$0.00</strong> </h5>
            
            <div class="clear"></div>
           
           
            <p>This figure is based on the income / loss reported on the following <label  id="lblIncomeLoss">BIRT returns:</label> </p>
            
            
             <h5><strong><label style="width:100%"  id="lblYearMinus1">2011 BIRT Return   :</label>   <label style="width:100%" id="lblYearMinus1Amount">$0.00</label></strong><br />
				 <strong><label style="width:100%"  id="lblYearMinus2">2010 BIRT Return   :</label>   <label style="width:100%" id="lblYearMinus2Amount">$0.00</label></strong><br />
                 <strong><label style="width:100%"  id="lblYearMinus3">2009 BIRT Return   :</label>  <label style="width:100%" id="lblYearMinus3Amount">$0.00</label></strong><br />
                </h5>
            
            <p>Losses  may be carried forward for only 3 years.  Losses reported on <label style="width:100%" id="lblYearMinus4">2008</label> and prior returns have expired.</p>
            
            <p>Estimated Business Income and receipts tax payment on file to be included on line 6B.</p>
            
            
            <h5 id="lblEstimatedTax"><strong>$0.00</strong></h5>
            <br />
                <p ><b>If the payment on file does not agree with your records, send an e-mail to revenue@phila.gov or call 215-686-6600</b></p>
<br />

             <div class="form_segment here_input_table" align="right">
                 <input type="button" value="Back" class="submit_button_light" onclick="BackLF()" id="Button1"/>
                                <input type="button" value="Print" class="submit_button_light" onclick="PrintLcf()" id="btnPrintLcf"  />
                 </div>
                         
            </div>
                            
                        </div>
                        <div class="clearfix"></div>

                    </div>
                   <%-- </div>
                  </div>
                </div>
               </div>
              
            </div>
             <div class="clearfix"></div>
            </div>        
           </div>
          </div>--%>
         </div>
        </div>
</body>
</html>
