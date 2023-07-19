﻿// (c) 2010 CodePlex Foundation
window.SIGNAL||(window.SIGNAL="----seadragon----");Type.registerNamespace("Sys.Extended.UI.Seadragon");Type.registerNamespace("Seadragon");Sys.Extended.UI.Seadragon.ControlAnchor=function(){throw Error.invalidOperation();};Sys.Extended.UI.Seadragon.ControlAnchor.prototype={NONE:0,TOP_LEFT:1,TOP_RIGHT:2,BOTTOM_RIGHT:3,BOTTOM_LEFT:4};Sys.Extended.UI.Seadragon.ControlAnchor.registerEnum("Sys.Extended.UI.Seadragon.ControlAnchor",!1);Seadragon.ControlAnchor=Sys.Extended.UI.Seadragon.ControlAnchor;Sys.Extended.UI.Seadragon.OverlayPlacement=function(){throw Error.invalidOperation();};Sys.Extended.UI.Seadragon.OverlayPlacement.prototype={CENTER:0,TOP_LEFT:1,TOP:2,TOP_RIGHT:3,RIGHT:4,BOTTOM_RIGHT:5,BOTTOM:6,BOTTOM_LEFT:7,LEFT:8};Sys.Extended.UI.Seadragon.OverlayPlacement.registerEnum("Sys.Extended.UI.Seadragon.OverlayPlacement",!1);Seadragon.OverlayPlacement=Sys.Extended.UI.Seadragon.OverlayPlacement;Sys.Extended.UI.Seadragon.NavControl=function(n){this._group=null;this._zooming=!1;this._zoomFactor=null;this._lastZoomTime=null;this._viewer=n;this.config=this._viewer.config;this.elmt=null;this.initialize()};Sys.Extended.UI.Seadragon.NavControl.prototype={initialize:function(){var i=Function.createDelegate(this,this._beginZoomingIn),t=Function.createDelegate(this,this._endZooming),u=Function.createDelegate(this,this._doSingleZoomIn),r=Function.createDelegate(this,this._beginZoomingOut),f=Function.createDelegate(this,this._doSingleZoomOut),e=Function.createDelegate(this,this._onHome),o=Function.createDelegate(this,this._onFullPage),n=this._viewer.config.navImages,s=$create(Sys.Extended.UI.Seadragon.Button,{config:this._viewer.config,tooltip:Seadragon.Strings.getString("Tooltips.ZoomIn"),srcRest:this._resolveUrl(n.zoomIn.REST),srcGroup:this._resolveUrl(n.zoomIn.GROUP),srcHover:this._resolveUrl(n.zoomIn.HOVER),srcDown:this._resolveUrl(n.zoomIn.DOWN)},{onPress:i,onRelease:t,onClick:u,onEnter:i,onExit:t},null,null),h=$create(Sys.Extended.UI.Seadragon.Button,{config:this._viewer.config,tooltip:Seadragon.Strings.getString("Tooltips.ZoomOut"),srcRest:this._resolveUrl(n.zoomOut.REST),srcGroup:this._resolveUrl(n.zoomOut.GROUP),srcHover:this._resolveUrl(n.zoomOut.HOVER),srcDown:this._resolveUrl(n.zoomOut.DOWN)},{onPress:r,onRelease:t,onClick:f,onEnter:r,onExit:t},null,null),c=$create(Sys.Extended.UI.Seadragon.Button,{config:this._viewer.config,tooltip:Seadragon.Strings.getString("Tooltips.Home"),srcRest:this._resolveUrl(n.home.REST),srcGroup:this._resolveUrl(n.home.GROUP),srcHover:this._resolveUrl(n.home.HOVER),srcDown:this._resolveUrl(n.home.DOWN)},{onRelease:e},null,null),l=$create(Sys.Extended.UI.Seadragon.Button,{config:this._viewer.config,tooltip:Seadragon.Strings.getString("Tooltips.FullPage"),srcRest:this._resolveUrl(n.fullpage.REST),srcGroup:this._resolveUrl(n.fullpage.GROUP),srcHover:this._resolveUrl(n.fullpage.HOVER),srcDown:this._resolveUrl(n.fullpage.DOWN)},{onRelease:o},null,null);this._group=$create(Sys.Extended.UI.Seadragon.ButtonGroup,{config:this._viewer.config,buttons:[s,h,c,l]},null,null,null);this.elmt=this._group.get_element();this.elmt[SIGNAL]=!0;this._viewer.add_open(Function.createDelegate(this,this._lightUp))},dispose:function(){},_resolveUrl:function(n){return String.format("{1}",this._viewer.get_prefixUrl(),n)},_beginZoomingIn:function(){this._lastZoomTime=(new Date).getTime();this._zoomFactor=this.config.zoomPerSecond;this._zooming=!0;this._scheduleZoom()},_beginZoomingOut:function(){this._lastZoomTime=(new Date).getTime();this._zoomFactor=1/this.config.zoomPerSecond;this._zooming=!0;this._scheduleZoom()},_endZooming:function(){this._zooming=!1},_scheduleZoom:function(){window.setTimeout(Function.createDelegate(this,this._doZoom),10)},_doZoom:function(){if(this._zooming&&this._viewer.viewport){var n=(new Date).getTime(),t=n-this._lastZoomTime,i=Math.pow(this._zoomFactor,t/1e3);this._viewer.viewport.zoomBy(i);this._viewer.viewport.applyConstraints();this._lastZoomTime=n;this._scheduleZoom()}},_doSingleZoomIn:function(){this._viewer.viewport&&(this._zooming=!1,this._viewer.viewport.zoomBy(this.config.zoomPerClick/1),this._viewer.viewport.applyConstraints())},_doSingleZoomOut:function(){this._viewer.viewport&&(this._zooming=!1,this._viewer.viewport.zoomBy(1/this.config.zoomPerClick),this._viewer.viewport.applyConstraints())},_lightUp:function(){this._group.emulateEnter();this._group.emulateExit()},_onHome:function(){this._viewer.viewport&&this._viewer.viewport.goHome()},_onFullPage:function(){this._viewer.setFullPage(!this._viewer.isFullPage());this._group.emulateExit();this._viewer.viewport&&this._viewer.viewport.applyConstraints()}};Sys.Extended.UI.Seadragon.NavControl.registerClass("Sys.Extended.UI.Seadragon.NavControl",null,Sys.IDisposable);Sys.Extended.UI.Seadragon.Control=function(n,t,i){this.elmt=n;this.anchor=t;this.container=i;this.wrapper=Seadragon.Utils.makeNeutralElement("span");this.initialize()};Sys.Extended.UI.Seadragon.Control.prototype={initialize:function(){this.wrapper=Seadragon.Utils.makeNeutralElement("span");this.wrapper.style.display="inline-block";this.wrapper.appendChild(this.elmt);this.anchor==Seadragon.ControlAnchor.NONE&&(this.wrapper.style.width=this.wrapper.style.height="100%");this.addToAnchor()},addToAnchor:function(){this.anchor==Seadragon.ControlAnchor.TOP_RIGHT||this.anchor==Seadragon.ControlAnchor.BOTTOM_RIGHT?this.container.insertBefore(this.elmt,this.container.firstChild):this.container.appendChild(this.elmt)},destroy:function(){this.wrapper.removeChild(this.elmt);this.container.removeChild(this.wrapper)},isVisible:function(){return this.wrapper.style.display!="none"},setVisible:function(n){this.wrapper.style.display=n?"inline-block":"none"},setOpacity:function(n){this.elmt[SIGNAL]&&Seadragon.Utils.getBrowser()==Seadragon.Browser.IE?Seadragon.Utils.setElementOpacity(this.elmt,n,!0):Seadragon.Utils.setElementOpacity(this.wrapper,n,!0)}};Sys.Extended.UI.Seadragon.Control.registerClass("Sys.Extended.UI.Seadragon.Control",null,Sys.IDisposable);Sys.Extended.UI.Seadragon.Viewer=function(n){Sys.Extended.UI.Seadragon.Viewer.initializeBase(this,[n]);this.config=new Sys.Extended.UI.Seadragon.Config;this._prefixUrl=null;this._controls=[];this._customControls=null;this._overlays=[];this._overlayControls=null;this._container=null;this._canvas=null;this._controlsTL=null;this._controlsTR=null;this._controlsBR=null;this._controlsBL=null;this._bodyWidth=null;this._bodyHeight=null;this._bodyOverflow=null;this._docOverflow=null;this._fsBoundsDelta=null;this._prevContainerSize=null;this._lastOpenStartTime=0;this._lastOpenEndTime=0;this._animating=!1;this._forceRedraw=!1;this._mouseInside=!1;this._xmlPath=null;this.source=null;this.drawer=null;this.viewport=null;this.profiler=null};Sys.Extended.UI.Seadragon.Viewer.prototype={initialize:function(){var i,r,u;Sys.Extended.UI.Seadragon.Viewer.callBaseMethod(this,"initialize");this._container=Seadragon.Utils.makeNeutralElement("div");this._canvas=Seadragon.Utils.makeNeutralElement("div");this._controlsTL=Seadragon.Utils.makeNeutralElement("div");this._controlsTR=Seadragon.Utils.makeNeutralElement("div");this._controlsBR=Seadragon.Utils.makeNeutralElement("div");this._controlsBL=Seadragon.Utils.makeNeutralElement("div");i=new Seadragon.MouseTracker(this._canvas,this.config.clickTimeThreshold,this.config.clickDistThreshold);r=new Seadragon.MouseTracker(this._container,this.config.clickTimeThreshold,this.config.clickDistThreshold);this._bodyWidth=document.body.style.width;this._bodyHeight=document.body.style.height;this._bodyOverflow=document.body.style.overflow;this._docOverflow=document.documentElement.style.overflow;this._fsBoundsDelta=new Sys.Extended.UI.Seadragon.Point(1,1);var n=this._canvas.style,t=this._container.style,f=this._controlsTL.style,e=this._controlsTR.style,o=this._controlsBR.style,s=this._controlsBL.style;for(t.width="100%",t.height="100%",t.position="relative",t.left="0px",t.top="0px",t.textAlign="left",n.width="100%",n.height="100%",n.overflow="hidden",n.position="absolute",n.top="0px",n.left="0px",f.position=e.position=o.position=s.position="absolute",f.top=e.top="0px",f.left=s.left="0px",e.right=o.right="0px",s.bottom=o.bottom="0px",i.clickHandler=Function.createDelegate(this,this._onCanvasClick),i.dragHandler=Function.createDelegate(this,this._onCanvasDrag),i.releaseHandler=Function.createDelegate(this,this._onCanvasRelease),i.setTracking(!0),this.get_showNavigationControl()&&(navControl=new Sys.Extended.UI.Seadragon.NavControl(this).elmt,navControl.style.marginRight="4px",navControl.style.marginBottom="4px",this.addControl(navControl,Sys.Extended.UI.Seadragon.ControlAnchor.BOTTOM_RIGHT)),u=0;u<this._customControls.length;u++)this.addControl(this._customControls[u].id,this._customControls[u].anchor);r.enterHandler=Function.createDelegate(this,this._onContainerEnter);r.exitHandler=Function.createDelegate(this,this._onContainerExit);r.releaseHandler=Function.createDelegate(this,this._onContainerRelease);r.setTracking(!0);window.setTimeout(Function.createDelegate(this,this._beginControlsAutoHide),1);this._container.appendChild(this._canvas);this._container.appendChild(this._controlsTL);this._container.appendChild(this._controlsTR);this._container.appendChild(this._controlsBR);this._container.appendChild(this._controlsBL);this.get_element().appendChild(this._container);this._xmlPath&&this.openDzi(this._xmlPath)},_raiseEvent:function(n,t){var i=this.get_events().getHandler(n);i&&(t||(t=Sys.EventArgs.Empty),i(this,t))},_beginControlsAutoHide:function(){this.config.autoHideControls&&(this._controlsShouldFade=!0,this._controlsFadeBeginTime=(new Date).getTime()+this._controlsFadeDelay,window.setTimeout(Function.createDelegate(this,this._scheduleControlsFade),this._controlsFadeDelay))},_scheduleControlsFade:function(){window.setTimeout(Function.createDelegate(this,this._updateControlsFade),20)},_updateControlsFade:function(){var t;if(this._controlsShouldFade){var i=(new Date).getTime(),r=i-this._controlsFadeBeginTime,n=1-r/this._controlsFadeLength;for(n=Math.min(1,n),n=Math.max(0,n),t=this._controls.length-1;t>=0;t--)this._controls[t].setOpacity(n);n>0&&this._scheduleControlsFade()}},_onCanvasClick:function(n,t,i,r){if(this.viewport&&i){var u=this.config.zoomPerClick,f=r?1/u:u;this.viewport.zoomBy(f,this.viewport.pointFromPixel(t,!0));this.viewport.applyConstraints()}},_onCanvasDrag:function(n,t,i){this.viewport&&this.viewport.panBy(this.viewport.deltaPointsFromPixels(i.negate()))},_onCanvasRelease:function(n,t,i){i&&this.viewport&&this.viewport.applyConstraints()},_onContainerExit:function(n,t,i){i||(this._mouseInside=!1,this._animating||this._beginControlsAutoHide())},_onContainerRelease:function(n,t,i,r){r||(this._mouseInside=!1,this._animating||this._beginControlsAutoHide())},_getControlIndex:function(n){for(var t=this._controls.length-1;t>=0;t--)if(this._controls[t].elmt==n)return t;return-1},_abortControlsAutoHide:function(){this._controlsShouldFade=!1;for(var n=this._controls.length-1;n>=0;n--)this._controls[n].setOpacity(1)},_onContainerEnter:function(){this._mouseInside=!0;this._abortControlsAutoHide()},_updateOnce:function(){var t,n;this.source&&(this.profiler.beginUpdate(),t=Seadragon.Utils.getElementSize(this._container),t.equals(this._prevContainerSize)||(this.viewport.resize(t,!0),this._prevContainerSize=t,this._raiseEvent("resize",this)),n=this.viewport.update(),!this._animating&&n&&(this._raiseEvent("animationstart",self),this._abortControlsAutoHide()),n?(this.drawer.update(),this._raiseEvent("animation",self)):this._forceRedraw||this.drawer.needsUpdate()?(this.drawer.update(),this._forceRedraw=!1):this.drawer.idle(),this._animating&&!n&&(this._raiseEvent("animationfinish",this),this._mouseInside||this._beginControlsAutoHide()),this._animating=n,this.profiler.endUpdate())},_onClose:function(){this.source=null;this.viewport=null;this.drawer=null;this.profiler=null;this._canvas.innerHTML=""},_beforeOpen:function(){return this.source&&this._onClose(),this._lastOpenStartTime=(new Date).getTime(),window.setTimeout(Function.createDelegate(this,function(){this._lastOpenStartTime>this._lastOpenEndTime&&this._setMessage(Seadragon.Strings.getString("Messages.Loading"))}),2e3),this._lastOpenStartTime},_setMessage:function(n){var i=document.createTextNode(n),t;this._canvas.innerHTML="";this._canvas.appendChild(Seadragon.Utils.makeCenteredNode(i));t=i.parentNode.style;t.color="white";t.fontFamily="verdana";t.fontSize="13px";t.fontSizeAdjust="none";t.fontStyle="normal";t.fontStretch="normal";t.fontVariant="normal";t.fontWeight="normal";t.lineHeight="1em";t.textAlign="center";t.textDecoration="none"},_onOpen:function(n,t,i){var u,r;if(this._lastOpenEndTime=(new Date).getTime(),n<this._lastOpenStartTime){Seadragon.Debug.log("Ignoring out-of-date open.");this._raiseEvent("ignore");return}if(!t){this._setMessage(i);this._raiseEvent("error");return}for(this._canvas.innerHTML="",this._prevContainerSize=Seadragon.Utils.getElementSize(this._container),this.source=t,this.viewport=new Sys.Extended.UI.Seadragon.Viewport(this._prevContainerSize,this.source.dimensions,this.config),this.drawer=new Sys.Extended.UI.Seadragon.Drawer(this.source,this.viewport,this._canvas),this.profiler=new Sys.Extended.UI.Seadragon.Profiler,this._animating=!1,this._forceRedraw=!0,this._scheduleUpdate(this._updateMulti),u=0;u<this._overlayControls.length;u++)r=this._overlayControls[u],r.point!=null?this.drawer.addOverlay(r.id,new Sys.Extended.UI.Seadragon.Point(r.point.X,r.point.Y),Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT):this.drawer.addOverlay(r.id,new Sys.Extended.UI.Seadragon.Rect(r.rect.Point.X,r.rect.Point.Y,r.rect.Width,r.rect.Height),r.placement);this._raiseEvent("open")},_scheduleUpdate:function(n,t){if(this._animating)return window.setTimeout(Function.createDelegate(this,n),1);var i=(new Date).getTime(),t=t?t:i,r=t+1e3/60,u=Math.max(1,r-i);return window.setTimeout(Function.createDelegate(this,n),u)},_updateMulti:function(){if(this.source){var n=(new Date).getTime();this._updateOnce();this._scheduleUpdate(arguments.callee,n)}},_updateOnce:function(){var t,n;this.source&&(this.profiler.beginUpdate(),t=Seadragon.Utils.getElementSize(this._container),t.equals(this._prevContainerSize)||(this.viewport.resize(t,!0),this._prevContainerSize=t,this._raiseEvent("resize")),n=this.viewport.update(),!this._animating&&n&&(this._raiseEvent("animationstart"),this._abortControlsAutoHide()),n?(this.drawer.update(),this._raiseEvent("animation")):this._forceRedraw||this.drawer.needsUpdate()?(this.drawer.update(),this._forceRedraw=!1):this.drawer.idle(),this._animating&&!n&&(this._raiseEvent("animationfinish"),this._mouseInside||this._beginControlsAutoHide()),this._animating=n,this.profiler.endUpdate())},getNavControl:function(){return this._navControl},get_xmlPath:function(){return this._xmlPath},set_xmlPath:function(n){this._xmlPath=n},get_debugMode:function(){return this.config.debugMode},set_debugMode:function(n){this.config.debugMode=n},get_animationTime:function(){return this.config.animationTime},set_animationTime:function(n){this.config.animationTime=n},get_blendTime:function(){return this.config.blendTime},set_blendTime:function(n){this.config.blendTime=n},get_alwaysBlend:function(){return this.config.alwaysBlend},set_alwaysBlend:function(n){this.config.alwaysBlend=n},get_autoHideControls:function(){return this.config.autoHideControls},set_autoHideControls:function(n){this.config.autoHideControls=n},get_immediateRender:function(){return this.config.immediateRender},set_immediateRender:function(n){this.config.immediateRender=n},get_wrapHorizontal:function(){return this.config.wrapHorizontal},set_wrapHorizontal:function(n){this.config.wrapHorizontal=n},get_wrapVertical:function(){return this.config.wrapVertical},set_wrapVertical:function(n){this.config.wrapVertical=n},get_minZoomDimension:function(){return this.config.minZoomDimension},set_minZoomDimension:function(n){this.config.minZoomDimension=n},get_maxZoomPixelRatio:function(){return this.config.maxZoomPixelRatio},set_maxZoomPixelRatio:function(n){this.config.maxZoomPixelRatio=n},get_visibilityRatio:function(){return this.config.visibilityRatio},set_visibilityRatio:function(n){this.config.visibilityRatio=n},get_springStiffness:function(){return this.config.springStiffness},set_springStiffness:function(n){this.config.springStiffness=n},get_imageLoaderLimit:function(){return this.config.imageLoaderLimit},set_imageLoaderLimit:function(n){this.config.imageLoaderLimit=n},get_clickTimeThreshold:function(){return this.config.clickTimeThreshold},set_clickTimeThreshold:function(n){this.config.clickTimeThreshold=n},get_clickDistThreshold:function(){return this.config.clickDistThreshold},set_clickDistThreshold:function(n){this.config.clickDistThreshold=n},get_zoomPerClick:function(){return this.config.zoomPerClick},set_zoomPerClick:function(n){this.config.zoomPerClick=n},get_zoomPerSecond:function(){return this.config.zoomPerSecond},set_zoomPerSecond:function(n){this.config.zoomPerSecond=n},get_maxImageCacheCount:function(){return this.config.maxImageCacheCount},set_maxImageCacheCount:function(n){this.config.maxImageCacheCount=n},get_showNavigationControl:function(){return this.config.showNavigationControl},set_showNavigationControl:function(n){this.config.showNavigationControl=n},get_minPixelRatio:function(){return this.config.minPixelRatio},set_minPixelRatio:function(n){this.config.minPixelRatio=n},get_mouseNavEnabled:function(){return this.config.mouseNavEnabled},set_mouseNavEnabled:function(n){this.config.mouseNavEnabled=n},get_controls:function(){return this._customControls},set_controls:function(n){this._customControls=n},get_overlays:function(){return this._overlayControls},set_overlays:function(n){this._overlayControls=n},get_prefixUrl:function(){return this._prefixUrl},set_prefixUrl:function(n){this._prefixUrl=n},add_open:function(n){this.get_events().addHandler("open",n)},remove_open:function(n){this.get_events().removeHandler("open",n)},add_error:function(n){this.get_events().addHandler("error",n)},remove_error:function(n){this.get_events().removeHandler("error",n)},add_ignore:function(n){this.get_events().addHandler("ignore",n)},remove_ignore:function(n){this.get_events().removeHandler("ignore",n)},add_resize:function(n){this.get_events().addHandler("resize",n)},remove_resize:function(n){this.get_events().removeHandler("resize",n)},add_animationstart:function(n){this.get_events().addHandler("animationstart",n)},remove_animationstart:function(n){this.get_events().removeHandler("animationstart",n)},add_animationend:function(n){this.get_events().addHandler("animationend",n)},remove_animationend:function(n){this.get_events().removeHandler("animationend",n)},addControl:function(n,t){var n=Seadragon.Utils.getElement(n),i;if(!(this._getControlIndex(n)>=0)){i=null;switch(t){case Sys.Extended.UI.Seadragon.ControlAnchor.TOP_RIGHT:i=this._controlsTR;n.style.position="relative";break;case Sys.Extended.UI.Seadragon.ControlAnchor.BOTTOM_RIGHT:i=this._controlsBR;n.style.position="relative";break;case Sys.Extended.UI.Seadragon.ControlAnchor.BOTTOM_LEFT:i=this._controlsBL;n.style.position="relative";break;case Sys.Extended.UI.Seadragon.ControlAnchor.TOP_LEFT:i=this._controlsTL;n.style.position="relative";break;case Sys.Extended.UI.Seadragon.ControlAnchor.NONE:default:i=this._container;n.style.position="absolute"}this._controls.push(new Sys.Extended.UI.Seadragon.Control(n,t,i))}},isOpen:function(){return!!this.source},openDzi:function(n,t){var i=this._beforeOpen();Sys.Extended.UI.Seadragon.DziTileSourceHelper.createFromXml(n,t,Seadragon.Utils.createCallback(null,Function.createDelegate(this,this._onOpen),i))},openTileSource:function(n){var t=this._beforeOpen();window.setTimeout(Function.createDelegate(this,function(){this._onOpen(t,n)}),1)},close:function(){this.source&&this._onClose()},removeControl:function(n){var n=Seadragon.Utils.getElement(n),t=this._getControlIndex(n);t>=0&&(this._controls[t].destroy(),this._controls.splice(t,1))},clearControls:function(){while(this._controls.length>0)this._controls.pop().destroy()},isDashboardEnabled:function(){for(var n=this._controls.length-1;n>=0;n--)if(this._controls[n].isVisible())return!0;return!1},isFullPage:function(){return this._container.parentNode==document.body},isMouseNavEnabled:function(){return this._innerTracker.isTracking()},isVisible:function(){return this._container.style.visibility!="hidden"},setDashboardEnabled:function(n){for(var t=this._controls.length-1;t>=0;t--)this._controls[t].setVisible(n)},setFullPage:function(n){var f,e;if(n!=this.isFullPage()){var o=document.body,t=o.style,u=document.documentElement.style,i=this._container.style,r=this._canvas.style;n?(bodyOverflow=t.overflow,docOverflow=u.overflow,t.overflow="hidden",u.overflow="hidden",bodyWidth=t.width,bodyHeight=t.height,t.width="100%",t.height="100%",r.backgroundColor="black",r.color="white",i.position="fixed",i.zIndex="99999999",o.appendChild(this._container),this._prevContainerSize=Seadragon.Utils.getWindowSize(),this._onContainerEnter()):(t.overflow=bodyOverflow,u.overflow=docOverflow,t.width=bodyWidth,t.height=bodyHeight,r.backgroundColor="",r.color="",i.position="relative",i.zIndex="",this.get_element().appendChild(this._container),this._prevContainerSize=Seadragon.Utils.getElementSize(this.get_element()),this._onContainerExit());this.viewport&&(f=this.viewport.getBounds(),this.viewport.resize(this._prevContainerSize),e=this.viewport.getBounds(),n?this._fsBoundsDelta=new Sys.Extended.UI.Seadragon.Point(e.width/f.width,e.height/f.height):(this.viewport.update(),this.viewport.zoomBy(Math.max(this._fsBoundsDelta.x,this._fsBoundsDelta.y),null,!0)),this._forceRedraw=!0,this._raiseEvent("resize",this),this._updateOnce())}},setMouseNavEnabled:function(n){this._innerTracker.setTracking(n)},setVisible:function(n){this._container.style.visibility=n?"":"hidden"}};Sys.Extended.UI.Seadragon.Viewer.registerClass("Sys.Extended.UI.Seadragon.Viewer",Sys.UI.Control);