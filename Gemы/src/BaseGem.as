package {
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Quad;
	
	public class BaseGem extends Sprite	{
		private var _tween		: TweenMax;
		private var speed		: Number = 1;// 0.3;
		private var gemBitmap	: Bitmap;
		
		public var isMoving		: Boolean = false;
		public var isMatch		: Boolean = false;
		public var isDropping	: Boolean = false;
		public var isSwapping	: Boolean = false;
		
		public var type			: String;
		public var col			: int;
		public var row			: int;
		
		public function BaseGem() {
			//
			}
		//
		public function init(_type:String, _col:int, _row:int, drop:Boolean = false):void {
			type = _type;
			col = _col;
			row = _row;
			
			x = col * Main.spacing + Main.offsetX;
			y = drop ? -(row * Main.spacing + Main.offsetY) : (row * Main.spacing + Main.offsetY);
			
			gemBitmap = new Bitmap(null, PixelSnapping.ALWAYS);
			
			switch(type) {
				case "1":
					gemBitmap.bitmapData = new Gem1();
					break;
				case "2":
					gemBitmap.bitmapData = new Gem2();
					break;
				case "3":
					gemBitmap.bitmapData = new Gem3();
					break;
				case "4":
					gemBitmap.bitmapData = new Gem4();
					break;
				}
			//
			addChild(gemBitmap);
			//
			if (drop) {
				move(col, row, false, true);
				}
			}
		//
		public function selected(val:Boolean):void {
			if (val) {
				filters = [new DropShadowFilter(0, 0, 0xFFFFFF, 1, 20, 20, 2)];
				}else {
					filters = [];
					}
			}
		//
		public function move(_col:int, _row:int, swap:Boolean = false, drop:Boolean = false):void {
			mouseEnabled = false;
			
			isSwapping = swap;
			isDropping = drop;
			
			col = _col;
			row = _row;
			
			var tweenProps:Object = new Object();
			tweenProps.x = (_col * Main.spacing + Main.offsetX);
			tweenProps.y = (_row * Main.spacing + Main.offsetY);
			tweenProps.ease = Quad.easeOut;
			//tweenProps.delay = drop ? 1 : 0;
			tweenProps.onComplete = moveEnd;
			tweenProps.onCompleteParams = [ { newCol:_col, newRow:_row } ];
			
			_tween = new TweenMax(this, speed, tweenProps );
			}
		//
		private function moveEnd(params:Object):void {
			mouseEnabled = true;
			
			var event:GemEvent;
			if (isSwapping) {
				event = new GemEvent(GemEvent.GEM_SWAP_COMPLETE);
				event.gem = this;
				dispatchEvent(event);
				}
			
			if (isDropping) {
				event = new GemEvent(GemEvent.GEM_DROP_COMPLETE);
				event.gem = this;
				dispatchEvent(event);
				}
			
			isDropping = false;
			isSwapping = false;
			}
		//
		public function noMatchAnim(_col:int, _row:int):void {
			var tweenProps:Object = new Object();
			tweenProps.x = (_col * Main.spacing + Main.offsetX);
			tweenProps.y = (_row * Main.spacing + Main.offsetY);
			tweenProps.ease = Quad.easeOut;
			tweenProps.repeat = 1;
			tweenProps.yoyo = true;
			_tween = new TweenMax(this, speed, tweenProps );
			}
		//
		public function destroy(n:int):void {
			if (_tween) { _tween.kill(); _tween = null; }
			
			var tweenProps:Object = new Object();
			tweenProps.x = (stage.stageWidth / 2) - (this.width / 2);
			tweenProps.y = (8 * Main.spacing + Main.offsetY);
			tweenProps.ease = Quad.easeOut;
			tweenProps.scaleX = 0.3;
			tweenProps.scaleY = 0.3;
			tweenProps.alpha = 0;
			tweenProps.delay = n / 50;
			tweenProps.onComplete = destroyEnd;
			
			_tween = new TweenMax(this, speed, tweenProps );
			
			function destroyEnd():void {
				if (_tween) { _tween.kill(); _tween = null; }
				
				if (gemBitmap && gemBitmap.bitmapData) {
					gemBitmap.bitmapData.dispose();
					removeChild(gemBitmap);
					gemBitmap = null;
					}
				
				if (this.parent) {
					this.parent.removeChild(this);
					}
				}
			}
		//
		public function getProps():String {
			return "gem > col: " + col + ", row: " + row + ", type: " + type + ", isMatch: " + isMatch;
			}
	}
}