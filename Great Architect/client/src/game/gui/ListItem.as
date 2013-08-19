package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ListItem extends Sprite {
		
		private var bg:Sprite;
		
		public function ListItem() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			bg = new Sprite();
			bg.graphics.beginFill(Math.random() * 0xFFFFFF);
			bg.graphics.drawRoundRect(0, 0, 300, 50, 5, 5);
			bg.graphics.endFill();
			addChild(bg);
			}
		//
	}
}