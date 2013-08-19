package game.gems {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class BaseGem extends Sprite	
	{	
		public var col:int;
		public var row:int;
		
		public var currentGem			:Sprite = new Sprite();
		public var type					:int;
		private var locked				:Boolean = false;
		private var canMove				:Boolean = true;
		
		public static const TYPE_1:String = "clipName";
		//
		public function BaseGem() 
		{
			
		}
		//
		public function init(_type:int, _col:int, _row:int):void 
		{
			col = _col;
			row = _row;
			// add clip by name
			type = _type;
			
			if (canMove == false) 
			{
				currentGem.addChild(new Bitmap(new GemWall()));
				addChild(currentGem);
				currentGem.width = currentGem.height = 64;
				return;
			}
			
			switch(type) 
			{
				case 1:
					currentGem.addChild(new Bitmap(new Gem1()));
					break;
				case 2:
					currentGem.addChild(new Bitmap(new Gem2()));
					break;
				case 3:
					currentGem.addChild(new Bitmap(new Gem3()));
					break;
				case 4:
					currentGem.addChild(new Bitmap(new Gem4()));
					break;
				case 5:
					currentGem.addChild(new Bitmap(new Gem5()));
					break;
			}
			addChild(currentGem);
			currentGem.width = currentGem.height = 64;
		}
		//
		public function select(val:Boolean = false):void 
		{
			if (val)
				filters = [new DropShadowFilter(0, 0, 0xFFFFFF, 1, 20, 20, 2)];
			else
				filters = [];
		}
		//
		public function unchained():void
		{
			locked = false;
			currentGem.removeChildAt(1);
		}
		//
		public function chained():void
		{
			locked = true;
			currentGem.addChild(new Bitmap(new GemLock()));
		}
		//
		public function get isLocked():Boolean { return locked; }
		
		public function get isWall():Boolean { return !canMove; }
		public function set isWall(value:Boolean):void { canMove = !value; }
		
		
		
		
	}
}