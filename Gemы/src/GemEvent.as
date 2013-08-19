package {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	
	public class GemEvent extends Event {
		public static const GEM_SWAP_COMPLETE	: String = "gem_swap_complete";
		public static const GEM_DROP_COMPLETE	: String = "gem_drop_complete";
		
		private var _gem:BaseGem;
		
		public function GemEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(type, bubbles, cancelable);
			} 
		
		public override function clone():Event { 
			return new GemEvent(type, bubbles, cancelable);
			} 
		
		public override function toString():String { 
			return formatToString("GemEvent", "type", "bubbles", "cancelable", "eventPhase"); 
			}
			
		public function get gem():BaseGem {
			return _gem;
			}
			
		public function set gem(value:BaseGem):void {
			_gem = value;
			}
		
	}
	
}