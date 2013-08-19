package game.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.EventDispatcher;
	
	public class EventManager extends EventDispatcher {
		
		static private var _instance:EventManager;
		
		public function EventManager() { }
		//
		public static function get instance():EventManager {
			if (!_instance) {
				_instance = new EventManager();
				}
			return _instance;
			}
		//
		public function switchScene(scene:String):void {
			dispatchEvent(new GameEvent(GameEvent.SCENE_EVENT, new EventParams(EventParams.SWITCH_SCENE, scene)));
			}
	}
}