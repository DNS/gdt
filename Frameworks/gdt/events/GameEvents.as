package gdt.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class GameEvents extends Event {
		public static const WINDOW_CLOSE:String = "WINDOW_CLOSE";
		
		public static const LEVEL_PARSED:String = "LEVEL_PARSED";
		
		private var param:Object = new Object();
		
		public function GameEvents(type:String) { 
			super(type);
			} 
		
		public override function clone():Event  {
			return new GameEvents( type );
			}
		
		public override function toString():String {
			return formatToString( "GameEvents", "type", "bubbles", "cancelable", "eventPhase");
			}
		
		public function get params():Object {
			return param;
			}
		/**
		* @param params
		* Параметры события: {window:_window_}; {button:_button_}; ...
		*/
		public function set params(obj:Object):void {
			param = obj;
			}
	}
}