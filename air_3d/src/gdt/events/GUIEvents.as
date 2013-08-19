package gdt.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class GUIEvents extends Event {
		public static const WINDOW_CLOSE:String = "WINDOW_CLOSE";
		public static const BUTTON_CLICK:String = "BUTTON_CLICK";
		
		private var param:Object = new Object();
		
		public function GUIEvents(type:String) { 
			super(type);
			} 
		
		public override function clone():Event  {
			return new GUIEvents( type );
			}
		
		public override function toString():String {
			return formatToString( "GUIEvents", "type", "bubbles", "cancelable", "eventPhase");
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