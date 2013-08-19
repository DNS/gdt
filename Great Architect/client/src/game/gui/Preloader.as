package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import game.events.EventManager;
	import game.events.GameEvent;
	
	import game.utils.GUIUtils;
	
	public class Preloader extends Sprite {
		
		private var bg:Sprite;
		private var text:Bitmap;
		
		public function Preloader() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			bg = new Sprite();
			bg.graphics.beginFill(0x371C00);
			bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			addChild(bg);
			//
			text = GUIUtils.createBitmapTF("Loading... 0%", GUIUtils.tfFormat(GUIUtils.MyriadProBoldFont, 0xFF8040, 24, GUIUtils.AUTOSIZE_LEFT, GUIUtils.TEXT_ALIGN_CENTER, true), GUIUtils.getFilters([1,0]));
			addChild(text);
			GUIUtils.setPosition(text, GUIUtils.ALIGN_CENTER);
			//
			EventManager.instance.addEventListener(GameEvent.LOADER_PROGRESS, onProgress);
			}
		//
		private function onProgress(e:GameEvent):void {
			var progress:String = Math.round(Number(e.params.target) * 100) + "%";
			text.bitmapData = GUIUtils.createBitmapTF("Loading... " + progress, GUIUtils.tfFormat(GUIUtils.MyriadProBoldFont, 0xFF8040, 24, GUIUtils.AUTOSIZE_LEFT, GUIUtils.TEXT_ALIGN_CENTER, true), GUIUtils.getFilters([1, 0])).bitmapData;
			}
		//
		public function remove():void {
			EventManager.instance.removeEventListener(GameEvent.LOADER_PROGRESS, onProgress);
			removeChild(bg);
			text.bitmapData.dispose();
			removeChild(text);
			parent.removeChild(this);
			//
			}
	}
}