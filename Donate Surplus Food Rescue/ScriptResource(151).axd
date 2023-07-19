﻿// (c) 2010 CodePlex Foundation
Type.registerNamespace("Sys.Extended.UI.Seadragon");Type.registerNamespace("Seadragon");var QUOTA=100,MIN_PIXEL_RATIO=.5,browser=Seadragon.Utils.getBrowser(),browserVer=Seadragon.Utils.getBrowserVersion(),subpixelRenders=browser==Seadragon.Browser.FIREFOX||browser==Seadragon.Browser.OPERA||browser==Seadragon.Browser.SAFARI&&browserVer>=4||browser==Seadragon.Browser.CHROME&&browserVer>=2,useCanvas=typeof document.createElement("canvas").getContext=="function"&&subpixelRenders;Sys.Extended.UI.Seadragon.Tile=function(n,t,i,r,u,f){this.level=n;this.x=t;this.y=i;this.bounds=r;this.exists=u;this.loaded=!1;this.loading=!1;this.elmt=null;this.image=null;this.url=f;this.style=null;this.position=null;this.size=null;this.blendStart=null;this.opacity=null;this.distance=null;this.visibility=null;this.beingDrawn=!1;this.lastTouchTime=0};Sys.Extended.UI.Seadragon.Tile.prototype={dispose:function(){},toString:function(){return this.level+"/"+this.x+"_"+this.y},drawHTML:function(n){if(!this.loaded){Seadragon.Debug.error("Attempting to draw tile "+this.toString()+" when it's not yet loaded.");return}this.elmt||(this.elmt=Seadragon.Utils.makeNeutralElement("img"),this.elmt.src=this.url,this.style=this.elmt.style,this.style.position="absolute",this.style.msInterpolationMode="nearest-neighbor");var i=this.elmt,t=this.style,r=this.position.apply(Math.floor),u=this.size.apply(Math.ceil);i.parentNode!=n&&n.appendChild(i);t.left=r.x+"px";t.top=r.y+"px";t.width=u.x+"px";t.height=u.y+"px";Seadragon.Utils.setElementOpacity(i,this.opacity)},drawCanvas:function(n){if(!this.loaded){Seadragon.Debug.error("Attempting to draw tile "+this.toString()+" when it's not yet loaded.");return}var t=this.position,i=this.size;n.globalAlpha=this.opacity;n.drawImage(this.image,t.x,t.y,i.x,i.y)},unload:function(){this.elmt&&this.elmt.parentNode&&this.elmt.parentNode.removeChild(this.elmt);this.elmt=null;this.image=null;this.loaded=!1;this.loading=!1}};Sys.Extended.UI.Seadragon.Tile.registerClass("Sys.Extended.UI.Seadragon.Tile",null,Sys.IDisposable);Sys.Extended.UI.Seadragon.Overlay=function(n,t,i){this.elmt=n;this.scales=t instanceof Sys.Extended.UI.Seadragon.Rect;this.bounds=new Sys.Extended.UI.Seadragon.Rect(t.x,t.y,t.width,t.height);this.placement=t instanceof Sys.Extended.UI.Seadragon.Point?i:Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT;this.position=new Sys.Extended.UI.Seadragon.Point(t.x,t.y);this.size=new Sys.Extended.UI.Seadragon.Point(t.width,t.height);this.style=n.style};Sys.Extended.UI.Seadragon.Overlay.prototype={adjust:function(n,t){switch(this.placement){case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT:break;case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP:n.x-=t.x/2;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_RIGHT:n.x-=t.x;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.RIGHT:n.x-=t.x;n.y-=t.y/2;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM_RIGHT:n.x-=t.x;n.y-=t.y;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM:n.x-=t.x/2;n.y-=t.y;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.BOTTOM_LEFT:n.y-=t.y;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.LEFT:n.y-=t.y/2;break;case Sys.Extended.UI.Seadragon.OverlayPlacement.CENTER:default:n.x-=t.x/2;n.y-=t.y/2}},destroy:function(){var t=this.elmt,n=this.style;t.parentNode&&t.parentNode.removeChild(t);n.top="";n.left="";n.position="";this.scales&&(n.width="",n.height="")},drawHTML:function(n){var u=this.elmt,r=this.style,f=this.scales,t,i;u.parentNode!=n&&n.appendChild(u);f||(this.size=Seadragon.Utils.getElementSize(u));t=this.position;i=this.size;this.adjust(t,i);t=t.apply(Math.floor);i=i.apply(Math.ceil);r.left=t.x+"px";r.top=t.y+"px";r.position="absolute";f&&(r.width=i.x+"px",r.height=i.y+"px")},update:function(n,t){this.scales=n instanceof Sys.Extended.UI.Seadragon.Rect;this.bounds=new Sys.Extended.UI.Seadragon.Rect(n.x,n.y,n.width,n.height);this.placement=n instanceof Sys.Extended.UI.Seadragon.Point?t:Sys.Extended.UI.Seadragon.OverlayPlacement.TOP_LEFT}};Sys.Extended.UI.Seadragon.Overlay.registerClass("Sys.Extended.UI.Seadragon.Overlay",null,Sys.IDisposable);Sys.Extended.UI.Seadragon.Drawer=function(n,t,i){this._container=Seadragon.Utils.getElement(i);this._canvas=Seadragon.Utils.makeNeutralElement(useCanvas?"canvas":"div");this._context=useCanvas?this._canvas.getContext("2d"):null;this._viewport=t;this._source=n;this.config=this._viewport.config;this._imageLoader=new Sys.Extended.UI.Seadragon.ImageLoader(this.config.imageLoaderLimit);this._profiler=new Sys.Extended.UI.Seadragon.Profiler;this._minLevel=n.minLevel;this._maxLevel=n.maxLevel;this._tileSize=n.tileSize;this._tileOverlap=n.tileOverlap;this._normHeight=n.dimensions.y/n.dimensions.x;this._cacheNumTiles={};this._cachePixelRatios={};this._tilesMatrix={};this._tilesLoaded=[];this._coverage={};this._overlays=[];this._lastDrawn=[];this._lastResetTime=0;this._midUpdate=!1;this._updateAgain=!0;this.elmt=this._container;this._init()};Sys.Extended.UI.Seadragon.Drawer.prototype={dispose:function(){},_init:function(){this._canvas.style.width="100%";this._canvas.style.height="100%";this._canvas.style.position="absolute";this._container.style.textAlign="left";this._container.appendChild(this._canvas)},_compareTiles:function(n,t){return n?t.visibility>n.visibility?t:t.visibility==n.visibility&&t.distance<n.distance?t:n:t},_getNumTiles:function(n){return this._cacheNumTiles[n]||(this._cacheNumTiles[n]=this._source.getNumTiles(n)),this._cacheNumTiles[n]},_getPixelRatio:function(n){return this._cachePixelRatios[n]||(this._cachePixelRatios[n]=this._source.getPixelRatio(n)),this._cachePixelRatios[n]},_getTile:function(n,t,i,r,u,f){var h;if(this._tilesMatrix[n]||(this._tilesMatrix[n]={}),this._tilesMatrix[n][t]||(this._tilesMatrix[n][t]={}),!this._tilesMatrix[n][t][i]){var e=(u+t%u)%u,o=(f+i%f)%f,s=this._source.getTileBounds(n,e,o),c=this._source.tileExists(n,e,o),l=this._source.getTileUrl(n,e,o);s.x+=1*(t-e)/u;s.y+=this._normHeight*(i-o)/f;this._tilesMatrix[n][t][i]=new Sys.Extended.UI.Seadragon.Tile(n,t,i,s,c,l)}return h=this._tilesMatrix[n][t][i],h.lastTouchTime=r,h},_loadTile:function(n,t){n.loading=this._imageLoader.loadImage(n.url,Seadragon.Utils.createCallback(null,Function.createDelegate(this,this._onTileLoad),n,t))},_onTileLoad:function(n,t,i){var o,f,u;if(n.loading=!1,this._midUpdate){Seadragon.Debug.error("Tile load callback in middle of drawing routine.");return}if(i){if(t<this._lastResetTime){Seadragon.Debug.log("Ignoring tile "+n+" loaded before reset: "+n.url);return}}else{Seadragon.Debug.log("Tile "+n+" failed to load: "+n.url);n.exists=!1;return}if(n.loaded=!0,n.image=i,o=this._tilesLoaded.length,this._tilesLoaded.length>=QUOTA){var a=Math.ceil(Math.log(this._tileSize)/Math.log(2)),r=null,e=-1;for(f=this._tilesLoaded.length-1;f>=0;f--){if(u=this._tilesLoaded[f],u.level<=this._cutoff||u.beingDrawn)continue;else if(!r){r=u;e=f;continue}var s=u.lastTouchTime,h=r.lastTouchTime,c=u.level,l=r.level;(s<h||s==h&&c>l)&&(r=u,e=f)}r&&e>=0&&(r.unload(),o=e)}this._tilesLoaded[o]=n;this._updateAgain=!0},_clearTiles:function(){this._tilesMatrix={};this._tilesLoaded=[]},_providesCoverage:function(n,t,i){var r,f,u,e;if(!this._coverage[n])return!1;if(t===undefined||i===undefined){r=this._coverage[n];for(f in r)if(r.hasOwnProperty(f)){u=r[f];for(e in u)if(u.hasOwnProperty(e)&&!u[e])return!1}return!0}return this._coverage[n][t]===undefined||this._coverage[n][t][i]===undefined||this._coverage[n][t][i]===!0},_isCovered:function(n,t,i){return t===undefined||i===undefined?this._providesCoverage(n+1):this._providesCoverage(n+1,2*t,2*i)&&this._providesCoverage(n+1,2*t,2*i+1)&&this._providesCoverage(n+1,2*t+1,2*i)&&this._providesCoverage(n+1,2*t+1,2*i+1)},_setCoverage:function(n,t,i,r){if(!this._coverage[n]){Seadragon.Debug.error("Setting coverage for a tile before its level's coverage has been reset: "+n);return}this._coverage[n][t]||(this._coverage[n][t]={});this._coverage[n][t][i]=r},_resetCoverage:function(n){this._coverage[n]={}},_compareTiles:function(n,t){return n?t.visibility>n.visibility?t:t.visibility==n.visibility&&t.distance<n.distance?t:n:t},_getOverlayIndex:function(n){for(var t=this._overlays.length-1;t>=0;t--)if(this._overlays[t].elmt==n)return t;return-1},_updateActual:function(){var t,nt,tt,u,f,b,rt,k,n,ii,i,c,ut;this._updateAgain=!1;for(var l=this._canvas,ft=this._context,ri=this._container,et=useCanvas,h=this._lastDrawn;h.length>0;)n=h.pop(),n.beingDrawn=!1;var ot=this._viewport.getContainerSize(),st=ot.x,ht=ot.y;l.innerHTML="";et&&(l.width=st,l.height=ht,ft.clearRect(0,0,st,ht));var ct=this._viewport.getBounds(!0),e=ct.getTopLeft(),o=ct.getBottomRight();if((this.config.wrapHorizontal||!(o.x<0||e.x>1))&&(this.config.wrapVertical||!(o.y<0||e.y>this._normHeight))){var ui=Math.abs,ki=Math.ceil,lt=Math.floor,a=Math.log,d=Math.max,r=Math.min,fi=this.config.alwaysBlend,at=1e3*this.config.blendTime,ei=this.config.immediateRender,g=this.config.minZoomDimension,di=this.config.minImageRatio,vt=this.config.wrapHorizontal,yt=this.config.wrapVertical;vt||(e.x=d(e.x,0),o.x=r(o.x,1));yt||(e.y=d(e.y,0),o.y=r(o.y,this._normHeight));var v=null,y=!1,p=(new Date).getTime(),oi=this._viewport.pixelFromPoint(this._viewport.getCenter()),si=this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(0),!1).x,pt=ei?1:si;g=g||64;var w=d(this._minLevel,lt(a(g)/a(2))),hi=this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(0),!0).x,wt=r(this._maxLevel,lt(a(hi/MIN_PIXEL_RATIO)/a(2)));for(w=r(w,wt),t=wt;t>=w;t--){if(nt=!1,tt=this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(t),!0).x,!y&&tt>=MIN_PIXEL_RATIO||t==w)nt=!0,y=!0;else if(!y)continue;this._resetCoverage(t);var ci=r(1,(tt-.5)/.5),li=this._viewport.deltaPixelsFromPoints(this._source.getPixelRatio(t),!1).x,ai=pt/ui(pt-li),bt=this._source.getTileAtPoint(t,e),s=this._source.getTileAtPoint(t,o),kt=this._getNumTiles(t),dt=kt.x,gt=kt.y;for(vt||(s.x=r(s.x,dt-1)),yt||(s.y=r(s.y,gt-1)),u=bt.x;u<=s.x;u++)for(f=bt.y;f<=s.y;f++)if((n=this._getTile(t,u,f,p,dt,gt),b=nt,this._setCoverage(t,u,f,!1),n.exists)&&(y&&!b&&(this._isCovered(t,u,f)?this._setCoverage(t,u,f,!0):b=!0),b)){var ni=n.bounds.getTopLeft(),ti=n.bounds.getSize(),vi=this._viewport.pixelFromPoint(ni,!0),it=this._viewport.deltaPixelsFromPoints(ti,!0);this._tileOverlap||(it=it.plus(new Sys.Extended.UI.Seadragon.Point(1,1)));var yi=this._viewport.pixelFromPoint(ni,!1),pi=this._viewport.deltaPixelsFromPoints(ti,!1),wi=yi.plus(pi.divide(2)),bi=oi.distanceTo(wi);n.position=vi;n.size=it;n.distance=bi;n.visibility=ai;n.loaded?(n.blendStart||(n.blendStart=p),rt=p-n.blendStart,k=r(1,rt/at),fi&&(k*=ci),n.opacity=k,h.push(n),k==1?this._setCoverage(t,u,f,!0):rt<at&&(updateAgain=!0)):n.Loading||(v=this._compareTiles(v,n))}if(this._providesCoverage(t))break}for(i=h.length-1;i>=0;i--)n=h[i],et?n.drawCanvas(ft):n.drawHTML(l),n.beingDrawn=!0;for(ii=this._overlays.length,i=0;i<ii;i++)c=this._overlays[i],ut=c.bounds,c.position=this._viewport.pixelFromPoint(ut.getTopLeft(),!0),c.size=this._viewport.deltaPixelsFromPoints(ut.getSize(),!0),c.drawHTML(ri);v&&(this._loadTile(v,p),this._updateAgain=!0)}},addOverlay:function(n,t,i){var n=Seadragon.Utils.getElement(n);this._getOverlayIndex(n)>=0||(this._overlays.push(new Sys.Extended.UI.Seadragon.Overlay(n,t,i)),this._updateAgain=!0)},updateOverlay:function(n,t,i){var n=Seadragon.Utils.getElement(n),r=this._getOverlayIndex(n);r>=0&&(this._overlays[r].update(t,i),this._updateAgain=!0)},removeOverlay:function(n){var n=Seadragon.Utils.getElement(n),t=this._getOverlayIndex(n);t>=0&&(this._overlays[t].destroy(),this._overlays.splice(t,1),this._updateAgain=!0)},clearOverlays:function(){while(this._overlays.length>0)this._overlays.pop().destroy(),this._updateAgain=!0},needsUpdate:function(){return this._updateAgain},numTilesLoaded:function(){return this._tilesLoaded.length},reset:function(){this._clearTiles();this._lastResetTime=(new Date).getTime();this._updateAgain=!0},update:function(){this._profiler.beginUpdate();this._midUpdate=!0;this._updateActual();this._midUpdate=!1;this._profiler.endUpdate()},idle:function(){}};Sys.Extended.UI.Seadragon.Drawer.registerClass("Sys.Extended.UI.Seadragon.Drawer",null,Sys.IDisposable);