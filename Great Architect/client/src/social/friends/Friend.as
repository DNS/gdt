package social.friends {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	
	public class Friend {
		
		public var id:String;
		public var name:String;
		public var installed:Boolean = false;
		public var picture:Object;
		
		public function Friend(data:Object) {
			for (var field:* in data) {
				this[field] = data[field];
				}
			}
		//
	}
}