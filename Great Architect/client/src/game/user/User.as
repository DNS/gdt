package game.user {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	public class User {
		
		private static var _instance	: User;
		
		public var id		: int = 0;
		public var name		: String = "";
		public var level	: int = 0;
		
		public function User() {
			
			}
		//
		public static function get instance():User {
			if (!_instance) {
				_instance = new User();
				}
			return _instance;
			}
		//
		public function setData(data:Object):void {
			for (var field:String in data) {
				this[field] = data[field];	
				}
			}
	}
}