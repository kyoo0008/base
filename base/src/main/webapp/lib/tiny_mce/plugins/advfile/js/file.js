tinyMCEPopup.requireLangPack();

var win, insert_html, adfile_external_param;
var FileDialog = {

	init : function(ed) {
		var ed = tinyMCEPopup.editor;
		
		win = tinyMCEPopup.getWindowArg("window");
		insert_html = tinyMCEPopup.getWindowArg("insert_html");
		
		adfile_external_param = tinyMCEPopup.getParam("adfile_external_param");
		var param = "path=" +  adfile_external_param.storePath;
		param += ", SiteId=" +  adfile_external_param.siteId;
		param += ", appendPath=" +  adfile_external_param.appendPath;
		param += ", UploadType=FILE";
		param += ", MaxFileSize=" + (win.document.getElementById("posblAtchFileSize_" + adfile_external_param.editorId).value - win.document.getElementById("fileCurrSize_" + adfile_external_param.editorId).value);
		param += ", MaxFileCount=" + (win.document.getElementById("posblAtchFileNumber_" + adfile_external_param.editorId).value - win.document.getElementById("fileCurrCount_" + adfile_external_param.editorId).value);
		param += ", AtchFileId=" +  win.document.getElementById("fileGroupId_" + adfile_external_param.editorId).value;
		
		document.getElementById("lblCurrSize").innerHTML = win.fn_byte_convert(win.document.getElementById("fileCurrSize_" + adfile_external_param.editorId).value);
		document.getElementById("lblMaxSize").innerHTML = win.fn_byte_convert(win.document.getElementById("posblAtchFileSize_" + adfile_external_param.editorId).value);
		
		var plugin = "				<object id='MultiFileUploader' data='data:application/x-silverlight-2,' type='application/x-silverlight-2' width='100%' height='300'>";
		plugin += "				   <param name='onload' value='pluginLoaded' />";
		plugin += "				  <param name='source' value='MultiUploader.xap'/>";
		plugin += "				  <param name='onError' value='onSilverlightError' />";
		plugin += "				  <param name='background' value='white' />";
		plugin += "				  <param name='minRuntimeVersion' value='4.0.50826.0' />";
		plugin += "				  <param name='autoUpgrade' value='true' />";
		plugin += "				  <param name='initParams' value='" + param + "' />";
		plugin += "				  <a href='http://go.microsoft.com/fwlink/?LinkID=149156&v=4.0.50826.0' style='text-decoration:none'>";
		plugin += "					  <img src='http://go.microsoft.com/fwlink/?LinkId=161376' alt='Microsoft Silverlight 얻기' style='border-style:none'/>";
		plugin += "				  </a>";
		plugin += "				</object><iframe id='_sl_historyFrame' style='visibility:hidden;height:0px;width:0px;border:0px'></iframe></div>";
		
		document.getElementById("plugin").innerHTML = plugin;
	},

	insert : function(file, title) {
		
		var ed = tinyMCEPopup.editor, t = this, f = document.forms[0];

		StartUpload();
	}

	
};

tinyMCEPopup.onInit.add(FileDialog.init, FileDialog);


var slCtl = null;

        function pluginLoaded(sender) {

            slCtl = document.getElementById("MultiFileUploader");
            slCtl.Content.Files.AllFilesFinished = AllFilesFinished;
            slCtl.Content.Files.FileAdded = UpdateFileList;
            slCtl.Content.Files.FileRemoved = UpdateFileList;
            
            slCtl.Content.Control.MaximumFileSizeReached = MaximumFileSizeReached;
            slCtl.Content.Control.MaximumFileCountReached = MaximumFileCountReached;
        }

        function AllFilesFinished() {
        	if (slCtl != null) {
                if(slCtl.Content.Files.TotalUploadedFiles > 0) {
                	if(win.fn_egov_editor_file_add) {
                		for (var i = 0; i < slCtl.Content.Files.FileList.length; i++) {
                			win.fn_egov_editor_file_add(slCtl.Content.Files.FileList[i].ResUserFile, adfile_external_param.editorId);
                			
                			if(insert_html) {
	                			var html = "";
	                			html = html + "<a class='" + slCtl.Content.Files.FileList[i].ResUserFile.AtchFileId + "_" + slCtl.Content.Files.FileList[i].ResUserFile.FileSn + "' href='/cmm/fms/FileDown.do?atchFileId=" + slCtl.Content.Files.FileList[i].ResUserFile.AtchFileId + "&fileSn=" + slCtl.Content.Files.FileList[i].ResUserFile.FileSn + "' title='파일 다운로드'>";
	                			html = html + "[" + slCtl.Content.Files.FileList[i].ResUserFile.FileName + "]";
	                			html = html + "</a>";               			
	                			
	                			tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
                			}
                		}
                	}
                }
            }
            
        	tinyMCEPopup.editor.focus();
        	tinyMCEPopup.close();
        }

        function UpdateFileList() {
        	var totalSize = 0;
            var userFile;
            for (var i = 0; i < slCtl.Content.Files.FileList.length; i++) {
                userFile = slCtl.Content.Files.FileList[i];
                //if(userFile.StateString == "Finished") {
                	totalSize += userFile.FileSize;
                //}
            }
        }

        function StartUpload() {
            if (slCtl != null) {
                slCtl.Content.Control.StartUpload();
            }
        }

        function MaximumFileSizeReached() {
            alert('첨부가능한 최대용량을 초과 하였습니다.');
        }
        
        function MaximumFileCountReached() {
        	alert('첨부가능한 최대갯수를 초과 하였습니다.');
        }