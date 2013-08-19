package gdt.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class EventsManager extends EventDispatcher {
		
		private static var instance:EventsManager;
		
		public function EventsManager() {
			super();
			}
		//
		public static function getInstance():EventsManager {
			if (instance == null) {
				instance = new EventsManager();
				}
			return instance;
			}
		//
		public override function dispatchEvent (event:Event):Boolean {
			return super.dispatchEvent(event);
			}
	}
}