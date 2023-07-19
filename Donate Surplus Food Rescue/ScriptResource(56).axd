﻿Type.registerNamespace("Sys.Extended.UI.HTMLEditor");Sys.Extended.UI.HTMLEditor.LastFocusedEditPanel=null;Sys.Extended.UI.HTMLEditor.EditPanel=function(n){Sys.Extended.UI.HTMLEditor.EditPanel.initializeBase(this,[n]);this._loaded=!1;this._eAfter=null;this._toolbars=null;this._modePanels=null;this._contentChangedElement=null;this._contentElement=null;this._contentForceElement=null;this._activeModeElement=null;this._suppressTabInDesignMode=!1;this._keyboardEnabled=!0;this._noPaste=!1;this._hotkeys=null;this._showAnchors=!1;this._showPlaceHolders=!1;this._startEnd=!0;this._relativeImages=!0;this._documentCssPath=null;this._designPanelCssPath=null;this._imagePath_1x1=null;this._imagePath_flash=null;this._imagePath_media=null;this._imagePath_anchor=null;this._imagePath_placeHolder=null;this._autofocus=!0;this._initialCleanUp=!1;this._noScript=!1;this._noUnicode=!1;this._cachedToolbarIds=null;this._contentPrepared=!1;this._activeMode=null;this._pageRequestManager=null;this._formOnSubmitSaved=null;this._validators=null;this._app_onload$delegate=Function.createDelegate(this,this._app_onload);this._onsubmit$delegate=Function.createDelegate(this,this._onsubmit);this._disposed=!0};Sys.Extended.UI.HTMLEditor.EditPanel.prototype={get_relativeImages:function(){return this._relativeImages},set_relativeImages:function(n){this._relativeImages=n;this._loaded&&this.raisePropertyChanged("relativeImages")},get_startEnd:function(){return this._startEnd},set_startEnd:function(n){this._startEnd=n;this._loaded&&this.raisePropertyChanged("startEnd")},get_showPlaceHolders:function(){return this._showPlaceHolders},set_showPlaceHolders:function(n){this._showPlaceHolders=n;this._loaded&&this.raisePropertyChanged("showPlaceHolders")},get_showAnchors:function(){return this._showAnchors},set_showAnchors:function(n){this._showAnchors=n;this._loaded&&this.raisePropertyChanged("showAnchors")},get_hotkeys:function(){return this._hotkeys},set_hotkeys:function(n){this._hotkeys=n;this._loaded&&this.raisePropertyChanged("noPaste")},get_noPaste:function(){return this._noPaste},set_noPaste:function(n){this._noPaste=n;this._loaded&&this.raisePropertyChanged("noPaste")},get_suppressTabInDesignMode:function(){return this._suppressTabInDesignMode},set_suppressTabInDesignMode:function(n){this._suppressTabInDesignMode=n;this._loaded&&this.raisePropertyChanged("suppressTabInDesignMode")},get_keyboardEnabled:function(){return this._keyboardEnabled},set_keyboardEnabled:function(n){this._keyboardEnabled=n;this._loaded&&this.raisePropertyChanged("keyboardEnabled")},get_noUnicode:function(){return this._noUnicode},set_noUnicode:function(n){this._noUnicode=n;this._loaded&&this.raisePropertyChanged("noUnicode")},get_noScript:function(){return this._noScript},set_noScript:function(n){this._noScript=n;this._loaded&&this.raisePropertyChanged("noScript")},get_initialCleanUp:function(){return this._initialCleanUp},set_initialCleanUp:function(n){this._initialCleanUp=n;this._loaded&&this.raisePropertyChanged("initialCleanUp")},get_imagePath_1x1:function(){return this._imagePath_1x1},set_imagePath_1x1:function(n){this._imagePath_1x1=n},get_imagePath_flash:function(){return this._imagePath_flash},set_imagePath_flash:function(n){this._imagePath_flash=n},get_imagePath_media:function(){return this._imagePath_media},set_imagePath_media:function(n){this._imagePath_media=n},get_imagePath_anchor:function(){return this._imagePath_anchor},set_imagePath_anchor:function(n){this._imagePath_anchor=n},get_imagePath_placeHolder:function(){return this._imagePath_placeHolder},set_imagePath_placeHolder:function(n){this._imagePath_placeHolder=n},get_documentCssPath:function(){return this._documentCssPath},set_documentCssPath:function(n){this._documentCssPath=n;this._loaded&&this.raisePropertyChanged("documentCssPath")},get_designPanelCssPath:function(){return this._designPanelCssPath},set_designPanelCssPath:function(n){this._designPanelCssPath=n;this._loaded&&this.raisePropertyChanged("designPanelCssPath")},get_autofocus:function(){return this._autofocus},set_autofocus:function(n){this._autofocus=n;this._loaded&&this.raisePropertyChanged("autofocus")},get_content:function(){return this._activeMode==null?this.get_contentElement()!=null?this._getContentForPostback():"":this.getContent()},set_content:function(n){if(!this.get_isInitialized()||!this._loaded){this.get_contentElement()!=null&&(this.get_contentElement().value=n.replace(/\"/g,"&quot;"));return}this.setContent(n);this._contentPrepared=!1;this._loaded&&this.raisePropertyChanged("content")},get_activeMode:function(){return this._activeMode==null?Sys.Extended.UI.HTMLEditor.ActiveModeType.Design:this._activeMode},set_activeMode:function(n){var t,i,r;if(!Sys.Extended.UI.HTMLEditor.ActiveModeType_checkValue(n))throw Error.argumentOutOfRange("value, function: Sys.Extended.UI.HTMLEditor.EditPanel.set_activeMode");return t=this._activeMode,i=!0,this._loaded&&t!=null&&t!=n?(r=new Sys.Extended.UI.HTMLEditor.ActiveModeChangedArgs(t,n,this),this.raiseBeforeActiveModeChanged(r),this._eAfter=new Sys.Extended.UI.HTMLEditor.ActiveModeChangedArgs(t,n,this),i=this._setMode(n)):this._activeMode=n,this.get_activeModeElement().value=n,i},get_contentChangedElement:function(){return this._contentChangedElement},set_contentChangedElement:function(n){this._contentChangedElement=n},get_contentElement:function(){return this._contentElement},set_contentElement:function(n){this._contentElement=n},get_contentForceElement:function(){return this._contentForceElement},set_contentForceElement:function(n){this._contentForceElement=n},get_activeModeElement:function(){return this._activeModeElement},set_activeModeElement:function(n){this._activeModeElement=n},setCancelOnPostback:function(){this._loaded&&(this.get_contentForceElement().value="")},setAcceptOnPostback:function(){this._loaded&&(this.get_contentForceElement().value="1")},get_toolbars:function(){return this._toolbars==null&&(this._toolbars=[]),this._toolbars},set_toolbars:function(n){this.get_toolbars().push(n)},get_toolbarIds:function(){},set_toolbarIds:function(n){var i,t;if(!this.get_isInitialized()){this._cachedToolbarIds=n;return}for(i=n.split(";"),t=0;t<i.length;t++)i[t].length>0&&this.set_toolbars($find(i[t]))},get_modePanels:function(){return this._modePanels==null&&(this._modePanels=[]),this._modePanels},set_modePanel:function(n){this.get_modePanels().push(n)},get_modePanelIds:function(){},set_modePanelIds:function(n){for(var i=n.split(";"),t=0;t<i.length;t++)this.set_modePanel($find(i[t]))},add_focused:function(n){this.get_events().addHandler("focused",n)},remove_focused:function(n){this.get_events().removeHandler("focused",n)},raiseFocused:function(n){var t=this.get_events().getHandler("focused");t&&t(this,n)},add_activeModeChanged:function(n){this.get_events().addHandler("activeModeChanged",n)},remove_activeModeChanged:function(n){this.get_events().removeHandler("activeModeChanged",n)},raiseActiveModeChanged:function(n){var t=this.get_events().getHandler("activeModeChanged");t&&t(this,n)},add_beforeActiveModeChanged:function(n){this.get_events().addHandler("beforeActiveModeChanged",n)},remove_beforeActiveModeChanged:function(n){this.get_events().removeHandler("beforeActiveModeChanged",n)},raiseBeforeActiveModeChanged:function(n){var t=this.get_events().getHandler("beforeActiveModeChanged");t&&t(this,n)},get_activePanel:function(){var n=this.get_modePanels()[this.get_activeMode()];if(n==null||typeof n=="undefined")throw Error.argumentOutOfRange("activeMode, function: Sys.Extended.UI.HTMLEditor.EditPanel.get_activePanel");return n},initialize:function(){this.__appLoaded__=!1;Sys.Extended.UI.HTMLEditor.EditPanel.callBaseMethod(this,"initialize");this._disposed=!1;Sys.Application.add_load(this._app_onload$delegate);Sys&&Sys.WebForms&&Sys.WebForms.PageRequestManager&&(this._pageRequestManager=Sys.WebForms.PageRequestManager.getInstance(),this._pageRequestManager&&(this._partialUpdateEndRequestHandler=Function.createDelegate(this,this._partialUpdateEndRequest),this._pageRequestManager.add_endRequest(this._partialUpdateEndRequestHandler),this._invokingRequestHandler=Function.createDelegate(this,this._invokingRequest),Sys.Net.WebRequestManager.add_invokingRequest(this._invokingRequestHandler),this._completedRequestHandler=Function.createDelegate(this,this._completedRequest),Sys.Net.WebRequestManager.add_completedRequest(this._completedRequestHandler)));Sys.Extended.UI.HTMLEditor.addFormOnSubmit(this._onsubmit$delegate,this)},dispose:function(){this._loaded=!1;this._disposed=!0;this._pageRequestManager&&(this._invokingRequestHandler&&(this._pageRequestManager.remove_endRequest(this._partialUpdateEndRequestHandler),this._partialUpdateEndRequestHandler=null,Sys.Net.WebRequestManager.remove_invokingRequest(this._invokingRequestHandler),this._invokingRequestHandler=null,Sys.Net.WebRequestManager.remove_completedRequest(this._completedRequestHandler),this._completedRequestHandler=null),this._pageRequestManager=null);Sys.Extended.UI.HTMLEditor.removeFormOnSubmit(this._onsubmit$delegate);Sys.Application.remove_load(this._app_onload$delegate);this.disableToolbars();Sys.Extended.UI.HTMLEditor.EditPanel.callBaseMethod(this,"dispose")},_onsubmit:function(){return this._contentPrepared||(this._prepareContentForPostback(this.get_content()),this._contentPrepared=!0),!0},_invokingRequest:function(n,t){if(!this._contentPrepared){var r=t.get_webRequest(),i=r.get_body(),u=new RegExp("([\\?&])("+this.get_contentElement().name+"=)([^&$]*)([&$])","g");this._prepareContentForPostback(this.get_content());i=i.replace(u,"$1$2"+escape(this.get_contentElement().value)+"$4");this._contentPrepared=!0;r.set_body(i)}},_completedRequest:function(){this._contentPrepared=!1},_partialUpdateEndRequest:function(){this._contentPrepared=!1;Sys.Extended.UI.HTMLEditor.isIE&&this.__blured&&(this.__blured=!1,this.get_activePanel()._focus())},_app_onload:function(){var s,i,t,u,n,r,f,e,o;this.__appLoaded__||(this.__appLoaded__=!0,this._disposed)||(s=this,this._loaded=!0,this.set_activeMode(parseInt(this.get_activeModeElement().value)),this._cachedToolbarIds!=null&&(this.set_toolbarIds(this._cachedToolbarIds),this._cachedToolbarIds=null),this._validators=this.get_modePanels()[Sys.Extended.UI.HTMLEditor.ActiveModeType.Html].get_element().Validators,this._shouldResize=!1,Sys.Extended.UI.HTMLEditor.isIE&&document.compatMode!="BackCompat"&&(this._shouldResize=!0),this._shouldResize&&(i=this.get_modePanels(),t=i[Sys.Extended.UI.HTMLEditor.ActiveModeType.Design],t==null&&(t=i[Sys.Extended.UI.HTMLEditor.ActiveModeType.Preview]),u=i[Sys.Extended.UI.HTMLEditor.ActiveModeType.Html],t!=null&&u!=null&&(n=t.get_element(),n.style.display="",r=n.offsetHeight,f=!1,r==0&&(f=!0,e=Sys.Extended.UI.HTMLEditor.setElementVisibility(n.parentNode),r=n.offsetHeight),u.get_element().style.height=r+"px",f&&(Sys.Extended.UI.HTMLEditor.restoreElementVisibility(e),delete e),n.style.display="none")),o=this.get_contentElement().value.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,'"').replace(/&amp;/g,"&"),this.setContent(this._initialCleanUp?Sys.Extended.UI.HTMLEditor.cleanUp(o.replace(/[\n\r]+/g," ")):o),this.setAcceptOnPostback())},_setActive:function(){for(var n=0;n<this.get_toolbars().length;n++)this.get_toolbars()[n].set_activeEditPanel(this,!0);this._eAfter!=null&&(this.raisePropertyChanged("activeMode"),this.raiseActiveModeChanged(this._eAfter),this._eAfter=null)},_focused:function(n){if(!(typeof n!="undefined"&&n))for(var t=0;t<this.get_toolbars().length;t++)this.get_toolbars()[t].set_activeEditPanel(this);Sys.Extended.UI.HTMLEditor.LastFocusedEditPanel=this},_really_focused:function(){this._focused();this.raiseFocused(new Sys.EventArgs)},updateToolbar:function(){this._focused()},getContent:function(){var n=this.get_activePanel().get_content().replace(/<\/?html(?=\s|>)(?:[^>]*?)>/gi,"").replace(/<\/?head(?=\s|>)(?:[^>]*?)>/gi,"").replace(/<\/?body(?=\s|>)(?:[^>]*?)>/gi,"").replace(/^([\n\r]+)/,"").replace(/([\n\r]+)$/,"");return Sys.Extended.UI.HTMLEditor.isIE||(n=n.replace(/^<br\s*[\/]*>$/,"")),n},setContent:function(n){var t=n;this.get_noScript()&&(t=t.replace(/(<script(?:[^>]*?)>(?:[^<]*?)<\/script(?:[^>]*?)>)/ig,""));t=t.replace(/<\/?html(?=\s|>)(?:[^>]*?)>/gi,"").replace(/<\/?head(?=\s|>)(?:[^>]*?)>/gi,"").replace(/<\/?body(?=\s|>)(?:[^>]*?)>/gi,"").replace(/^([\n\r]+)/,"").replace(/([\n\r]+)$/,"");this._prepareContentForPostback(t);this.get_activePanel().set_content(t);this._validate(null,t)},_validate:function(n,t){var i=this._validators,r;if(i!=null&&typeof i!="undefined"){this._contentForValidation=t;try{for(r=0;r<i.length;r++)window.ValidatorValidate(i[r],null,n);window.ValidatorUpdateIsValid()}catch(u){}this._contentForValidation=null}},_prepareContentForPostback:function(n){this.get_contentElement().value=n.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\"/g,"&quot;")},_getContentForPostback:function(){return this.get_contentElement().value.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&quot;/g,'"').replace(/&amp;/g,"&")},_setMode:function(n){var o=this.get_activePanel(),s,t,i,r;if(!o._activated)return s=this,setTimeout(function(){s._setMode(n)},10),!1;if(t=this.get_content(),Sys.Extended.UI.HTMLEditor.isOpera&&(t=t.replace(/\r/ig,"")),this._shouldResize&&n==Sys.Extended.UI.HTMLEditor.ActiveModeType.Html&&(i=this.get_activePanel(),r=this.get_modePanels()[Sys.Extended.UI.HTMLEditor.ActiveModeType.Html],i!=null&&r!=null)){var u=i.get_element(),f=u.offsetHeight,h=!1,e;f==0&&(h=!0,e=Sys.Extended.UI.HTMLEditor.setElementVisibility(u.parentNode),f=u.offsetHeight);r.get_element().style.height=f+"px";h&&(Sys.Extended.UI.HTMLEditor.restoreElementVisibility(e),delete e)}return this.disableToolbars(n),o._deactivate(),this._activeMode=n,this.setContent(t),!0},disableToolbars:function(n){for(var i,t=0;t<this.get_toolbars().length;t++)i=this.get_toolbars()[t],i._loaded&&i.disable(n)},openWait:function(){},closeWait:function(){}};Sys.Extended.UI.HTMLEditor.EditPanel.registerClass("Sys.Extended.UI.HTMLEditor.EditPanel",Sys.UI.Control);