package game.user {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class Level {
		
		private static var _instance	: Level;
		
		public static var id:int = 0;
		public static var gems:Array = [];// [{gem:1, reward:1, count:100}, {gem:2, reward:2, count:100}, {gem:3, reward:3, count:100}]
		
		public function Level() {
			
			}
		//
		public static function get instance():Level {
			if (!_instance) {
				_instance = new Level();
				}
			return _instance;
			}
		//
		public function setData(data:Object):void {
			for (var field:String in data) {
				this[field] = data[field];	
				}
			}
		//
	}
}