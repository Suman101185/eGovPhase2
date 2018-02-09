<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html>
<HEAD>
    <TITLE></TITLE>
<script id="clientEventHandlersJS" language="javascript" type="text/javascript" >

    var arrAppFirst = new Array();


    function DisplayApplyFirst() {
        $('#trError').css('display', 'none');
        parent.sNew = true;
        $('#LogApplyFirst').css('display', 'block');
        $('#AppHeaderApply').html(txtHeader + '<Font >|application for a ' +
                'philadelphia tax account number</Font>');

        var xmlDoc = parent.$g.xmlEntityType;

        LoadGenericDD(parent.$g.xmlEntityType, ddTaxIDType, "DDOWN", false);
        ddTaxIDType.selectedIndex = 0;
        $('#txtIdNumber').val('');
        loadAppFirstError();
        ddTaxIDType.focus();
    }

    function loadAppFirstError() {
        var i = 0;
        arrAppFirst[i++] = [ddTaxIDType, '$(ddTaxIDType.options[ddTaxIDType.selectedIndex]).text()=="Select"', 'Select Tax ID Type'];
        arrAppFirst[i++] = [txtIdNumber, 'txtIdNumber.value.length != 9', 'Enter ID Number'];
        arrAppFirst[i++] = [txtIdNumber, 'isNaN(txtIdNumber.value)', 'ID Number Not Numeric'];
    }


    var dobj = parent.$g.getXmlDocObj();

    function DoApplyFirst() {

        $(parent.AppError).text('');
        $('#trError').css('display', 'none');
        ValidateAppFirst();
        if ($(parent.AppError).text() == "") {

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "1", "ENTITY_INFO FUNCTION_CODE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddTaxIDType.options[ddTaxIDType.selectedIndex]).attr('CODE'), "ENTITY_INFO TYPE", '', 0);
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value, "ENTITY_INFO ENTITY_ID", '', 0);
           
            ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo", "");//Sanghamitra

           

            parent.$g.xmlAccount.loadXML(dobj.xml);

            var error_code = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO ERROR", "", 0);

            if (error_code == "0" || error_code == "") {
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "1", "ENTITY_INFO FUNCTION_CODE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $(ddTaxIDType.options[ddTaxIDType.selectedIndex]).attr('CODE'), "ENTITY_INFO TYPE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, txtIdNumber.value, "ENTITY_INFO ENTITY_ID", '', 0);

                parent.sNew = true;

                //parent.DocWin.location.href = '../Acct/ApplyMain';
                parent.setFrameUrl('Acct/ApplyMain');
            } else {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO ERROR", "", 0) == "1" &&
                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO MESSAGE", "", 0).search('ENTITY EXISTS') != -1) {
                    $('#trError').css('display', 'block');
                } else {
                    $(parent.AppError).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO MESSAGE", "", 0));
                }
            }
        }
        else {
            ddTaxIDType.focus();
        }

    }

    function ValidateAppFirst() {
        $(parent.AppError).text(ispSetInputErr(arrAppFirst));
    }		//ValidateAppFirst

    function GotoForm(id) {
        $('#trError').css('display', 'none');
        if (id == 'LogPinApply') {
            DisplayPinApply();
        }
        else if (id == 'LogLogin') {
            DisplayLogin();
        }		//if
    }		//GotoForm


</script>
</HEAD>
<body>
   <div class="tab_Tcontainer">

   
    <div class="tab_container">
        <div style="display: none;" id="LogApplyFirst" class="tab_content">
            <h2 id="AppHeaderApply"></h2>
           	
            <div class="thankyou">
            <h4> Please enter your Employer Indentification Number (EIN) or Social Security Number (SSN).</h4>
				
            
            
            
            
            <div class="login_form">
            	
                  <div class="form_segment">
                        
                        <label>SSN/EIN: </label>
                        
                        <div class="here_input">
                            <SELECT  id="ddTaxIDType" name=ddTaxIDType style="WIDTH: 79px"
					 onchange="ValidateAppFirst()" class="inpNormal">
                     <OPTION selected ></OPTION>
                    </SELECT>
                           
                            
                            <div class="clear"></div>  
                            <INPUT id="txtIdNumber" align=right size=11 name=txtIdNumber 
					maxLength=9 onchange="ValidateAppFirst()" class="inpNormal">         
                        </div>
                                                
                        <div class="clear"></div>
              
              </div>
              
              
             	             
              
              <div class="form_segment">
                       
                        
                        <div class="here_input">
                            <INPUT class=submit_button id="btnIDSubmit" type="button" value="Submit" 
					valign="bottom" onclick="DoApplyFirst()">
                        	
                        </div>
                        
                        <div class="clear"></div>
              
              </div>
              
            	
               <div class="topof_login_msgbox">
                        
                        <p>Individuals: You MUST enter your Social Security Number. </p></div>
                        <div class="">
                       <p id="trError">
				ENTITY ALREADY EXISTS IN TAXPAYER INFORMATION SYSTEM. <br />
				PLEASE ADD OR CHANGE TAX ACCOUNT INFORMATION TO CONTINUE. <br />
				IF YOU ALREADY HAVE A PIN, <a onclick="ShowForm('LogLogin')">LOG IN.</a> <br />
				IF YOU NEED A PIN, <a onclick="ShowForm('LogPinApply')">GET A PIN</a><br /></p>
                        
                        <div class="clear"></div>
              
              </div>
                
                <div class="clear"></div>
            </div>
<br />
<br />

            </div>
            
            
            
            <div class="quicklink_btm_gen"></div>
        </div>
     	
    </div>
        </div>
</body>
</html>
