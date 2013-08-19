import lge.apis.Application;

/**
 * Browse the default path for the execution of the application.
 */
class lge.apis.PathFinder{
	
	/**
	 * Browse the default path for the execution of the application.
	 * @return (String) Common path 
	 */	
	public static function getCommonPath():String {
		var kApplication:Application = new Application();
		var kRetObj:Object = kApplication.getCommonPath();		
		if (kRetObj.path == null) {
			//-- 여기에 개발자의 PC내 common 폴더 경로 기입 
			return "C:/Program Files/LGE/LG Smart TV SDK/LG_Gadget/";
		}			
		return kRetObj.path;		
	}		
	
}