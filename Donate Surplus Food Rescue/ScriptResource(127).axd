﻿Type.registerNamespace("Sys.Extended.UI");Sys.Extended.UI.LineChart=function(n){Sys.Extended.UI.LineChart.initializeBase(this,[n]);var t=this.get_id();t=t.replace("_ctl00","");this._parentDiv=document.getElementById(t+"__ParentDiv");this._chartWidth="300";this._chartHeight="300";this._chartTitle="";this._categoriesAxis="";this._series=null;this._chartType=Sys.Extended.UI.LineChartType.Basic;this._theme="LineChart";this._valueAxisLines=9;this._chartTitleColor="";this._valueAxisLineColor="";this._categoryAxisLineColor="";this._baseLineColor="";this._tooltipBackgroundColor="#ffffff";this._tooltipFontColor="#0E426C";this._tooltipBorderColor="#B85B3E";this._areaDataLabel="";this.yMax=0;this.yMin=0;this.roundedTickRange=0;this.startX=0;this.startY=0;this.endX=0;this.endY=0;this.xInterval=0;this.yInterval=0;this.arrXAxis;this.arrXAxisLength=0;this.charLength=3.5;this.arrCombinedData=null;this._toolTipDiv};Sys.Extended.UI.LineChart.prototype={initialize:function(){if(Sys.Extended.UI.LineChart.callBaseMethod(this,"initialize"),!document.implementation.hasFeature("http://www.w3.org/TR/SVG11/feature#Image","1.1"))throw"Browser does not support SVG.";this._valueAxisLines==0&&(this._valueAxisLines=9);this.generateTooltipDiv();this.generateLineChart()},dispose:function(){Sys.Extended.UI.LineChart.callBaseMethod(this,"dispose")},generateTooltipDiv:function(){this._divTooltip=$common.createElementFromTemplate({nodeName:"div",properties:{id:this.get_id()+"_tooltipDiv",style:{position:"absolute",backgroundColor:this._tooltipBackgroundColor,borderStyle:"solid",borderWidth:"5px",borderColor:this._tooltipBorderColor,left:"0px",top:"0px",color:this._tooltipFontColor,visibility:"hidden",zIndex:"10000",padding:"10px"}}},this._parentDiv)},generateLineChart:function(){this.arrXAxis=this._categoriesAxis.split(",");this.arrXAxisLength=this.arrXAxis.length;this.calculateMinMaxValues();this.calculateInterval();this.calculateValueAxis();var n=this.initializeSVG();n=n+String.format('<text x="{0}" y="{1}" id="ChartTitle" style="fill:{3}">{2}<\/text>',parseInt(this._chartWidth)/2-this._chartTitle.length*this.charLength,parseInt(this._chartHeight)/20,this._chartTitle,this._chartTitleColor);n=n+this.drawBackgroundHorizontalLines();n=n+this.drawBackgroundVerticalLines();n=n+this.drawBaseLines();n=n+this.drawLegendArea();n=n+this.drawAxisValues();this._parentDiv.innerHTML=this._parentDiv.innerHTML+n;this.drawLines()},calculateInterval:function(){this.startX=this._chartWidth/10+.5;this.endX=parseInt(this._chartWidth)-4.5;this.startY=this.yMin>=0?Math.round(parseInt(this._chartHeight)-parseInt(this._chartHeight)*24/100)+.5:Math.round(parseInt(this._chartHeight)-parseInt(this._chartHeight)*12/100)/2+.5;this.yInterval=this.startY/(this._valueAxisLines+1)},calculateMinMaxValues:function(){var u,i,r,t,n;if(this._chartType==Sys.Extended.UI.LineChartType.Basic)for(n=0;n<this._series.length;n++){for(r=[],t=0;t<this._series[n].Data.length;t++)r[t]=this._series[n].Data[t];u=Math.max.apply(null,r);i=Math.min.apply(null,r);n==0?(this.yMax=u,this.yMin=i):(u>this.yMax&&(this.yMax=u),i<this.yMin&&(this.yMin=i))}else{for(this.arrCombinedData=null,n=0;n<this._series.length;n++){for(r=[],t=0;t<this._series[n].Data.length;t++)r[t]=this._series[n].Data[t];if(this.arrCombinedData==null)this.arrCombinedData=r;else for(t=0;t<this._series[n].Data.length;t++)this.arrCombinedData[t]=parseFloat(this.arrCombinedData[t])+parseFloat(r[t])}for(n=0;n<this._series.length;n++)i=Math.min.apply(null,this._series[n].Data),n==0?this.yMin=i:i<this.yMin&&(this.yMin=i);this.yMax=Math.max.apply(null,this.arrCombinedData)}this.yMin<0&&(this._valueAxisLines=Math.round(this._valueAxisLines/2))},calculateValueAxis:function(){var i,n,r,t;i=this.yMin>=0?this.yMax:this.yMax>Math.abs(this.yMin)?this.yMax:Math.abs(this.yMin);n=i/(this._valueAxisLines-1);n<1?this.roundedTickRange=n.toFixed(1):(r=Math.ceil(Math.log(n)/Math.log(10)-1),t=Math.pow(10,r),this.roundedTickRange=Math.ceil(n/t)*t);this.startX=this.startX+(this.roundedTickRange*10*this._valueAxisLines/10).toString().length*this.charLength},drawBackgroundHorizontalLines:function(){for(var t="",n=1;n<=this._valueAxisLines;n++)t=t+String.format('<path d="M{0} {2} {1} {2}" id="HorizontalLine" style="stroke:{3}"><\/path>',this.startX,this.endX,this.startY-this.yInterval*n,this._categoryAxisLineColor);if(this.yMin<0)for(n=1;n<=this._valueAxisLines;n++)t=t+String.format('<path d="M{0} {2} {1} {2}" id="HorizontalLine" style="stroke:{3}"><\/path>',this.startX,this.endX,this.startY+this.yInterval*n,this._categoryAxisLineColor);return t},drawBackgroundVerticalLines:function(){var t="",n;for(this.xInterval=Math.round((parseInt(this._chartWidth)-this.startX)/this.arrXAxisLength),n=0;n<this.arrXAxisLength;n++)t=t+String.format('<path id="VerticalLine" d="M{0} {1} {0} {2}" style="stroke:{3}"><\/path>',parseInt(this._chartWidth)-5-this.xInterval*n,this.startY-this.yInterval*this._valueAxisLines,this.startY,this._valueAxisLineColor);if(this.yMin<0)for(n=0;n<this.arrXAxisLength;n++)t=t+String.format('<path id="VerticalLine" d="M{0} {1} {0} {2}" style="stroke:{3}"><\/path>',parseInt(this._chartWidth)-5-this.xInterval*n,this.startY+this.yInterval*this._valueAxisLines,this.startY,this._valueAxisLineColor);return t},drawBaseLines:function(){var n="",t;for(n=n+String.format('<path d="M{0} {1} {2} {1}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX,this.startY,this.endX,this._baseLineColor),n=n+String.format('<path d="M{0} {1} {0} {2}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX,this.startY-this.yInterval*this._valueAxisLines,this.startY,this._baseLineColor),n=n+String.format('<path d="M{0} {1} {0} {2}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX,this.startY,this.startY+4,this._baseLineColor),t=0;t<this.arrXAxisLength;t++)n=n+String.format('<path d="M{0} {1} {0} {2}" id="BaseLine" style="stroke:{3}"><\/path>',parseInt(this._chartWidth)-5-this.xInterval*t,this.startY,this.startY+4,this._baseLineColor);for(t=0;t<=this._valueAxisLines;t++)n=n+String.format('<path d="M{0} {2} {1} {2}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX-4,this.startX,this.startY-this.yInterval*t,this._baseLineColor);if(this.yMin<0)for(n=n+String.format('<path d="M{0} {1} {0} {2}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX,this.startY+this.yInterval*this._valueAxisLines,this.startY,this._baseLineColor),t=1;t<=this._valueAxisLines;t++)n=n+String.format('<path d="M{0} {2} {1} {2}" id="BaseLine" style="stroke:{3}"><\/path>',this.startX-4,this.startX,this.startY+this.yInterval*t,this._baseLineColor);return n},drawLegendArea:function(){for(var t="",o=parseInt(this._chartHeight)*82/100+5,i=7.5,u=5,c=0,r,l,n=0;n<this._series.length;n++)c=c+this._series[n].Name.length;r=Math.round(c*5/2)+Math.round((i+u*2)*this._series.length);l=!1;r>parseInt(this._chartWidth)/2&&(r=r/2,l=!0);t=t+"<g>";t=t+String.format('<path d="M{0} {1} {2} {1} {2} {3} {0} {3} z" id="LegendArea" stroke=""><\/path>',parseInt(this._chartWidth)/2-r/2,o,Math.round(parseInt(this._chartWidth)/2+c*5)+Math.round((i+u*2)*this._series.length),Math.round(parseInt(this._chartHeight)*97.5/100));var e=parseInt(this._chartWidth)/2-r/2+5+i+u,s=e,f=parseInt(this._chartWidth)/2-r/2+5,h=f;for(n=0;n<this._series.length;n++)l&&n==Math.round(this._series.length/2)&&(e=parseInt(this._chartWidth)/2-r/2+5+i+u,s=e,f=parseInt(this._chartWidth)/2-r/2+5,h=f,o=parseInt(this._chartHeight)*89/100+5,l=!1),f=h,e=s,t=t+String.format('<path d="M{0} {1} {2} {1} {2} {3} {0} {3} z" id="Legend{4}" style="fill:{5}"><\/path>',f,o+7.5,f+i,o+15,n+1,this._series[n].LineColor),t=t+String.format('<text x="{0}" y="{1}" id="LegendText">{2}<\/text>',e,o+15,this._series[n].Name),this._series[n].Name.length>10?(h=f+this._series[n].Name.length*5+i+u*2,s=e+this._series[n].Name.length*5+i+u*2):(h=h+this._series[n].Name.length*6+i+u*2,s=s+this._series[n].Name.length*6+i+u*2);return t+"<\/g>"},drawAxisValues:function(){for(var t="",i=0,n=0;n<this.arrXAxisLength;n++)i=this.arrXAxis[n].toString().length*this.charLength,t=t+String.format('<text id="SeriesAxis" x="{0}" y="{1}" fill-opacity="1">{2}<\/text>',Math.round(this.startX+this.xInterval*n+this.xInterval/2-i),this.startY+Math.round(this.yInterval*65/100),this.arrXAxis[n]);for(n=0;n<=this._valueAxisLines;n++)t=t+String.format('<text id="ValueAxis" x="{0}" y="{1}">{2}<\/text>',this.startX-(this.roundedTickRange*10*n/10).toString().length*5.5-10,this.startY-this.yInterval*n+3.5,this.roundedTickRange*10*n/10);if(this.yMin<0)for(n=1;n<=this._valueAxisLines;n++)t=t+String.format('<text id="ValueAxis" x="{0}" y="{1}">-{2}<\/text>',this.startX-(this.roundedTickRange*10*n/10).toString().length*5.5-15,this.startY+this.yInterval*n,this.roundedTickRange*10*n/10);return t},initializeSVG:function(){var n=String.format('<?xml-stylesheet type="text/css" href="{0}.css"?>',this._theme);return n=n+String.format('<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="{0}" height="{1}" style="position: relative; display: block;">',this._chartWidth,this._chartHeight),n=n+"<defs>",n=n+'<linearGradient gradientTransform="rotate(0)">',n=n+'<stop offset="0%" id="LinearGradient-Stop1"><\/stop>',n=n+'<stop offset="25%" id="LinearGradient-Stop2"><\/stop>',n=n+'<stop offset="100%" id="LinearGradient-Stop3"><\/stop><\/linearGradient>',n=n+"<\/defs>",n=n+String.format('<path fill="none" stroke-opacity="1" fill-opacity="1" stroke-linejoin="round" stroke-linecap="square" d="M5 {0} {1} {0} {1} {2} 5 {2} z"/>',parseInt(this._chartHeight)/10+5,parseInt(this._chartWidth)-5,parseInt(this._chartHeight)-parseInt(this._chartHeight)/10),n=n+String.format('<path id="ChartBackGround" stroke="" d="M0 0 {0} 0 {0} {1} 0 {1} z"/>',this._chartWidth,this._chartHeight),n+String.format('<path fill="#fff" stroke-opacity="1" fill-opacity="0" stroke-linejoin="round" stroke-linecap="square" stroke="" d="M5 {0} {1} {0} {1} {2} 5 {2} z" />',parseInt(this._chartHeight)/10+5,parseInt(this._chartWidth)-5,parseInt(this._chartHeight)-parseInt(this._chartHeight)/10)},drawLines:function(){var t,i,n;for(t=[],i=[],n=0;n<this._series.length;n++)t[n]=this.startX,i[n]=this.startY;this.animateLines(this,t,i,0,0)},animateLines:function(n,t,i,r,u){for(var f=0;f<n._series.length;f++){if(r=0,n._chartType==Sys.Extended.UI.LineChartType.Stacked)for(k=0;k<=f;k++)r=parseFloat(r)+parseFloat(n._series[k].Data[u]);else r=n._series[f].Data[u];n._parentDiv.innerHTML=n._chartType==Sys.Extended.UI.LineChartType.Stacked?n.arrCombinedData[u]>0?u>0?n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<path d="M{0} {1} {2} {3}" id="Line{4}" style="fill:{5};stroke:{5}"><\/path>',t[f],i[f],n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))-7.5,r):n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))-7.5,r):u>0?n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<path d="M{0} {1} {2} {3}" id="Line{4}" style="fill:{5};stroke:{5}"><\/path>',t[f],i[f],n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))+7.5,r):n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))+7.5,r):r>0?u>0?n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<path d="M{0} {1} {2} {3}" id="Line{4}" style="fill:{5};stroke:{5}"><\/path>',t[f],i[f],n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))-7.5,r):n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))-7.5,r):u>0?n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<path d="M{0} {1} {2} {3}" id="Line{4}" style="fill:{5};stroke:{5}"><\/path>',t[f],i[f],n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))+7.5,r):n._parentDiv.innerHTML.replace("<\/svg>","")+String.format('<circle id="Dot{2}" cx="{0}" cy="{1}" r="4" style="fill:{3};stroke:{3}" onmouseover="ShowTooltip(this, evt, {4}, \'{5}\')" onmouseout="HideTooltip(this, evt)"><\/circle>',n.startX+n.xInterval*u+n.xInterval/2,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange)),f+1,n._series[f].LineColor,r,n._areaDataLabel)+String.format('<text id="LegendText" x="{0}" y="{1}">{2}<\/text>',n.startX+n.xInterval*u+n.xInterval/5,n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))+7.5,r);t[f]=n.startX+n.xInterval*u+n.xInterval/2+3;i[f]=n.startY-Math.round(r*(n.yInterval/n.roundedTickRange))}u++;u<n.arrXAxisLength&&setTimeout(function(){n.animateLines(n,t,i,0,u)},400)},get_chartWidth:function(){return this._chartWidth},set_chartWidth:function(n){this._chartWidth=n},get_chartHeight:function(){return this._chartHeight},set_chartHeight:function(n){this._chartHeight=n},get_chartTitle:function(){return this._chartTitle},set_chartTitle:function(n){this._chartTitle=n},get_categoriesAxis:function(){return this._categoriesAxis},set_categoriesAxis:function(n){this._categoriesAxis=n},get_ClientSeries:function(){return this._series},set_ClientSeries:function(n){this._series=n},get_chartType:function(){return this._chartType},set_chartType:function(n){this._chartType=n},get_theme:function(){return this._theme},set_theme:function(n){this._theme=n},get_valueAxisLines:function(){return this._valueAxisLines},set_valueAxisLines:function(n){this._valueAxisLines=n},get_chartTitleColor:function(){return this._chartTitleColor},set_chartTitleColor:function(n){this._chartTitleColor=n},get_valueAxisLineColor:function(){return this._valueAxisLineColor},set_valueAxisLineColor:function(n){this._valueAxisLineColor=n},get_categoryAxisLineColor:function(){return this._categoryAxisLineColor},set_categoryAxisLineColor:function(n){this._categoryAxisLineColor=n},get_baseLineColor:function(){return this._baseLineColor},set_baseLineColor:function(n){this._baseLineColor=n},get_tooltipBackgroundColor:function(){return this.tooltipBackgroundColor},set_tooltipBackgroundColor:function(n){this.tooltipBackgroundColor=n},get_tooltipFontColor:function(){return this._tooltipFontColor},set_tooltipFontColor:function(n){this._tooltipFontColor=n},get_tooltipBorderColor:function(){return this._tooltipBorderColor},set_tooltipBorderColor:function(n){this._tooltipBorderColor=n},get_areaDataLabel:function(){return this._areaDataLabel},set_areaDataLabel:function(n){this._areaDataLabel=n}};Sys.Extended.UI.LineChart.registerClass("Sys.Extended.UI.LineChart",Sys.Extended.UI.ControlBase);Sys.registerComponent(Sys.Extended.UI.LineChart,{name:"LineChart",parameters:[{name:"ClientSeries",type:"LineChartSeries[]"}]});Sys.Extended.UI.LineChartType=function(){throw Error.invalidOperation();};Sys.Extended.UI.LineChartType.prototype={Basic:0,Stacked:1};Sys.Extended.UI.LineChartType.registerEnum("Sys.Extended.UI.LineChartType",!1);