import lge.apis.Control;
import flash.external.ExternalInterface;

/**
* API for TV system
*/
class lge.apis.TVSystem {	
	
	/**
	 * A function called when the user presses the Back button in the top menu<br>
	 * to close the current application and go back to the previous application that opened the current one. 
	 */	
	public static function back():Void {			
		ExternalInterface.call("__FOA__Application__back");				
	}	
	
	/**
	 * Terminates the application which is currently running.
	 */
	public static function exit():Void {			
		ExternalInterface.call("__FOA__Application__exit");		
	}
	
	/**
	  *	Gets the country, language and country group information from the TV settings.<br>
	 * The country code complies with the ISO-3166 Alpha-3 standard.
	 * It returns a string that represents the three-letter code (alpha-3) of ISO 3166-1.<br>
	 * For example,<br>
	 *	 ISO 3166-1	code				The country code to be returned<br>
	 *		KOR							"KOR"<br>
	 * @return (String) ISO 3166-1 alpha-3 country code
	 */
	public static function getCountry():String {
		var kControl:Control = new Control();
		var kInfo:Object = kControl.getLocaleInfo();
		return kInfo.country;		
	}
	
	
	/**
	* The language code complies with the ISO 639-2 standard.
	 * It returns a string that represents the three-letter code (alpha-3) of ISO 639.<br>
	 * For example,<br>
	 *	 ISO 639-2 code				The language code to be returned<br>
	 *		kor							"kor"<br>
	 * @return (String) ISO 639-2 language code
	 */
	public static  function getMenuLanguage():String {			
		var kControl:Control = new Control();
		var kInfo:Object = kControl.getLocaleInfo();
		return kInfo.language;		
	}
	
	/**
	 * Gets the group information from the TV settings and returns it in number. Group is defined as lge.apis.LocaleGroup.
	 * @return (Number) lge.apis.LocaleGroup 
	 */
	public static  function getRegion():String {
		var kControl:Control = new Control();
		var kInfo:Object = kControl.getLocaleInfo();
		return kInfo.group;		
	}
	
	
	/**
	 * Gets the project name of the TV.
	 * @return (String) Project Name
	 */
	public static function getSystemType():String {
		var kControl:Control = new Control();
		var kInfo:Object = kControl.getSystemInfo();
		var kProjectName:String =  kInfo.projectName;
		var kSplitLst:Array = kProjectName.split("_");
		return kSplitLst[0];
	}
	
	
}