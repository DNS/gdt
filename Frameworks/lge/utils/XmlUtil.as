import lge.apps.LGCustomEventManager;
import lge.apps.LGEvent;

/**
 * Loads and parses XML data. The parsed data can be referenced using getResultArray():Array and consists of the following:<br>
 * - The node name is stored in the Array.nodename attribute.<br>
 * - The attribute is stored in the format of Array.attribute = value.<br>
 * - The childnode is stored in the Array.lst attribute.<br>
 * - If the childnode attribute is "string", it is stored in the Array.nodevalue attribute.
 * 
 * {@code
 * - init.xml : 
 <data>	
	<index url="../test_url.ins">
		<id index='2' />
		<id index='6' />
		<id index='8' />
	</index>

	<pages>
		<page path='images/images_0007_Layer.jpg'  index='3'  >test</page>
		<page path='images/images_0000_Layer.jpg'  index='4'  >ex</page>
		<page path='images/images_0001_Layer.jpg'   index='5' >sample</page>
	</pages>
	
</data>
 * 
 *import lge.apps.LGEvent;
import lge.utils.XmlUtil;

var xl:XmlUtil = new XmlUtil();
xl.addEventReceiver(this);

xl.loadXml("init.xml");


function onEventReceived($evt:LGEvent):Void {
	var kID:String = $evt.id;

	if (kID == LGEvent.LOAD_SUCCEED) {
		var arr:Array = xl.getResultArray();
		trace(arr[0].nodename); 			// -> output : index
		trace(arr[0].url);						// -> output : ../test_url.ins
		trace(arr[0].lst[2].index)			// -> output : 8
		trace(arr[1].lst[0].nodevalue)	// -> output : test
		trace(arr[1].lst[1].path);			// -> output : images/images_0000_Layer.jpg
	} else if (kID == LGEvent.LOAD_ERROR) {
		trace("loading error")
	}

}
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onLoadSucceed
 * 	<li>LGEvent value: LOAD_SUCCEED</li>
 * 	<li>Event fired when loading the XML file succeeds</li>
 * </ul>
 * <ul> onLoadError
 * 	<li>LGEvent value: LOAD_ERROR</li>
 * 	<li>Event fired when loading the XML file fails</li>
 * </ul>
 */
class lge.utils.XmlUtil extends LGCustomEventManager{

	public function dealloc():Void {
		loadXml = null;
		onEndLoadXml = null;
		deleteXml();
	}	
	
	private function deleteXml():Void {
		delete xml.onLoad;
		delete xml;
		xml = null;
	}
	
	private var xml:XML;	
	private var resultArr:Array;
	//-두번째 매개변수(xml)가 넘어오면 이걸로 xml 오브젝트를 만들고
	//--없다면 새로이 xml 오브젝트를 만든다.
	/**
	 * Stores the result in an array after loading and parsing XML data.
	 * Then, an event is fired. ("onLoadSucceed" if the operation succeeds; otherwise "onLoadError".)
	 * @param	$URL (String) The URL address to load XML data
	 * @param	$xml (XML) An optional parameter If this parameter is omitted, a new XML object is created to load the XML data.
	 * An element may need to be attached to the XML header. In this case, create an XML object with the header and pass it as a parameter
	 * to let the function use the XML object.
	 */
	public function loadXml($URL:String, $xml:XML):Void {
		deleteXml();
		xml = ($xml == null) ? new XML() : $xml;
		xml.ignoreWhite = true;
		var kThis:XmlUtil = this;
		xml.onLoad = function($success:Boolean):Void {
			kThis.onLoad($success);
		}
		//xml.sendAndLoad($URL,xml);
		xml.load($URL);
	}	
	
	private function onLoad($success:Boolean):Void {		
		var kResultLst:Array;
		if ($success) {
			kResultLst = parseXml(xml);
		}
		//----필요 없는 xml을 지우고--  
		deleteXml();
		//-- 결과를 delegate 한다.
		onEndLoadXml(kResultLst);
	}
	
	public function onEndLoadXml($resultArr:Array):Void {
		resultArr = $resultArr;
		if ($resultArr == null) {
			triggerEvent(LGEvent.LOAD_ERROR, this);
		}else {
			triggerEvent(LGEvent.LOAD_SUCCEED, this);
		}
		
	}
	
	public function parseXmlToArray($strXml:String):Array {
		var kXml:XML = new XML();
		kXml.ignoreWhite = true;
		kXml.parseXML($strXml);	
		
	    return parseXml(kXml);
	}	
	
	private function parseXml($xml:XML):Array {
		return getObjFromNode($xml.firstChild).lst;
	}
	
	private function getObjFromNode($node:XMLNode):Object {
		var kObj:Object = new Object();
		//---!-nodeName은 "nodename"으로 저장----
		kObj.nodename = $node.nodeName;
		//==============
		var i:String;
		for (i in $node.attributes) {
			kObj[i] = $node.attributes[i];
		}
		//=============================
		if ($node.childNodes.length>0) {
			if ($node.firstChild.nodeValue != undefined) {
				//---!-nodeValue "nodevalue"으로 저장----
				kObj.nodevalue = $node.firstChild.nodeValue;
				//===========
			}
			//---!-childnode는 "lst"으로 저장----   
			kObj.lst = getLstFromNode($node);
			//========================
		}
		return kObj;
	}
	
	private function getLstFromNode($node:XMLNode):Array {
		var kLst:Array = new Array();
		var kNode:XMLNode;
		for (var i:Number = 0; i<$node.childNodes.length; i++) {
			kNode = $node.childNodes[i];
			if (kNode.nodeName != undefined) {
				kLst.push(getObjFromNode(kNode));
			}
		}
		return kLst;
	}
	/**
	 * Returns an array of parsed XML after loading and parsing it.
	 * @return (array) An array of parsed XML 
	 */
	public function getResultArray():Array {
		return resultArr;
	}

}