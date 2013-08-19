package game.gems {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import game.utils.GUIUtils;
	
	public class Gems extends Sprite {
		
		public var align:String = GUIUtils.ALIGN_TOP_CENTER;
		public var topPadding:int = 40;
		
		private var match_three:MatchThree;
		
		public function Gems() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			match_three = new MatchThree();
			addChild(match_three);
			match_three.startMatchThree();

			visible = false;
		}
		//
		public function open():void {
			visible = true;
		}
		//
		public function close():void {
			visible = false;
		}
	}

}