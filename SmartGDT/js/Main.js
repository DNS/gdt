// IPTV
var channels = new Array();
	channels[0] = "http://10.1.10.21:8082/1plus1";
	channels[1] = "http://10.1.10.21:8083/novy";
	channels[2] = "http://10.1.10.21:8083/stb";
	channels[3] = "http://10.1.10.21:8083/ictv";
	channels[4] = "http://10.1.10.21:8082/tonis";
	channels[5] = "http://10.1.10.21:8081/mega";
	channels[6] = "http://10.1.10.21:8083/m1";
	channels[7] = "http://10.1.10.21:8082/otv";
	channels[8] = "http://10.1.10.21:8084/rumusic";
	channels[9] = "http://10.1.10.21:8081/entm";
	channels[10] = "http://10.1.10.21:8081/mtv";
	channels[11] = "http://10.1.10.21:8084/pogoda";
	channels[12] = "http://10.1.10.21:8082/menutv";
// exua
var xmlHTTP;

//
var nStart = 0;
var items;
//
function hideShow(object, visible){
	var obj = document.getElementById(object);
	obj.style.visibility = visible;
	}
//
function setPart(part){
	//
	switch(part){
		case "iptv":
			hideShow("exua", "hidden");
			break;
		case "exFilms":
			
			break;
		}
	}
//
function loadExuaPart(){
	if(xmlHTTP == null){
		xmlHTTP = new XMLHttpRequest();
		}
	//
	xmlHTTP.onreadystatechange = function (){
		if (xmlHTTP.readyState == 4) {
			traceMe("status: "+xmlHTTP.status);
			if(xmlHTTP.status == 200) {
				parseData();
				}
			}
		} 
	//
	xmlHTTP.open("GET", "http://www.ex.ua/ru/video/foreign?p=1&per=15", true);
   	xmlHTTP.send(null);
	}
//
function parseData(){
	var matchArray = xmlHTTP.responseText.match(new RegExp('<td align=center valign=center[^>]*>(?:(?!<td[^>]*>|</td>).)*</td>', 'gim'));
	//
	if(matchArray.length > 0){
		addPartItems(matchArray);
		}
	traceMe("matchArray.length: "+matchArray.length);
	}
//
function addPartItems(items){
	
	}
//
function traceMe(text, clear){
	if(clear == true){
		document.getElementById('info').value = "";
		}
	document.getElementById('info').value += text+"\n";
	}