package game {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.system.Security;
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.gui.Alert;
	import game.gui.TopGui;
	import game.gui.Tutorial;
	import loader.LoadManager;
	
	import game.gui.Scene;
	import game.gui.PopUpEnum;
	import game.gui.PopupManager;
	import game.gui.Preloader;
	import game.gui.Gui;
	
	import game.utils.GUIUtils;
	import game.utils.GlobalInstance;
	
	import server.events.ConncetionEvent;
	import server.Connection;
	
	import social.Social;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Main extends Sprite {
		
		private var loadManager		: LoadManager;
		
		private var alertLayer		: Sprite;
		private var popLayer		: Sprite;
		private var sceneLayer		: Scene;
		private var topGuiLayer		: TopGui;
		private var guiLayer		: Gui;
		private var preloader		: Preloader;
		
		private var tutorLayer		: Sprite;
		
		public function Main():void {
			MonsterDebugger.initialize(this);
			
			if (stage) {
				init();
				} else { 
					addEventListener(Event.ADDED_TO_STAGE, init);
					}
			}
		//
		private function init(e:Event = null):void {
			GlobalInstance.instance.MainStage = stage;
			//
			MonsterDebugger.trace(this, this.loaderInfo.parameters, "Danil", "_flashVars_", 0xA4A400);
			//
			Social.instance.init(Social.FACEBOOK, this.loaderInfo.parameters.app_id);
			//
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			sceneLayer = new Scene();
			addChild(sceneLayer);
			//
			topGuiLayer = new TopGui();
			addChild(topGuiLayer);
			//
			guiLayer = new Gui();
			addChild(guiLayer);
			//
			popLayer = new Sprite();
			addChild(popLayer);
			PopupManager.instance.stageLayer(popLayer);
			//
			alertLayer = new Sprite();
			addChild(alertLayer);
			Alert.instance.stageLayer(alertLayer);
			//
			preloader = new Preloader();
			addChild(preloader);
			//
			tutorLayer = new Sprite();
			addChild(tutorLayer);
			Tutorial.instance.stageLayer(tutorLayer);
			//
			EventManager.instance.addEventListener(GameEvent.CITYBG_LOADED, startGame);
			LoadManager.instance.loadAll();
			}
		//
		private function startGame(e:GameEvent):void {
			EventManager.instance.removeEventListener(GameEvent.CITYBG_LOADED, startGame);
			//
			preloader.remove();
			//
			stage.addEventListener(Event.RESIZE, onResize);
			//stage.addEventListener(FullScreenEvent.FULL_SCREEN, onResize);
			//
			//Connection.instance.addEventListener(ConncetionEvent.RESPONSE, onServer);
			//Connection.instance.send(Connection.LOGIN, { login:"Name", pass:"pass" } );
			//
			Tutorial.instance.addActions("FacebookPoup,CloseFBPopUp,List,Gems");
			Tutorial.instance.startActions();
			}
		//
		private function onResize(e:*):void { resize(); }
		//
		private function resize():void {
			PopupManager.instance.onResize();
			Alert.instance.onResize();
			
			var i:int;
			while (i < numChildren) {
				if (getChildAt(i) is Gui) {
					(getChildAt(i) as Gui).onResize();
					}
				if (getChildAt(i) is TopGui) {
					(getChildAt(i) as TopGui).onResize();
					}
				if (getChildAt(i) is Scene) {
					(getChildAt(i) as Scene).onResize();
					}
				i++;
				}
			}
		//
		private function onServer(e:ConncetionEvent):void {
			trace("from server > result: " + e.params.result + ", data" + e.params.data);
			}
		//
	}
}