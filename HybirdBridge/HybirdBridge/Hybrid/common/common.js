var YwqHybrid=Object({data:{Token:""},WebViewJB:function(b){if(window.WebViewJavascriptBridge)return b(WebViewJavascriptBridge);if(window.WVJBCallbacks)return window.WVJBCallbacks.push(b);window.WVJBCallbacks=[b];var a=document.createElement("iframe");a.style.display="none";a.src="https://__bridge_loaded__";document.documentElement.appendChild(a);setTimeout(function(){document.documentElement.removeChild(a)},0)},WebViewBridge:function(b){b&&YwqHybrid.WebViewJB(function(a){b(a)})},refreshToken:function(){YwqHybrid.WebViewBridge(function(b){b.callHandler("TGAppHandler",
{eventType:1,eventParam:{methor:"/Api/RefreshToken",param:{}}},function(a){a.data.token||YwqHybrid.alert("��¼ʧ�ܣ������µ�¼")})})},getToken:function(){YwqHybrid.WebViewBridge(function(b){b.callHandler("TGAppHandler",{eventType:1,eventParam:{methor:"/Api/GetToken",param:{}}},function(a){a.data.token&&YwqHybrid.refreshToken()})})},transfer:{remind:function(b){YwqHybrid.WebViewBridge(function(a){a.callHandler("TGAppHandler",{eventType:2,eventParam:{methor:3,param:{content:b||""}}})})},alert:function(b){YwqHybrid.WebViewBridge(function(a){a.callHandler("TGAppHandler",
{eventType:2,eventParam:{methor:2,param:b}})})},avatarPlugin:function(b){YwqHybrid.WebViewBridge(function(a){a.callHandler("TGAppHandler",{eventType:2,eventParam:{methor:5,param:{}}},function(a){b(a)})})},selectPlugin:function(b,a,c){YwqHybrid.WebViewBridge(function(d){d.callHandler("TGAppHandler",{eventType:2,eventParam:{methor:4,param:{title:a,buttons:b}}},function(a){c(a)})})},pickViewPlugin:function(b,a,c,d){"string"!==typeof a&&3==b&&(a=a.toString());YwqHybrid.WebViewBridge(function(e){e.callHandler("TGAppHandler",
{eventType:2,eventParam:{methor:6,param:{title:c||"",content:a||"",type:b||1}}},function(a){d(a)})})}},navigation:{show:function(b){YwqHybrid.WebViewBridge(function(a){a.callHandler("TGAppHandler",{eventType:"2",eventParam:{methor:"1",param:b}})})}},putUserInfo:function(b,a){YwqHybrid.WebViewBridge(function(c){c.callHandler("TGAppHandler",{eventType:"1",eventParam:{methor:"/Api/PutUserInfo",param:b||{}}},function(b){"0x00000000"==b.state_code?a(b):""!=b.message?ywqHybrid.remind(b.message):ywqHybrid.remind("�޸�ʧ�ܣ�������")})})},
closeWebView:function(){YwqHybrid.WebViewBridge(function(b){b.callHandler("TGAppHandler",{eventType:"1",eventParam:{methor:"/Api/CloseWebView",param:{}}})})},registerHandler:function(b){YwqHybrid.WebViewBridge(function(a){a.registerHandler("TGJsHandler",function(c,d){b(c,a)})})},console:function(b){b=JSON.stringify(b);var a=document.getElementById("log"),c=document.createElement("div");c.className="logLine";c.innerHTML=b;a.children.length?a.insertBefore(c,a.children[0]):a.appendChild(c)}});
window.ywqHybrid=ywqHybrid=YwqHybrid;
