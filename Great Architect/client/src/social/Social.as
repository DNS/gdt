package social {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	//import src.remoting.objects.UserObj;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Social {
		
		public static const FACEBOOK	: String = "facebook";
		
		private static var _instance	: Social;
		
		public static var currentNetwork: String = "";
		
		private static var socialNetwork: *;
		
		public function Social() {
			
			}
		//
		public static function get instance():Social {
			if (!_instance) {
				_instance = new Social();
				}
			return _instance;
			}
		//
		public function init(network:String, AppID:String):void {
			if (!ExternalInterface.available) {
				return;
				}
			
			currentNetwork = network;
			switch(network) {
				case FACEBOOK:
					socialNetwork = new FacebookAPI();
					(socialNetwork as FacebookAPI).addEventListener("onInit", onNetworkInit);
					(socialNetwork as FacebookAPI).init(AppID);
					break;
				}
			}
		//
		private function onNetworkInit():void {
			(socialNetwork as EventDispatcher).removeEventListener("onInit", onNetworkInit);
			//
			MonsterDebugger.trace(this, "onNetworkInit", "Danil", "----");
			}
		//
		public static function get userId():String {
			switch(currentNetwork) {
				case FACEBOOK:
					return FacebookAPI.FACEBOOK_ID;
					break;
				}
			return "";
			}
		//
		public function savePhoto(st:Stage):void {
			(socialNetwork as FacebookAPI).save(st);
			}
		//
		public function appreq():void {
			(socialNetwork as FacebookAPI).requestUI();
			}
		//
		public function PostToWall(users:*, type:String, UI:Boolean = true, args:Array = null):void {
			switch(currentNetwork) {
				case FACEBOOK:
					(socialNetwork as FacebookAPI).wallPost(type, users, UI, args);
					break;
				}
			
			}
	}
}