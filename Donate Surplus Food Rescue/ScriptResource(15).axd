﻿Type.registerNamespace("Sys.Extended.UI.AjaxFileUpload");Type.registerNamespace("AjaxFileUpload");Sys.Extended.UI.AjaxFileUpload.Utils=function(){this.generateGuid=function(){for(var i,t="",n=0;n<32;n++)(n==8||n==12||n==16||n==20)&&(t=t+"-"),i=Math.floor(Math.random()*16).toString(16).toUpperCase(),t=t+i;return t};this.getFileName=function(n){var i="",r,t;if(!n)return"";if(!n.value&&n.name)i=n.name;else{if(!n.value&&typeof n!="string")throw"Invalid parameter. fullPath parameter must be a string of full path or file element.";n.value&&(n=n.value);n&&(r=n.indexOf("\\")>=0?n.lastIndexOf("\\"):n.lastIndexOf("/"),t=n.substring(r),(t.indexOf("\\")===0||t.indexOf("/")===0)&&(t=t.substring(1)),i=t)}return encodeURIComponent(i)};this.getFileType=function(n){if(!n)throw"file must defined or not null";if(!n.value&&n.name)return n.name.substring(n.name.lastIndexOf(".")+1);if(n.value&&(n=n.value),typeof n!="string")throw"can't resolve file type.";return n.substring(n.lastIndexOf(".")+1)};this.sizeToString=function(n){if(!n||n<=0)return"0 Kb";var t=Math.floor(Math.log(n)/Math.log(1024));return(n/Math.pow(1024,Math.floor(t))).toFixed(2)+" "+["bytes","kb","MB","GB","TB","PB"][t]};this.checkHtml5BrowserSupport=function(){var n=Sys.Browser;return n.name=="Microsoft Internet Explorer"&&n.version<=10?!1:window.File&&window.FileReader&&window.FileList&&window.Blob&&(new XMLHttpRequest).upload}};