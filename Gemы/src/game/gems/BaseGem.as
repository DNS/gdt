package game.gems {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import main.Main;
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class BaseGem extends Sprite	{
		
		private var numPieces:uint = 7;
		private var spacing:Number = 60;
		private var offsetX:Number = 65;
		private var offsetY:Number = 65;
		
		public var col:int;
		public var row:int;
		
		public var currentGem			:MovieClip;
		public var type					:int;
		public var locked				:Boolean = false;
		public var moving				:Boolean = false;
		
		public static const TYPE_1:String = "clipName";
		//
		public function BaseGem() {
			
			}
		//
		public function init(_type:int, _col:int, _row:int):void {
			col = _col;
			row = _row;
			// add clip by name
			type = _type;
			switch(type) {
				case 1:
					currentGem = new gem1() as MovieClip;
					break;
				case 2:
					currentGem = new gem2() as MovieClip;
					break;
				case 3:
					currentGem = new gem3() as MovieClip;
					break;
				case 4:
					currentGem = new gem4() as MovieClip;
					break;
				case 5:
					currentGem = new gem5() as MovieClip;
					break;
				/*case 6:
					currentGem = new gem1() as MovieClip;
					break;
				case 7:
					currentGem = new gem1() as MovieClip;
					break;*/
				}
			addChild(currentGem);
			currentGem.width = Main.getInstance().gemSize;
			currentGem.height = Main.getInstance().gemSize;
			currentGem.gotoAndStop(0);
			//
			currentGem.cacheAsBitmap = true;
			}
		//
		public function select(val:Boolean = false):void {
			if (val) {
				filters = [new DropShadowFilter(0, 0, 0xFFFFFF, 1, 20, 20, 2)];
				}else {
					filters = [];
					}
			}
	}

}