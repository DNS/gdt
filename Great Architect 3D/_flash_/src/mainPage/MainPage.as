package mainPage {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import gui.Preloader;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import feathers.themes.GATheme;
	
	import gui.BottomGui;
	
	public class MainPage extends Sprite {
		
		private var theme:GATheme;
		
		private var _preloader:Preloader;
		
		private var _bottom:BottomGui;
		
		public function MainPage() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			theme = new GATheme(stage, false);
			//
			_preloader = new Preloader();
			addChild(_preloader);
			//
			}
		//
		public function onLoaded():void {
			removeChild(_preloader);
			//
			addGUI();
			}
		//
		private function addGUI():void {
			_bottom = new BottomGui();
			_bottom.y = stage.stageHeight - _bottom.fixedHeight;
			addChild(_bottom);
			}
	}
}