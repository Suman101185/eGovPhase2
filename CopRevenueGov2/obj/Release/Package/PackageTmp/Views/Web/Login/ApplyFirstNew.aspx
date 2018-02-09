<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script id="clientEventHandlersJS" language="javascript" type="text/javascript">

    var arrAppFirst = new Array();


    function DisplayApplyFirst() {
        $('#trError').css('display', 'none');
        parent.sNew = true;
        
        $('#divApplyFirst').css('display', 'block');
        $('#LogApplyFirst').css('display', 'block');
        $('#AppHeaderApply').html(txtHeader + '<span > | application for a ' +
                'philadelphia tax account number</span>');

        //var xmlDoc = parent.$g.xmlEntityType;
        var ddTaxIDType = document.getElementById('ddTaxIDType');
        LoadGenericDD(parent.$g.xmlEntityType, ddTaxIDType, "DDOWN", false);
        ddTaxIDType.selectedIndex = 0;
        // $('#txtIdNumber').val('');
        $('#txtId1Number').val('');
        loadAppFirstError();
        $('ddTaxIDType').focus();
    }
    $(function () {
        $('#txtId1Number').keypress(function (evt) {
            if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                return false;
            }
        });
    });
   
    function loadAppFirstError() {
        var ddTaxIDType = document.getElementById('ddTaxIDType');
        var txtId1Number = document.getElementById('txtId1Number');
        var i = 0;
        arrAppFirst[i++] = [ddTaxIDType, '$(\'#ddTaxIDType option:selected\').text() == "Select"', 'Select Tax type'];
        arrAppFirst[i++] = [txtId1Number, '$(\'#txtId1Number\').val() == ""', 'ID number required'];
        arrAppFirst[i++] = [txtId1Number, '$(\'#txtId1Number\').val().length != 9', 'ID number is invalid'];
       
    }
    var dobj = parent.$g.getXmlDocObj();


    $(function (e) {
        $('#ddTaxIDType').keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoApplyFirst();
                $("#btnIDSubmit").click();
            }

        });
        $("#txtId1Number").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoApplyFirst();
                $("#btnIDSubmit").click();
            }

        });
        $("#btnIDSubmit").keyup(function (e) {
            if ((e.which == 13) || (e.keyCode == 13)) {
                DoApplyFirst();
                $("#btnIDSubmit").click();
            }

        });

    });

    function DoApplyFirst() {
        
       
        ValidateAppFirst();
       
        var ddTaxIDType = document.getElementById('ddTaxIDType');
       
        var app = $("#AppError_Af").text();
        //alert(app);
        $('#trError').css('display', 'none');
        //ValidateAppFirst();
        if (app == '') {
            
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "1", "ENTITY_INFO FUNCTION_CODE", '', 0);

           
            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr("CODE"), "ENTITY_INFO TYPE", '', 0);
           
            

            parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#txtId1Number").val(), "ENTITY_INFO ENTITY_ID", '', 0);
          

          
            ispCallXMLForm(parent.$g.xmlAccount, dobj, "AccountInfo", "");//Sanghamitra
          

           

            parent.$g.xmlAccount.loadXML(dobj.xml);

            var error_code = parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO ERROR", "", 0);

            if (error_code == "0" || error_code == "") {
                
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, "A", "ENTITY_INFO FUNCTION_CODE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $("#ddTaxIDType option:selected").attr("CODE"), "ENTITY_INFO TYPE", '', 0);
                parent.$x.ispXmlSetFieldVal(parent.$g.xmlAccount, $('#txtId1Number').val(), "ENTITY_INFO ENTITY_ID", '', 0);

                parent.sNew = true;
              
                parent.setFrameUrl('Acct/ApplyMain');
            }
            else
            {
                if (parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO ERROR", "", 0) == "1" &&
                        parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO MESSAGE", "", 0).search('ENTITY EXISTS') != -1) {
                    $('#trError').css('display', 'block');
                    resolvedIframeheight();
                } else {
                    $(AppError_Af).text(parent.$x.ispXmlGetFieldVal(parent.$g.xmlAccount, "ERROR_INFO MESSAGE", "", 0));
                    resolvedIframeheight();
                }
            }
        }
        else
        {
            //$('#ddTaxIDType').focus();
        }

    }

    function ValidateAppFirst() {
       
        var errMsg = ispSetInputErr(arrAppFirst)
      
        $(AppError_Af).text(errMsg);
        resolvedIframeheight();
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

<div class="container-fluid no-padding">
    <div id="divApplyFirst" class="block3" style="display: none;">
        <div class="container-fluid">
            <div class="row row-no-margin">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" name="LogApplyFirst" style="display: none;" id="LogApplyFirst">
                    <div class="blue_base_box">
                        <h2 id="AppHeaderApply"></h2>

                        <div class="inner_white-panel">
                            <div class="row">
                                   <div class="col-lg-12 col-lg-offset-0">
                                 <div id="AppError_Af" class="errormsg no-padding" style="display:block;"></div>
                                       </div></div>
                            <div class="contentsection">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <h4>Please enter your Employer Indentification Number (EIN) or Social Security Number (SSN).</h4>
                                    </div>
                                </div>
                                <div class="clearfix"></div>

                                <div class="row">

                                    <div class="col-lg-12">

                                        <form class="form-horizontal login_form">
                                            <div class="form-group text-left-custom">
                                                <label for="inputEmail3" class="col-sm-3 control-label text-left-custom">SSN / EIN<span style="color:red">*</span> : </label>
                                                <div class="col-sm-9 apply_custom">
                                                    <%-- <input type="email" class="form-control input-sm" id="inputEmail3" placeholder="Email">--%>
                                                    <select id="ddTaxIDType" name="ddTaxIDType" class="form-control input-sm"
                                                        onchange="ValidateAppFirst()">
                                                        <option selected></option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="" class="col-sm-3 control-label text-left-custom">&nbsp;</label>
                                                <div class="col-sm-9">
                                                    <input id="txtIdNumber" align="right" size="11" name="txtIdNumber" style="display:none;"
                                                        maxlength="9" onchange="ValidateAppFirst()" class="form-control input-sm inpNormal">
                                                      <input id="txtId1Number" align="right" size="11" name="txtIdNumber"
                                                        maxlength="9" onchange="ValidateAppFirst()" class="form-control input-sm inpNormal">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-6">
                                                    <%-- <button type="submit" class="btn btn-default submit_button" id="btnLogin" onclick="DoLogin()">Submit</button>--%>
                                                    <input class="btn btn-default submit_button" id="btnIDSubmit" type="button" value="Submit" valign="bottom" onclick="DoApplyFirst()">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-0 col-sm-9">
                                                    <div <%--class="topof_login_msgbox"--%>>

                                                        <p>Individuals: You MUST enter your Social Security Number. </p>
                                                    </div>
                                                    <div class="">
                                                        <p id="trError">
                                                            ENTITY ALREADY EXISTS IN TAXPAYER INFORMATION SYSTEM.
                                            <br />
                                                            PLEASE ADD OR CHANGE TAX ACCOUNT INFORMATION TO CONTINUE.
                                            <br />
                                                            IF YOU ALREADY HAVE A PIN, <a onclick="ShowForm('LogLogin')">LOG IN.</a>
                                                            <br />
                                                            IF YOU NEED A PIN, <a onclick="ShowForm('LogPinApply')">GET A PIN</a><br />
                                                        </p>

                                                        <div class="clear"></div>

                                                    </div>
                                                </div>
                                            </div>

                                        </form>
                                    </div>
                                </div>

                                <%-- <div class="clearfix"></div>--%>
                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>

    </div>
</div>
