package game.utils {
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	import flash.text.Font;
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	
	import flash.filters.GlowFilter;
	
	import flash.geom.Point;
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class FloatingPopUps extends Sprite {
		private var _text				: TextField;
		private var _floatinBody		: Sprite;
		private var _floatinBodyIcon	: Sprite;
		private var _start				: Point;
		//
		public function FloatingPopUps(text:String, parent:Sprite) {
			TweenPlugin.activate([BlurFilterPlugin]);
			
			mouseEnabled = false;
			mouseChildren = false;
			var startX:int = parent.x;
			var startY:int = parent.y;
			_start = new Point(startX, startY);
			
			_floatinBody = new Sprite();
			
			var format:TextFormat = new TextFormat();
			format.color = 0xFF8040;
			format.font = "CooperBlackStd";
			format.size = 16;
			
			_text =  new TextField();
			//_text.antiAliasType = AntiAliasType.ADVANCED;
			_text.mouseEnabled = false;
			_text.defaultTextFormat = format;
			_text.x = -(parent.width / 2);
			_text.y = -10;
			_text.text = text;
			
			_floatinBody.addChild(_text);
			
			addChild(_floatinBody);
			//_floatinBody.filters = [new GlowFilter(0x000000, 1, 3, 3, 5)];
			
			
			this.x = startX + 40;
			this.y = startY;
			
			parent.addChild(this);
			
			//this.cacheAsBitmapMatrix = _text.transform.concatenatedMatrix;
			//this.cacheAsBitmap = true;
			
			//addEventListener(Event.ENTER_FRAME, onFrame);
			var tw:TweenLite = new TweenLite(_floatinBody, 1, {blurFilter:{blurX:5, blurY:5}, y:_floatinBody.y-15, alpha:0, onComplete:onTween} );
			
		}
		//
		private function onTween():void {
			parent.removeChild(this);
			}
		//
		private function onFrame (e:Event):void	{
			if (_floatinBody.y > - 20) {
				_floatinBody.y -= 2;
				_floatinBody.alpha -= .01;
				} else {
					removeEventListener(Event.ENTER_FRAME, onFrame);
					parent.removeChild(this);
					}	
			}
		//
	}
}