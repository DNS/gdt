package game.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class EventParams {
		
		public static const SWITCH_SCENE:String = "switch_scene";
		public static const PROGRESS	:String = "progress";
		public static const POINT		:String = "point";
		public static const ADD_RES		:String = "add_res";
		public static const TUTORIAL	:String = "tutorial";
		
		private var _type	: String = "";
		private var _target	: String = "";
		private var _params	: Object = null;
		
		public function EventParams(type:String = null, target:String = null, params:Object = null) {
			_type = type;
			_target = target;
			_params = params;
			}
		//
		public function get type():String {
			return _type;
			}
		//
		public function set type(value:String):void {
			_type = value;
			}
		//
		public function get target():String {
				return _target;
			}
		//
		public function set target(value:String):void {
			_target = value;
			}
		//
		public function get params():Object {
			return _params;
			}
		//
		public function set params(value:Object):void {
			_params = value;
			}
		//
		
	}
}