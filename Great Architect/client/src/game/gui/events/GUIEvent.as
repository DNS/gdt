package game.gui.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class GUIEvent extends Event {
		
		public static const POPUP_OPEN	: String = "popup_open";
		public static const POPUP_CLOSE	: String = "popup_close";
		
		private var paramsObject:Object = null;
		
		public function GUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			} 
		//
		public function set params(value:Object):void {
			paramsObject = value;
			}
		//
		public function get params():Object {
			return paramsObject;
			}
		//
		public override function clone():Event { 
			return new GUIEvent(type, bubbles, cancelable);
			} 
		//
		public override function toString():String { 
			return formatToString("GUIEvent", "type", "bubbles", "cancelable", "eventPhase"); 
			}
		//
	}
	
}