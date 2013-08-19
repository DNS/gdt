package server.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class EventParams extends Object {
		public static const LOGIN			: String = "LOGIN";
		public static const LEVEL			: String = "LEVEL";
		public static const CONFIG			: String = "CONFIG";
		
		public var type		: String = "";
		public var result	: Boolean = false;
		public var data		: * = null;
		
		public function EventParams(_type:String = null, _result:Boolean = false, _data:* = null) {
			type = _type;
			result = _result;
			data = _data;
			}
		//
	}
}