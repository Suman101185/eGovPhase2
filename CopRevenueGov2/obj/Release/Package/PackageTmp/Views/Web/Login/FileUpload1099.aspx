<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<!DOCTYPE html>

<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>FileUpload</title>
    <script id="clientEventHandlersJS" language="javascript" type="text/javascript">

        $(document).ready(function () {

            //==================For Validation Start============================
            //Get file size
            function GetFileSize(fileid) {

                try {
                    var fileSize = 0;
                    //for IE
                    if ($.browser) {

                        //====before making an object of ActiveXObject,======== 
                        //===please make sure ActiveX is enabled in your IE browser======
                        var objFSO = new ActiveXObject("Scripting.FileSystemObject");
                        var filePath = $("#" + fileid)[0].value;
                        var objFile = objFSO.getFile(filePath);
                        var fileSize = objFile.size; //size in kb
                        fileSize = fileSize / 1048576; //size in mb 
                    }
                        //====for FF, Safari, Opeara and Others=========
                    else {
                        fileSize = $("#" + fileid)[0].files[0].size //size in kb
                        fileSize = fileSize / 1048576; //size in mb 
                    }
                    return fileSize;
                }
                catch (ex) {
                    alert("Error is :" + ex);
                }
            }

            //========get file path from client system===================
            function getNameFromPath(strFilepath) {

                var objRE = new RegExp(/([^\/\\]+)$/);
                var strName = objRE.exec(strFilepath);

                if (strName == null) {
                    return null;
                }
                else {
                    return strName[0];
                }
            }

            $(function () {
                $("#btnSubmit1").click(function () {
                   
                    if ($('#fileToUpload1').val() == "") {
                        $("#spanfile").html("Please upload file");
                        return false;
                    }
                    else {
                        checkfile();
                        if (flag == true && $("#spanfile").text() == '') {
                           
                            //=========Parameter Declaration=====================                          
                            var fileUpload = $("#fileToUpload1").get(0);
                            var files = fileUpload.files;
                           
                            //======Create FormData object======================  
                            var fileData = new FormData();

                            //=========Looping over all files and add it to FormData object================  
                            for (var i = 0; i < files.length; i++) {
                                fileData.append(files[i].name, files[i]);
                                
                            }
                           // var url = "FileUploadHandler.ashx";
                            var url = '../Login/Upload_1099';
                            var progress_bar_1099_id = '#progress1099-wrp';
                            $.ajax({
                                url: url,
                                type: 'post',                                
                                contentType: false,
                                processData: false,
                                timeout: 2400000,
                                data: fileData,
                                xhr: function () {
                                    //upload Progress
                                    var xhr = $.ajaxSettings.xhr();
                                    if (xhr.upload) {
                                        xhr.upload.addEventListener('progress', function (event) {
                                            var percent = 0;
                                            var position = event.loaded || event.position;
                                            var total = event.total;
                                            if (event.lengthComputable) {
                                                percent = Math.ceil(position / total * 100);
                                            }
                                            if (percent == 100) {
                                                $("#progress1099-wrp").hide();
                                                $("#progress1099").show();
                                                $("#fileprocessedMsg1099").show();
                                                
                                            }
                                            //update progressbar
                                            $(progress_bar_1099_id + " .progress1099-bar").css("width", +percent + "%");
                                            $(progress_bar_1099_id + " .status1099").text(percent + "%");
                                        }, true);
                                    }
                                    return xhr;
                                },
                                success: function (result) {
                                    $("#fileprocessedMsg1099").hide();
                                    $("#progress1099").hide();
                                    $("#progress1099-wrp").hide();
                                    alert(result);
                                    $('#fileToUpload1').val('');
                                    $(progress_bar_1099_id + " .progress1099-bar").css("width", "0%");
                                    $(progress_bar_1099_id + " .status1099").text("0%");
                                    $("#progress1099-wrp").show();
                                },
                                error: function (err) {
                                     $("#progress1099-wrp").show();
                                     $("#progress1099").hide();
                                     $("#fileprocessedMsg1099").hide();
                                    alert(err.statusText);
                                }
                            });
                            event.preventDefault ? event.preventDefault() : (event.returnValue = false);
                        }
                    }
                });
            });
            function checkfile() {
                               
                    var file = getNameFromPath($("#fileToUpload1").val());
                if (file != null) {
                    var extension = file.substr((file.lastIndexOf('.') + 1));
                    switch (extension) {
                        case 'txt':
                        case 'doc':
                        case 'docx':
                        case 'xlsx':
                        case 'pdf':
                        case 'TXT':
                        case 'DOC':
                        case 'DOCX':
                        case 'XLSX':
                        case 'PDF':
                            flag = true;
                            break;
                        default:
                            flag = false;
                    }
                }
                if (flag == false) {
                    $("#spanfile").text("You can upload only txt,docx,xlsx,pdf extension file");
                    return false;
                }
                else {
                    if ($("#fileToUpload1").val() != '') {
                        var size = GetFileSize('fileToUpload1');
                        if (size > 10000) {
                            $("#spanfile").text("You can upload file up to 1 GB");
                            return false;
                        }
                        else {
                            $("#spanfile").text("");
                        }
                    }
                }
            }

            $(function () {
                $("#fileToUpload1").change(function () {
                    checkfile();
                });
            });

            //================For Validation End=====================
        });
    </script>
     <style type="text/css">
        .form-wrap{
    max-width: 500px;
    padding: 30px;
    background: #f1f1f1;
    margin: 20px auto;
    border-radius: 4px;
	text-align: center;
}
.form-wrap form{
	border-bottom: 1px dotted #ddd;
	padding: 10px;
}
.form-wrap #output{
    margin: 10px 0;
}
.form-wrap .error{
    color: #d60000;
}
.form-wrap .images {
    width: 100%;
    display: block;
    border: 1px solid #e8e8e8;
    padding: 5px;
    margin: 5px 0;
}
.form-wrap .thumbnails {
    width: 32%;
    display: inline-block;
    margin: 3px;
}

