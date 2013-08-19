package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.Main;
	import game.utils.GUIUtils;
	
	public class Gui extends Sprite {
		
		public var align	: String = GUIUtils.ALIGN_BOTTOM_CENTER;
		
		private var bg		: Sprite;
		
		public function Gui() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			bg = new Sprite();
			bg.graphics.beginFill(0x000000, 0.7);
			bg.graphics.drawRect(0, 0, parent.stage.stageWidth, 100);
			bg.graphics.endFill();
			addChild(bg);
			
			GUIUtils.setPosition(this, align);
			//
			var testBut:BaseButton = new BaseButton("Open FB", openPop);
			testBut.tutorialAction("FacebookPoup");
			addChild(testBut);
			GUIUtils.setPosition(testBut, GUIUtils.ALIGN_TOP_LEFT, 10);
			
			var testList:BaseButton = new BaseButton("     List     ", openList);
			testList.tutorialAction("List");
			addChild(testList);
			GUIUtils.setPosition(testList, GUIUtils.ALIGN_TOP_LEFT, 10);
			testList.y = testBut.y + testBut.height + 10;
			
			var testGem:BaseButton = new BaseButton("Gems", openGem);
			testGem.tutorialAction("Gems");
			addChild(testGem);
			GUIUtils.setPosition(testGem, GUIUtils.ALIGN_TOP_LEFT, 10);
			testGem.x = testBut.x + testBut.width + 10;
			
			var testAlert:BaseButton = new BaseButton("     Alert     ", openAlert);
			addChild(testAlert);
			GUIUtils.setPosition(testAlert, GUIUtils.ALIGN_TOP_LEFT, 10);
			testAlert.x = testBut.x + testBut.width + 10;
			testAlert.y = testBut.y + testBut.height + 10;
			
			var testCity:BaseButton = new BaseButton("City", openCity);
			addChild(testCity);
			GUIUtils.setPosition(testCity, GUIUtils.ALIGN_TOP_LEFT, 10);
			testCity.x = testGem.x + testGem.width + 10;
			
			var toPoint:BaseButton = new BaseButton("Random Point", toRandomPoint);
			addChild(toPoint);
			GUIUtils.setPosition(toPoint, GUIUtils.ALIGN_TOP_RIGHT, 10);
			
			var toFull:BaseButton = new BaseButton("Fullscreen", toFullScreen);
			addChild(toFull);
			GUIUtils.setPosition(toFull, GUIUtils.ALIGN_TOP_RIGHT, 10);
			toFull.y = toPoint.y + toPoint.height + 10;
			
			var res1:BaseButton = new BaseButton("add random res", addRandom);
			addChild(res1);
			GUIUtils.setPosition(res1, GUIUtils.ALIGN_CENTER, 10);
			}
		//
		private function openAlert():void {
			Alert.instance.showAlert([Alert.ALERT_YES, Alert.ALERT_NO], randomText(int(Math.random() * 10 + 1)), randomText(int(Math.random() * 100 + 10)), alertBack);
			}
		private function randomText(strlen:int):String {
			var chars:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			var num_chars:Number = chars.length - 1;
			var randomChar:String = "";
			
			for (var i:Number = 0; i < strlen; i++){
				randomChar += chars.charAt(Math.floor(Math.random() * num_chars));
				}
			return randomChar;
			}
		//
		private function alertBack(type:String):void {
			trace("Alert back: " + type);
			}
		//
		private function addRandom():void {
			var add:GameEvent = new GameEvent(GameEvent.GEMS_ADD_RES, new EventParams(EventParams.ADD_RES, "add_res", { res1:(int(Math.random() * 100)), res2:(int(Math.random() * 100)), res3:(int(Math.random() * 100)) } ));
			EventManager.instance.dispatchEvent(add);
			}
		//
		private function toFullScreen():void {
			if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				return;
				}
			if (stage.displayState == StageDisplayState.FULL_SCREEN || stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) {
				stage.displayState = StageDisplayState.NORMAL;
				}
			}
		//
		private function toRandomPoint():void {
			EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CITY_TO_POINT));
			}
		//
		private function openCity():void {
			EventManager.instance.switchScene(Scene.CITY);
			}
		//
		private function openGem():void {
			EventManager.instance.switchScene(Scene.GEMS);
			}
		//
		private function openPop():void {
			PopupManager.instance.showPopUp(PopUpEnum.POPUP_FB);
			}
		//
		private function openList():void {
			PopupManager.instance.showPopUp(PopUpEnum.POPUP_TEST);
			}
		//
		public function onResize():void {
			GUIUtils.setPosition(this, align);
			}
	}
}