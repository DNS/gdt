package {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import com.greensock.TweenMax;
	
	public class Score extends Sprite {
		public var tempScore:int = 0;
		public var curScore:int = 0;
		
		private var _text:TextField;
		private var _tween:TweenMax;
		
		public function Score() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat("Arial", 24, 0xFF0000, true);
			_text.autoSize = TextFieldAutoSize.CENTER;
			_text.mouseEnabled = false;
			_text.selectable = false;
			_text.text = "Score: 0";
			_text.x = -_text.width / 2;
			addChild(_text);
			}
		//
		public function addScore(val:int):void {
			curScore = curScore + val;
			_tween = new TweenMax(this, 0.5, { tempScore:curScore, onUpdate:updateScore } );
			}
		//
		private function updateScore():void {
			_text.text = "Score: " + tempScore;
			}
	}
}