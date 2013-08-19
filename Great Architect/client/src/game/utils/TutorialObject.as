package game.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class TutorialObject {
		
		public var id		: String;
		public var align	: String;
		public var offset	: int;
		public var object	: *;
		
		private var _isShow	: Boolean = false;
		
		public function TutorialObject(_id:String, _object:* = null, _align:String = "ALIGN_TOP", _Offset:int = 0) {
			id = _id;
			align = _align;
			offset = _Offset;
			//
			object = _object;
			}
		//
		public function get isShow():Boolean {
			return _isShow;
			}
		//
		public function set isShow(value:Boolean):void {
			_isShow = value;
			}
		//
	}
}