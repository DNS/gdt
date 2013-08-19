package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.utils.GUIUtils;
	
	import game.Main;
	
	import game.city.City;
	import game.gems.Gems;
	
	public class Scene extends Sprite {
		public static const GEMS:String = "gems";
		public static const CITY:String = "city";
		
		public var fixedWidth	: int = 20;
		public var fixedHeight	: int = 20;
		
		private var gemLayer	: Gems;
		private var cityLayer	: City;
		
		private var curScene	: * = null;
		
		public function Scene() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			fixedWidth = parent.stage.stageWidth;
			fixedHeight = parent.stage.stageHeight;
			//
			gemLayer = new Gems();
			addChild(gemLayer);
			GUIUtils.setPosition(gemLayer, gemLayer.align, gemLayer.topPadding);
			//
			cityLayer = new City();
			addChild(cityLayer);
			//GUIUtils.setPosition(cityLayer, cityLayer.align);
			//
			EventManager.instance.addEventListener(GameEvent.SCENE_EVENT, onEvent);
			}
		//
		private function onEvent(e:GameEvent):void {
			setScene(e.params.target);
			}
		//
		private function setScene(sceneName:String):void {
			if (curScene != null) { curScene.close(); }
			
			switch(sceneName) {
				case GEMS:
					gemLayer.open();
					curScene = gemLayer;
					GUIUtils.setPosition(curScene, curScene.align, gemLayer.topPadding);
					break;
				case CITY:
					cityLayer.open();
					curScene = cityLayer;
					break;
				}
			}
		//
		public function onResize():void {
			fixedWidth = parent.stage.stageWidth;
			fixedHeight = parent.stage.stageHeight;
			//
			GUIUtils.setPosition(gemLayer, gemLayer.align, gemLayer.topPadding);
			cityLayer.onResize();
			}
	}
}