package gdt.platform {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.system.Capabilities;
	
	public class Platform {
		private static var _instance	: Platform;
		
		public static const ANDROID		: String = "ANDROID";
		public static const WINDOWS		: String = "WINDOWS";
		
		public static var platform		: String = "NULL";
		public static var OS			: String = "NULL";
		public static var manufacturer	: String = "NULL";
		
		public static var mouseHand		: Boolean = false;
		
		public function Platform() { }
		//
		public static function get instance():Platform {
			if (!_instance) {
				_instance = new Platform();
				}
			return _instance;
			}
		//
		public function getPlatform():void {
			OS = Capabilities.os;
			manufacturer = Capabilities.manufacturer;
			
			switch(OS.substr(0, 3)) {
				case "Win":
					mouseHand = true;
					platform = WINDOWS;
					break;
				case "Mac":
					mouseHand = true;
					break;
				case "Lin":
					var isAndroid:int = manufacturer.match(/android/gi).length;
					if (isAndroid > 0) { platform = ANDROID };
					break;
				}
			}
		//
		public static function clientInfo():Array {
			var info:Array = new Array();
			
			info.push(String("OS: " + OS + ", manufacturer: " + Capabilities.manufacturer + ", Version: " + Capabilities.version));
			
			//info.push(String("OS: " + Capabilities.os));
			
			return info;
			}
	}
}