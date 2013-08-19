package assets.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class AssetsEvent extends Event {
		
		public static const ALL_LOADED		: String = "all_loaded";
		public static const MODELS_LOADED	: String = "models_loaded";
		public static const TEXTURES_LOADED	: String = "textures_loaded";
		public static const LOADED			: String = "loaded";
		public static const LOAD_PROGRESS	: String = "load_progress";
		
		private var _data:Object;
		
		public function AssetsEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			} 
		//
		public override function clone():Event { 
			return new AssetsEvent(type, bubbles, cancelable);
			} 
		//
		public override function toString():String { 
			return formatToString("AssetsEvent", "type", "bubbles", "cancelable", "eventPhase"); 
			}
		//
		public function get data():Object {
			return _data;
			}
		//
		public function set data(value:Object):void {
			_data = value;
			}
		//
	}
}