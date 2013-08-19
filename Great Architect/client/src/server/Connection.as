package server {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.EventDispatcher;
	import game.user.Level;
	import game.user.User;
	import server.events.ConncetionEvent;
	import server.events.EventParams;
	
	import flash.utils.getTimer;
	
	public class Connection extends EventDispatcher {
		
		public static const LOGIN		: String = "Connect/login";
		public static const LEVEL		: String = "Connect/getLevel";
		
		private static var _instance	: Connection;
		
		private var amf					: Amf;
		
		public function Connection() {
			amf = new Amf();
			}
		//
		public static function get instance():Connection {
			if (!_instance) {
				_instance = new Connection();
				}
			return _instance;
			}
		//
		public function send(command:String, args:Object = null):void {
			//trace("call: " + command);
			switch(command) {
				case LOGIN:
					amf.toamf(command, onResponse, args.login, args.pass);
					break;
				case LEVEL:
					amf.toamf(command, onResponse, User.instance.id);
					break;
				}
			}
		//
		private function onResponse(data:String):void {
			var responseData:Object = JSON.parse(data);
			//trace("onResponse: " + String(data));
			switch(responseData.response) {
				case "login":
					User.instance.setData(responseData.data);
					dispatchEvent(new ConncetionEvent(ConncetionEvent.RESPONSE, new EventParams(EventParams.LOGIN, true, data)));
					break;
				case "getLevel":
					// TEMP
					var obj:Object = { };
					obj["id"] = 1;
					obj["gems"] = [ { gem:1, reward:1, count:100 }, { gem:2, reward:2, count:100 }, { gem:3, reward:3, count:100 } ];
					// TEMP
					//
					Level.instance.setData(obj);
					dispatchEvent(new ConncetionEvent(ConncetionEvent.RESPONSE, new EventParams(EventParams.LEVEL, true, data)));
					break;
				}
			}
		//
	}
}