/* progress bar */
#progress1099-wrp {
    border: 1px solid #0099CC;
    padding: 1px;
    position: relative;
    border-radius: 3px;
    margin: 10px;
    text-align: left;
    background: #fff;
    box-shadow: inset 1px 3px 6px rgba(0, 0, 0, 0.12);
    height:25px;
}
#progress1099-wrp .progress1099-bar{   
	height: 20px;
    border-radius: 3px;
    background-color: #f39ac7;
    width: 0;
    box-shadow: inset 1px 1px 10px rgba(0, 0, 0, 0.11);
}
#progress1099-wrp .status1099{
	top:3px;
	left:50%;
	position:absolute;
	display:inline-block;
	color: #000000;
}
    </style>
</head>
<body>
    <div class="form-group">
        <div class="row table-responsive">
            <div class="col-lg-12">

                <table summary="Employee Pay Sheet" class="table table-condensed table-striped custom_table03">

                    <tbody>

                        <tr>
                            <td width="5%"></td>
                            <td width="70%"><p style=" font: bold 17px/25px Verdana;">Electronically file your 1099 forms</p></td>
                            <td colspan="2" width="25%"></td>
                        </tr>
                        <tr>
                            <td width="5%"></td>
                            <td width="70%" class="text-left">
                                <input type="file" id="fileToUpload1" name="file" style="margin: 20px auto;" />
                                <span class="field-validation-error" id="spanfile"></span>
                                <label id="lblUO1_14"></label>
                            </td>
                            <td colspan="2" align="center" width="25%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="5%"></td>
                            <td width="70%" class="text-left"></td>
                            <td colspan="2" align="center" width="25%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="5%"></td>
                             <td align="center" width="70%">
                                <div class="form-horizontal">
                                    <div class="form-group no-margin">
                                        <div class="">
                                            <input class="submit_button" id="btnSubmit1" name="btnSubmit" type="submit" value="Upload" style="margin:0 auto 15px;">
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td colspan="2" width="25%" class="text-left"> <input type="text" class="form-control input-sm " id="txt_BPT_WSEZ1" maxlength="10" style="WIDTH: 25%; display:none"></td>
                           
                        </tr>

                    </tbody>
                </table>
                <div class="progress1099-wrp" id="progress1099-wrp"><div class="progress1099-bar"></div ><div class="status1099">0%</div></div>
                <div id="fileprocessedMsg1099" style="display:none">The file has been processed successfully.Please wait while server processing the file</div><br />
                <span id="progress1099" style="display:none;text-align:center;margin-left:76px">
                <img id="id2" alt="" src="../../Content/images/gif-load.gif">
                </span>
                <div class="clear"></div>
            </div>
        </div>
    </div>
</body>
</html>
