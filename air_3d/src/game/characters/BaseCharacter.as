package game.characters {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import gdt.assets.Asset;
	
	public class BaseCharacter {
		public static const DYNAMIC	: String = "dynamic"; // with animation
		public static const STATIC	: String = "static"; // without animation
		
		public var asset	: Asset;
		
		public var health	: int = 0;
		public var enemy	: Boolean = false;
		
		public function BaseCharacter() {
			
			}
		//
		public function init(_asset:Asset):void {
			//asset = _asset;
			//
			}
	}
}