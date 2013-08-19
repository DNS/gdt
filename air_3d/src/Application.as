package {
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	
	import flash.events.Event;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	//
	import gdt.events.EventsManager;
	import gdt.events.AssetsManagerEvents;
	
	import gdt.controllers.Controller;
	
	import gdt.gui.GUI;
	import gdt.gui.GUIStage;
	import gdt.gui.windows.MainWindow;
	//
	import gdt.assets.AssetsManager;
	import gdt.utils.SystemUtils;
	//
	import game.GameStage;
	
	import gdt.gui.debug.Debug;
	import com.junkbyte.console.Cc;
	import net.hires.debug.Stats;
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	public class Application extends Sprite {
		
		public static var assets	: AssetsManager;
		
		private var _controller			: Controller = new Controller();
		
		private static var _debugStage	: Debug;
		private static var _guiStage	: GUIStage = new GUIStage();
		private static var _game		: GameStage;
		
		public function Application():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			new EventsManager();
			
			// активы
			assets = new AssetsManager(AssetsManager.DESKTOP);
			EventsManager.getInstance().addEventListener(AssetsManagerEvents.ALL_ASSETS_LOADED, onLoaded);
			EventsManager.getInstance().addEventListener(AssetsManagerEvents.ASSETS_NEED_LOADED, loadAssets);
			//assets.init();
			
			// add layers
			// TODO:  add 3d layear;
			addChild(_guiStage);
			
			// init GUI
			GUI.getInstance().setStage(_guiStage.stage);
			
			_debugStage = new Debug();
			addChild(_debugStage);
			
			_controller.debug = true;
			//_controller.inputType = Controller.DESKTOP;
			_controller.inputType = Controller.TOUCH;
			_controller.init();
			
			// Debug
			//addConsole();
			SystemUtils.GCTimer();
			
			//
			// add game stage
			//_game = new GameStage(stage);
			
			// главное окно
			//_game.init();
			//_game.startGame();
			//
			}
			
		// загрузка активов
		private function loadAssets(e:AssetsManagerEvents):void {
			trace("loadAssets: " + e);
			//GUI.showWindow(GUI.LOAD_WINDOW);
			//assets.load();
			}
		
		// старт игры
		private function onLoaded(e:AssetsManagerEvents):void {
			EventsManager.getInstance().removeEventListener(AssetsManagerEvents.ASSETS_NEED_LOADED, loadAssets);
			EventsManager.getInstance().removeEventListener(AssetsManagerEvents.ALL_ASSETS_LOADED, onLoaded);
			
			// add game stage
			_game = new GameStage(stage);
			
			// главное окно
			_game.init();
			_game.startGame();
			//GUI.showWindow(MainWindow);
			}
		//
		public static function get game():GameStage { return _game ? _game : null; }
		public static function get gui():GUIStage { return _guiStage ? _guiStage : null; }
		public static function get debug():Sprite {	return _debugStage;	}
		//
		private function deactivate(e:Event):void {
			// auto-close
			NativeApplication.nativeApplication.exit();
			}
		//
		public static function addLog(text:*):void {
			if (_debugStage) {
				_debugStage.addLog(text);
				}
			}
		//
		private function addConsole():void {
			Cc.startOnStage(this, "");
			Cc.memoryMonitor = true;
			Cc.fpsMonitor = true;
			}
	}
}