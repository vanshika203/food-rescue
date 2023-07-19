﻿// (c) 2010 CodePlex Foundation
Type.registerNamespace("Sys.Extended.UI.Seadragon");Sys.Extended.UI.Seadragon.DziError=function(n){Sys.Extended.UI.Seadragon.DziError.initializeBase(this,[n]);this.message=n};Sys.Extended.UI.Seadragon.DziError.registerClass("Sys.Extended.UI.Seadragon.DziError",Error);Sys.Extended.UI.Seadragon.DziTileSource=function(n,t,i,r,u,f,e){Sys.Extended.UI.Seadragon.DziTileSource.initializeBase(this,[n,t,i,r,null,null]);this._levelRects={};this.tilesUrl=u;this.fileFormat=f;this.displayRects=e;this._init()};Sys.Extended.UI.Seadragon.DziTileSource.prototype={_init:function(){var t,i,n;if(this.displayRects)for(t=this.displayRects.length-1;t>=0;t--)for(i=this.displayRects[t],n=i.minLevel;n<=i.maxLevel;n++)this._levelRects[n]||(this._levelRects[n]=[]),this._levelRects[n].push(i)},getTileUrl:function(n,t,i){return[this.tilesUrl,n,"/",t,"_",i,".",this.fileFormat].join("")},tileExists:function(n,t,i){var u=this._levelRects[n],f,r;if(!u||!u.length)return!0;for(f=u.length-1;f>=0;f--)if(r=u[f],!(n<r.minLevel)&&!(n>r.maxLevel)){var e=this.getLevelScale(n),o=r.x*e,s=r.y*e,h=o+r.width*e,c=s+r.height*e;if(o=Math.floor(o/this.tileSize),s=Math.floor(s/this.tileSize),h=Math.ceil(h/this.tileSize),c=Math.ceil(c/this.tileSize),o<=t&&t<h&&s<=i&&i<c)return!0}return!1}};Sys.Extended.UI.Seadragon.DziTileSource.registerClass("Sys.Extended.UI.Seadragon.DziTileSource",Sys.Extended.UI.Seadragon.TileSource);Sys.Extended.UI.Seadragon._DziTileSourceHelper=function(){};Sys.Extended.UI.Seadragon._DziTileSourceHelper.prototype={createFromXml:function(n,t,i){function e(n,t){try{return n(t,c)}catch(i){if(o)return r=this.getError(i).message,null;throw this.getError(i);}}var o=typeof i=="function",r=null,c,f;if(!n){if(this.error=Seadragon.Strings.getString("Errors.Empty"),o)return window.setTimeout(function(){i(null,r)},1),null;throw new Sys.Extended.UI.Seadragon.DziError(r);}var u=n.split("/"),s=u[u.length-1],h=s.lastIndexOf(".");return(h>-1&&(u[u.length-1]=s.slice(0,h)),c=u.join("/")+"_files/",o)?(t?(f=Function.createDelegate(this,this.processResponse),window.setTimeout(function(){var n=e(f,Seadragon.Utils.parseXml(t));i(n,r)},1)):(f=Function.createDelegate(this,this.processResponse),Seadragon.Utils.makeAjaxRequest(n,function(n){var t=e(f,n);i(t,r)})),null):t?e(Function.createDelegate(this,this.processXml),Seadragon.Utils.parseXml(t)):e(Function.createDelegate(this,this.processResponse),Seadragon.Utils.makeAjaxRequest(n))},processResponse:function(n,t){var r,u,i;if(n){if(n.status!==200&&n.status!==0){r=n.status;u=r==404?"Not Found":n.statusText;throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Status",r,u));}}else throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Security"));return i=null,n.responseXML&&n.responseXML.documentElement?i=n.responseXML:n.responseText&&(i=Seadragon.Utils.parseXml(n.responseText)),this.processXml(i,t)},processXml:function(n,t){var i,r,f;if(!n||!n.documentElement)throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Xml"));if(i=n.documentElement,r=i.tagName,r=="Image")try{return this.processDzi(i,t)}catch(u){f=Seadragon.Strings.getString("Errors.Dzi");throw u instanceof Sys.Extended.UI.Seadragon.DziError?u:new Sys.Extended.UI.Seadragon.DziError(f);}else if(r=="Collection")throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Dzc"));else if(r=="Error")return this.processError(i);throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Dzi"));},processDzi:function(n,t){var u=n.getAttribute("Format"),r,f,i;if(!Seadragon.Utils.imageFormatSupported(u))throw new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.ImageFormat",u.toUpperCase()));var e=n.getElementsByTagName("Size")[0],o=n.getElementsByTagName("DisplayRect"),h=parseInt(e.getAttribute("Width"),10),c=parseInt(e.getAttribute("Height"),10),l=parseInt(n.getAttribute("TileSize")),a=parseInt(n.getAttribute("Overlap")),s=[];for(r=0;r<o.length;r++)f=o[r],i=f.getElementsByTagName("Rect")[0],s.push(new Seadragon.DisplayRect(parseInt(i.getAttribute("X"),10),parseInt(i.getAttribute("Y"),10),parseInt(i.getAttribute("Width"),10),parseInt(i.getAttribute("Height"),10),0,parseInt(f.getAttribute("MaxLevel"),10)));return new Sys.Extended.UI.Seadragon.DziTileSource(h,c,l,a,t,u,s)},processError:function(n){var t=n.getElementsByTagName("Message")[0],i=t.firstChild.nodeValue;throw new Sys.Extended.UI.Seadragon.DziError(i);},getError:function(n){n instanceof DziError||(Seadragon.Debug.error(n.name+" while creating DZI from XML: "+n.message),n=new Sys.Extended.UI.Seadragon.DziError(Seadragon.Strings.getString("Errors.Unknown")))}};Sys.Extended.UI.Seadragon.DziTileSourceHelper=new Sys.Extended.UI.Seadragon._DziTileSourceHelper;