package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.events.EventManager;
	import game.events.GameEvent;
	import game.utils.GUIUtils;
	
	public class TopGui extends Sprite {
		
		public var align	: String = GUIUtils.ALIGN_TOP_CENTER;
		
		private var bg		: Sprite;
		
		private var format	: Object = GUIUtils.tfFormat(GUIUtils.MyriadProBoldFont, 0xFFFFFF, 14, GUIUtils.AUTOSIZE_LEFT, GUIUtils.TEXT_ALIGN_CENTER, true);
		private var res1	: Bitmap;
		private var res2	: Bitmap;
		private var res3	: Bitmap;
		
		private var res1val	: int = 00000;
		private var res2val	: int = 00000;
		private var res3val	: int = 00000;
		
		private var lastX	: int = 0;
		
		public function TopGui() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 0.7);
			bg.graphics.drawRect(0, 0, parent.stage.stageWidth, 30);
			bg.graphics.endFill();
			addChild(bg);
			
			GUIUtils.setPosition(this, align);
			//
			res1 = GUIUtils.createBitmapTF("res1: 00000", format, GUIUtils.getFilters([0]));
			addChild(res1);
			GUIUtils.setPosition(res1, GUIUtils.ALIGN_LEFT_CENTER, 10);
			
			lastX = res1.x + res1.width + 10;
			
			res2 = GUIUtils.createBitmapTF("res2: 00000", format, GUIUtils.getFilters([0]));
			addChild(res2);
			GUIUtils.setPosition(res2, GUIUtils.ALIGN_LEFT_CENTER, 10);
			res2.x = lastX;
			
			lastX = res2.x + res2.width + 10;
			
			res3 = GUIUtils.createBitmapTF("res3: 00000", format, GUIUtils.getFilters([0]));
			addChild(res3);
			GUIUtils.setPosition(res3, GUIUtils.ALIGN_LEFT_CENTER, 10);
			res3.x = lastX;
			//
			EventManager.instance.addEventListener(GameEvent.GEMS_ADD_RES, onAddedRes);
			}
		
		private function onAddedRes(e:GameEvent):void {
			res1val += e.params.params.res1;
			res1.bitmapData = GUIUtils.createBitmapTF("res1: " + toFormat(res1val), format, GUIUtils.getFilters([0])).bitmapData;
			
			res2val += e.params.params.res2;
			res2.bitmapData = GUIUtils.createBitmapTF("res2: " + toFormat(res2val), format, GUIUtils.getFilters([0])).bitmapData;
			
			res3val += e.params.params.res3;
			res3.bitmapData = GUIUtils.createBitmapTF("res3: " + toFormat(res3val), format, GUIUtils.getFilters([0])).bitmapData;
			}
		//
		private function toFormat(val:int):String {
			if (val < 10) {
				return "0000" + val;
				}
			if (val < 100) {
				return "000" + val;
				}
			if (val < 1000) {
				return "00" + val;
				}
			if (val < 10000) {
				return "0" + val;
				}
			return String(val);
			}
		//
		public function onResize():void {
			GUIUtils.setPosition(this, align);
			}
	}
}