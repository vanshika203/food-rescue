﻿// (c) 2010 CodePlex Foundation
Type.registerNamespace("Sys.Extended.UI");Type.registerNamespace("Seadragon");Sys.Extended.UI.Seadragon.Strings={Errors:{Failure:"Sorry, but Seadragon Ajax can't run on your browser!\nPlease try using IE 7 or Firefox 3.\n",Dzc:"Sorry, we don't support Deep Zoom Collections!",Dzi:"Hmm, this doesn't appear to be a valid Deep Zoom Image.",Xml:"Hmm, this doesn't appear to be a valid Deep Zoom Image.",Empty:"You asked us to open nothing, so we did just that.",ImageFormat:"Sorry, we don't support {0}-based Deep Zoom Images.",Security:"It looks like a security restriction stopped us from loading this Deep Zoom Image.",Status:"This space unintentionally left blank ({0} {1}).",Unknown:"Whoops, something inexplicably went wrong. Sorry!"},Messages:{Loading:"Loading..."},Tooltips:{FullPage:"Toggle full page",Home:"Go home",ZoomIn:"Zoom in",ZoomOut:"Zoom out"},getString:function(n){for(var u=n.split("."),t=Sys.Extended.UI.Seadragon.Strings,r,i=0;i<u.length;i++)t=t[u[i]]||{};return typeof t!="string"&&(t=""),r=arguments,t.replace(/\{\d+\}/g,function(n){var t=parseInt(n.match(/\d+/))+1;return t<r.length?r[t]:""})},setString:function(n,t){for(var r=n.split("."),u=Seadragon.Strings,i=0;i<r.length-1;i++)u[r[i]]||(u[r[i]]={}),u=u[r[i]];u[r[i]]=t}};Seadragon.Strings=Sys.Extended.UI.Seadragon.Strings;