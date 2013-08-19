package server.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class ConncetionEvent extends Event {
		
		public static const LOGOUT		: String = "LOGOUT";
		public static const LOG_SEND	: String = "LOG_SEND";
		public static const RESPONSE	: String = "RESPONSE";
		
		private var param:EventParams;
		
		public function ConncetionEvent(type:String, _param:EventParams = null) { 
			super(type);
			param = _param;
		} 
		
		public override function clone():Event { 
			return new ConncetionEvent(type);
		} 
		
		public override function toString():String { 
			return formatToString("ConncetionEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get params():EventParams {
			return param;
			}
		/**
		* @param params
		* Параметры события: хз
		*/
		public function set params(obj:EventParams):void {
			param = obj;
			}
		
	}
	
}