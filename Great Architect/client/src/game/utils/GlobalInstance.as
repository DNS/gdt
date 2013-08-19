package game.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Stage;
	
	public class GlobalInstance {
		
		private static var _instance	: GlobalInstance;
		
		private static var mainStage	: Stage;
		
		public function GlobalInstance() {
			
			}
		//
		public static function get instance():GlobalInstance {
			if (!_instance) {
				_instance = new GlobalInstance();
				}
			return _instance;
			}
		//
		public function get MainStage():Stage {
			return mainStage;
			}
		//
		public function set MainStage(value:Stage):void {
			mainStage = value;
			}
		//
	}
}