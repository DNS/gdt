package game.events {
	import flash.events.Event;
	//
	public class GameEvent extends Event {
		
		public static const GEM_DEATH:String  = "GEM_DEATH";
		
		private var _params:*;
		
		public function GameEvent(type:       String,
								  _params:    *  = null,
								  bubbles:    Boolean = false,
								  cancalable: Boolean = false) {
			super(type, bubbles, cancalable);
			}
		//
		public function set params(val:*):void {
			_params = val;
			}
		//
		public function get params():* {
			return _params;
			}
		//
		public override function clone(): Event {
			return new GameEvent(type, _params, bubbles, cancelable);
			}
		//
		public override function toString():String {
			return formatToString("poolEvent", "type", "bubbles", 
				"cancelable", "eventPhase", "param");
			}
	}
}