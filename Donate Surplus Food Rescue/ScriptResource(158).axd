﻿// (c) 2010 CodePlex Foundation
Type.registerNamespace("Sys.Extended.UI.Seadragon");Sys.Extended.UI.Seadragon.Viewport=function(n,t,i){this.zoomPoint=null;this.config=i;this._containerSize=n;this._contentSize=t;this._contentAspect=t.x/t.y;this._contentHeight=t.y/t.x;this._centerSpringX=new Seadragon.Spring(0,this.config);this._centerSpringY=new Seadragon.Spring(0,this.config);this._zoomSpring=new Seadragon.Spring(1,this.config);this._homeBounds=new Sys.Extended.UI.Seadragon.Rect(0,0,1,this._contentHeight);this.goHome(!0);this.update()};Sys.Extended.UI.Seadragon.Viewport.prototype={_getHomeZoom:function(){var n=this._contentAspect/this.getAspectRatio();return n>=1?1:n},_getMinZoom:function(){var t=this._getHomeZoom(),n;return n=this.config.minZoomDimension?this._contentSize.x<=this._contentSize.y?this.config.minZoomDimension/this._containerSize.x:this.config.minZoomDimension/(this._containerSize.x*this._contentHeight):this.config.minZoomImageRatio*t,Math.min(n,t)},_getMaxZoom:function(){var n=this._contentSize.x*this.config.maxZoomPixelRatio/this._containerSize.x;return Math.max(n,this._getHomeZoom())},getAspectRatio:function(){return this._containerSize.x/this._containerSize.y},getContainerSize:function(){return new Sys.Extended.UI.Seadragon.Point(this._containerSize.x,this._containerSize.y)},getBounds:function(n){var i=this.getCenter(n),t=1/this.getZoom(n),r=t/this.getAspectRatio();return new Sys.Extended.UI.Seadragon.Rect(i.x-t/2,i.y-r/2,t,r)},getCenter:function(n){var t=new Sys.Extended.UI.Seadragon.Point(this._centerSpringX.getCurrent(),this._centerSpringY.getCurrent()),r=new Sys.Extended.UI.Seadragon.Point(this._centerSpringX.getTarget(),this._centerSpringY.getTarget());if(n)return t;if(!this.zoomPoint)return r;var o=this.pixelFromPoint(this.zoomPoint,!0),u=this.getZoom(),i=1/u,f=i/this.getAspectRatio(),e=new Sys.Extended.UI.Seadragon.Rect(t.x-i/2,t.y-f/2,i,f),s=this.zoomPoint.minus(e.getTopLeft()).times(this._containerSize.x/e.width),h=s.minus(o),c=h.divide(this._containerSize.x*u);return r.plus(c)},getZoom:function(n){return n?this._zoomSpring.getCurrent():this._zoomSpring.getTarget()},applyConstraints:function(n){var e=this.getZoom(),o=Math.max(Math.min(e,this._getMaxZoom()),this._getMinZoom()),i;e!=o&&this.zoomTo(o,this.zoomPoint,n);var t=this.getBounds(),s=this.config.visibilityRatio,r=s*t.width,u=s*t.height,h=t.x+t.width,c=1-t.x,l=t.y+t.height,a=this._contentHeight-t.y,f=0;this.config.wrapHorizontal||(h<r?f=r-h:c<r&&(f=c-r));i=0;this.config.wrapVertical||(l<u?i=u-l:a<u&&(i=a-u));(f||i)&&(t.x+=f,t.y+=i,this.fitBounds(t,n))},ensureVisible:function(n){this.applyConstraints(n)},fitBounds:function(n,t){var u=this.getAspectRatio(),f=n.getCenter(),i=new Sys.Extended.UI.Seadragon.Rect(n.x,n.y,n.width,n.height),o;i.getAspectRatio()>=u?(i.height=n.width/u,i.y=f.y-i.height/2):(i.width=n.height*u,i.x=f.x-i.width/2);this.panTo(this.getCenter(!0),!0);this.zoomTo(this.getZoom(!0),null,!0);var r=this.getBounds(),s=this.getZoom(),e=1/i.width;if(e==s||i.width==r.width){this.panTo(f,t);return}o=r.getTopLeft().times(this._containerSize.x/r.width).minus(i.getTopLeft().times(this._containerSize.x/i.width)).divide(this._containerSize.x/r.width-this._containerSize.x/i.width);this.zoomTo(e,o,t)},goHome:function(n){var t=this.getCenter();this.config.wrapHorizontal&&(t.x=(1+t.x%1)%1,this._centerSpringX.resetTo(t.x),this._centerSpringX.update());this.config.wrapVertical&&(t.y=(this._contentHeight+t.y%this._contentHeight)%this._contentHeight,this._centerSpringY.resetTo(t.y),this._centerSpringY.update());this.fitBounds(this._homeBounds,n)},panBy:function(n,t){var i=new Sys.Extended.UI.Seadragon.Point(this._centerSpringX.getTarget(),this._centerSpringY.getTarget());this.panTo(i.plus(n),t)},panTo:function(n,t){t?(this._centerSpringX.resetTo(n.x),this._centerSpringY.resetTo(n.y)):(this._centerSpringX.springTo(n.x),this._centerSpringY.springTo(n.y))},zoomBy:function(n,t,i){this.zoomTo(this._zoomSpring.getTarget()*n,t,i)},zoomTo:function(n,t,i){i?this._zoomSpring.resetTo(n):this._zoomSpring.springTo(n);this.zoomPoint=t instanceof Sys.Extended.UI.Seadragon.Point?t:null},resize:function(n,t){var r=this.getBounds(),i=r,u=n.x/this._containerSize.x;this._containerSize=new Sys.Extended.UI.Seadragon.Point(n.x,n.y);t&&(i.width=r.width*u,i.height=i.width/this.getAspectRatio());this.fitBounds(i,!0)},update:function(){var r=this._centerSpringX.getCurrent(),u=this._centerSpringY.getCurrent(),n=this._zoomSpring.getCurrent(),t;if(this.zoomPoint&&(t=this.pixelFromPoint(this.zoomPoint,!0)),this._zoomSpring.update(),this.zoomPoint&&this._zoomSpring.getCurrent()!=n){var f=this.pixelFromPoint(this.zoomPoint,!0),e=f.minus(t),i=this.deltaPointsFromPixels(e,!0);this._centerSpringX.shiftBy(i.x);this._centerSpringY.shiftBy(i.y)}else this.zoomPoint=null;return this._centerSpringX.update(),this._centerSpringY.update(),this._centerSpringX.getCurrent()!=r||this._centerSpringY.getCurrent()!=u||this._zoomSpring.getCurrent()!=n},deltaPixelsFromPoints:function(n,t){return n.times(this._containerSize.x*this.getZoom(t))},deltaPointsFromPixels:function(n,t){return n.divide(this._containerSize.x*this.getZoom(t))},pixelFromPoint:function(n,t){var i=this.getBounds(t);return n.minus(i.getTopLeft()).times(this._containerSize.x/i.width)},pointFromPixel:function(n,t){var i=this.getBounds(t);return n.divide(this._containerSize.x/i.width).plus(i.getTopLeft())}};Sys.Extended.UI.Seadragon.Viewport.registerClass("Sys.Extended.UI.Seadragon.Viewport",null,Sys.IDisposable);