package game.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class GameEvent extends Event {
		
		public static const LOADER_PROGRESS	: String = "loader_progress";
		public static const CITYBG_LOADED	: String = "citybg_loaded";
		
		public static const SCENE_EVENT		: String = "scene_event";
		
		public static const TUTORIAL_EVENT	: String = "tutorial_event";
		
		public static const CITY_EVENT		: String = "city_event";
		public static const CITY_TO_POINT	: String = "city_to_point";
		
		public static const GEMS_ADD_RES	: String = "gems_add_res";
		
		private var _params:EventParams = null;
		
		public function GameEvent(type:String, params:EventParams = null) {
			super(type, false, false);
			_params = params;
			} 
		//
		public override function clone():Event { 
			return new GameEvent(type);
			} 
		//
		public override function toString():String { 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
			}
		//
		public function get params():EventParams {
			return _params;
			}
		//
		public function set params(value:EventParams):void {
			_params = value;
			}
		//
	}
	
}