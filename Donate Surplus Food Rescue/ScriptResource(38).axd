﻿// (c) 2010 CodePlex Foundation
(function(){function n(){Type.registerNamespace("Sys.Extended.UI");Sys.Extended.UI.ConfirmButtonHiddenEventArgs=function(n){Sys.Extended.UI.ConfirmButtonHiddenEventArgs.initializeBase(this);this._confirmed=n};Sys.Extended.UI.ConfirmButtonHiddenEventArgs.prototype={get_confirmed:function(){return this._confirmed}};Sys.Extended.UI.ConfirmButtonHiddenEventArgs.registerClass("Sys.Extended.UI.ConfirmButtonHiddenEventArgs",Sys.EventArgs);Sys.Extended.UI.ConfirmButtonBehavior=function(n){Sys.Extended.UI.ConfirmButtonBehavior.initializeBase(this,[n]);this._ConfirmTextValue=null;this._OnClientCancelValue=null;this._ConfirmOnFormSubmit=!1;this._displayModalPopupID=null;this._postBackScript=null;this._clickHandler=null;this._oldScript=null};Sys.Extended.UI.ConfirmButtonBehavior.prototype={initialize:function(){Sys.Extended.UI.ConfirmButtonBehavior.callBaseMethod(this,"initialize");var n=this.get_element();this._clickHandler=Function.createDelegate(this,this._onClick);$addHandler(n,"click",this._clickHandler);this._oldScript=n.getAttribute("onclick");this._oldScript&&n.setAttribute("onclick",null);this._ConfirmOnFormSubmit&&typeof WebForm_OnSubmit=="function"&&!Sys.Extended.UI.ConfirmButtonBehavior._originalWebForm_OnSubmit&&(Sys.Extended.UI.TextBoxWatermarkBehavior&&Sys.Extended.UI.TextBoxWatermarkBehavior._originalWebForm_OnSubmit?(Sys.Extended.UI.ConfirmButtonBehavior._originalWebForm_OnSubmit=Sys.Extended.UI.TextBoxWatermarkBehavior._originalWebForm_OnSubmit,Sys.Extended.UI.TextBoxWatermarkBehavior._originalWebForm_OnSubmit=Sys.Extended.UI.ConfirmButtonBehavior.WebForm_OnSubmit):(Sys.Extended.UI.ConfirmButtonBehavior._originalWebForm_OnSubmit=WebForm_OnSubmit,WebForm_OnSubmit=Sys.Extended.UI.ConfirmButtonBehavior.WebForm_OnSubmit))},dispose:function(){this._clickHandler&&($removeHandler(this.get_element(),"click",this._clickHandler),this._clickHandler=null);this._oldScript&&(this.get_element().setAttribute("onclick",this._oldScript),this._oldScript=null);Sys.Extended.UI.ConfirmButtonBehavior.callBaseMethod(this,"dispose")},_onClick:function(n){if(this.get_element()&&!this.get_element().disabled)if(this._ConfirmOnFormSubmit)Sys.Extended.UI.ConfirmButtonBehavior._clickedBehavior=this;else if(this._displayConfirmDialog())this._oldScript&&(String.isInstanceOfType(this._oldScript)?eval(this._oldScript):typeof this._oldScript=="function"&&this._oldScript());else return n.preventDefault(),!1},_displayConfirmDialog:function(){var i=new Sys.CancelEventArgs,n,t;if(this.raiseShowing(i),!i.get_cancel()){if(this._displayModalPopupID){if(n=$find(this._displayModalPopupID),!n)throw Error.argument("displayModalPopupID",String.format(Sys.Extended.UI.Resources.CollapsiblePanel_NoControlID,this._displayModalPopupID));return n.set_OnOkScript("$find('"+this.get_id()+"')._handleConfirmDialogCompletion(true);"),n.set_OnCancelScript("$find('"+this.get_id()+"')._handleConfirmDialogCompletion(false);"),n.show(),!1}return t=window.confirm(this._ConfirmTextValue),this._handleConfirmDialogCompletion(t),t}},_handleConfirmDialogCompletion:function(n){this.raiseHidden(new Sys.Extended.UI.ConfirmButtonHiddenEventArgs(n));n?this._postBackScript&&eval(this._postBackScript):this._OnClientCancelValue&&window[this._OnClientCancelValue]()},get_OnClientCancel:function(){return this._OnClientCancelValue},set_OnClientCancel:function(n){this._OnClientCancelValue!=n&&(this._OnClientCancelValue=n,this.raisePropertyChanged("OnClientCancel"))},get_ConfirmText:function(){return this._ConfirmTextValue},set_ConfirmText:function(n){this._ConfirmTextValue!=n&&(this._ConfirmTextValue=n,this.raisePropertyChanged("ConfirmText"))},get_ConfirmOnFormSubmit:function(){return this._ConfirmOnFormSubmit},set_ConfirmOnFormSubmit:function(n){this._ConfirmOnFormSubmit!=n&&(this._ConfirmOnFormSubmit=n,this.raisePropertyChanged("ConfirmOnFormSubmit"))},get_displayModalPopupID:function(){return this._displayModalPopupID},set_displayModalPopupID:function(n){this._displayModalPopupID!=n&&(this._displayModalPopupID=n,this.raisePropertyChanged("displayModalPopupID"))},get_postBackScript:function(){return this._postBackScript},set_postBackScript:function(n){this._postBackScript!=n&&(this._postBackScript=n,this.raisePropertyChanged("postBackScript"))},add_showing:function(n){this.get_events().addHandler("showing",n)},remove_showing:function(n){this.get_events().removeHandler("showing",n)},raiseShowing:function(n){var t=this.get_events().getHandler("showing");t&&t(this,n)},add_hidden:function(n){this.get_events().addHandler("hidden",n)},remove_hidden:function(n){this.get_events().removeHandler("hidden",n)},raiseHidden:function(n){var t=this.get_events().getHandler("hidden");t&&t(this,n)}};Sys.Extended.UI.ConfirmButtonBehavior.registerClass("Sys.Extended.UI.ConfirmButtonBehavior",Sys.Extended.UI.BehaviorBase);Sys.registerComponent(Sys.Extended.UI.ConfirmButtonBehavior,{name:"confirmButton",parameters:[{name:"ConfirmText",type:"String"}]});Sys.Extended.UI.ConfirmButtonBehavior.WebForm_OnSubmit=function(){var n=Sys.Extended.UI.ConfirmButtonBehavior._originalWebForm_OnSubmit();return n&&Sys.Extended.UI.ConfirmButtonBehavior._clickedBehavior&&(n=Sys.Extended.UI.ConfirmButtonBehavior._clickedBehavior._displayConfirmDialog()),Sys.Extended.UI.ConfirmButtonBehavior._clickedBehavior=null,n}}window.Sys&&Sys.loader?Sys.loader.registerScript("ExtendedConfirmButton",["ExtendedBase"],n):n()})();