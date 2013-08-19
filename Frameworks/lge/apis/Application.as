package lge.apis {


public class Application {
	
	
	public function releaseFocus(exitCode:Number):Number {
		ExternalInterface.call("__FOA__Application__releaseFocus", exitCode);		
		return _root.EI_retCode;
	}
	
	
	public function requestFocus():Number {
		ExternalInterface.call("__FOA__Application__requestFocus");		
		return _root.EI_retCode;
	}
	
	
	public function setReady():Number {
		ExternalInterface.call("__FOA__Application__setReady");		
		return _root.EI_retCode;
	}	
	
	
	public function getCommonPath():Object {
		ExternalInterface.call("__FOA__Application__getCommonPath");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	public function back():Number {
		ExternalInterface.call("__FOA__Application__back");		
		return _root.EI_retCode;
	}
	
	
	public function exit(exitCode:Number): Number {
		ExternalInterface.call("__FOA__Application__exit", exitCode);
		return _root.EI_retCode;
	}
	
	
	public function getAppArgument($prop):String {
		ExternalInterface.call("__FOA__Application__getExecuteArgument");
		var kRetStr:String = _root.EI_retStr;
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);		
		var kArgument:String = kRetObj.argument;
		
		var kCateLst:Array = kArgument.split("--args ");
		var kCustomArg:String = kCateLst[1];
		
		var kBigLst:Array = kCustomArg.split("&");
		var kLen:Number = kBigLst.length;
		
		var kSmallLst:Array;
		
		for (var i:Number = 0; i < kLen; i++) {
			kSmallLst = kBigLst[i].split("=");
			if (kSmallLst[0] == $prop) {
				var str: String = kSmallLst[1];
				var space: Number = str.indexOf(" ");
				if (space != -1) {
					str = str.substring(0, space);
					return str;
				}
				return str;
			}
		}
		
		return null;
	}
	
	
	public function getSDKVersion():Object {
		ExternalInterface.call("__FOA__Application__getSDKVersion");
		var kRetStr:String = _root.EI_retStr;		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	public function getPlatformVersion():Object {
		ExternalInterface.call("__FOA__Application__getPlatformVersion");
		var kRetStr:String = _root.EI_retStr;		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
}
}