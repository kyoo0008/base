/**
 * editor_plugin_src.js
 *
 * Copyright 2009, Moxiecode Systems AB
 * Released under LGPL License.
 *
 * License: http://tinymce.moxiecode.com/license
 * Contributing: http://tinymce.moxiecode.com/contributing
 */

(function() {
	tinymce.create('tinymce.plugins.AdvancedFilePlugin', {
		init : function(ed, url) {
			// Register commands
			ed.addCommand('mceAdvFile', function() {
				// Internal image object like a flash placeholder
				if (ed.dom.getAttrib(ed.selection.getNode(), 'class', '').indexOf('mceItem') != -1)
					return;

				ed.windowManager.open({
					file : url + '/file.htm',
					width : 500 + parseInt(ed.getLang('advfile.delta_width', 0)),
					height : 460 + parseInt(ed.getLang('advfile.delta_height', 0)),
					inline : 1
				}, {
					plugin_url : url,
					window : window,
					insert_html : true
				});
			});

			// Register buttons
			ed.addButton('file', {
				title : 'advfile.file_desc',
				cmd : 'mceAdvFile'
			});
		},

		getInfo : function() {
			return {
				longname : 'Advanced file',
				author : 'Moxiecode Systems AB',
				authorurl : 'http://tinymce.moxiecode.com',
				infourl : 'http://wiki.moxiecode.com/index.php/TinyMCE:Plugins/advfile',
				version : tinymce.majorVersion + "." + tinymce.minorVersion
			};
		}
	});

	// Register plugin
	tinymce.PluginManager.add('advfile', tinymce.plugins.AdvancedFilePlugin);
})();