


class lge.utils.XmlToObject {	
	
	public static function parseXmlToObject($xmlStr:String):Object {
		if ($xmlStr == null || $xmlStr.length == 0) return null;
		
		var kXml:XML = new XML();
		kXml.ignoreWhite = true;
		kXml.parseXML($xmlStr);		
		
		var kRetObj:Object = getParsedObjWithXml(kXml.firstChild);	
		
		delete kXml;
		
		return kRetObj;
	}
	
	
	private static function getParsedObjWithXml($xml:XMLNode):Object {
		
		var kObj:Object = new Object();
		var kChildLst:Array = $xml.childNodes;
		var kLen:Number = kChildLst.length;
		var kChildNode:XMLNode;
		var kName:String;
		var kValue:String;
		var kSubLst:Array;
		for (var i:Number = 0; i < kLen; i++) {
			kChildNode = kChildLst[i];
			if (kChildNode.childNodes.length > 0) {
				kName = kChildNode.nodeName;
				kValue = kChildNode.firstChild.nodeValue;
				
				if (kValue == null) {
					//== node value가 없이 child node가 있는 경우
					//- child node가 있는데, nodevalue가 null이라는 말은 서버 xml node를 갖고 있다는 말이다.
					//kObj[kName] = getParsedObjWithXml(kChildNode);
					
					if (kObj[kName] == null) {						
						kObj[kName] = getParsedObjWithXml(kChildNode);
					}else {
						if (!(kObj[kName] instanceof Array)) {	
							kSubLst = new Array();
							kSubLst.push(kObj[kName]);								
							kObj[kName] = kSubLst;
						}
						kObj[kName].push(getParsedObjWithXml(kChildNode));
						
					}
					
				}else {
					//== node value가 존재하는 경우(child node는 존재하지 않는다.)
					//--kObj[kName]이 null이 아니라는 말은 복수개로 존재한다는 말이다.
					
					if (kObj[kName] == null) {
						//-- 노드가 하나 존재
						kObj[kName] = kValue;
					}else {
						if (typeof(kObj[kName])=="string" ||typeof(kObj[kName])=="boolean") {
							kSubLst = new Array();
							kSubLst.push(kObj[kName]);	
							kObj[kName] = kSubLst;
						}
						
						if (kValue == "false") {
							kObj[kName].push(false);	
						}else if (kValue == "true") {
							kObj[kName].push(true);	
						}else {
							kObj[kName].push(kValue);	
						}
											
					}					
				}					
			}			
		}
		return kObj;
	}
	
	
	
	

}