﻿Type.registerNamespace("Sys.Extended.UI.HTMLEditor.ToolbarButton");Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste=function(n){Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste.initializeBase(this,[n])};Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste.prototype={canBeShown:function(){return Sys.Extended.UI.HTMLEditor.isIE},callMethod:function(){var n,t,i;if(!Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste.callBaseMethod(this,"callMethod"))return!1;n=this._designPanel;Sys.Extended.UI.HTMLEditor.isIE?(n._saveContent(),n.openWait(),setTimeout(function(){n._paste(!0);n.closeWait()},0)):(t=n._getSelection(),i=n._createRange(t),n._removeAllRanges(t),alert(String.format(Sys.Extended.UI.Resources.HTMLEditor_toolbar_button_Use_verb,Sys.Extended.UI.HTMLEditor.isSafari&&navigator.userAgent.indexOf("mac")!=-1?"Apple-V":"Ctrl-V")),n._selectRange(t,i),n.isWord=!1,n.isPlainText=!1)}};Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste.registerClass("Sys.Extended.UI.HTMLEditor.ToolbarButton.Paste",Sys.Extended.UI.HTMLEditor.ToolbarButton.MethodButton);