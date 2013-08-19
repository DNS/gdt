package {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import assets.events.AssetsEvent;
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import city.City;
	import gems.Gems;
	import mainPage.MainPage;
	
	import assets.Assets;
	
	import starling.core.Starling;
	
	public class Main extends Sprite {
		
		private var loaded		: Boolean = false;
		
		private var stage3D		: Stage3D;
		
		private var _starling	: Starling;
		private var _city		: City;
		private var _gems		: Gems;
		
		public function Main():void {
			//MonsterDebugger.initialize(this);
			//
			if (stage) {
				init(); 
				} else { 
					addEventListener(Event.ADDED_TO_STAGE, init);
					}
			}
		//
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//
			initStage3d();
			}
		//
		private function initStage3d():void {
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
			stage3D.requestContext3D();
			}
		//
		private function onContextCreate(e:Event):void {
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
			stage3D.context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, true, true);
			//
			Assets.instance.init(stage3D);
			Assets.instance.addEventListener(AssetsEvent.MODELS_LOADED, onModelsReady);
			Assets.instance.load();
			//
			_city = new City(stage3D);
			addChild(_city);
			//
			_gems = new Gems(stage3D);
			addChild(_gems);
			//
			_starling = new Starling(MainPage, stage, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight), stage3D);
			_starling.antiAliasing = 4;
			_starling.showStats = true;
			_starling.start();
			//
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		//
		private function onModelsReady(e:AssetsEvent):void {
			(_starling.root as MainPage).onLoaded();
			loaded = true;
			}
		//
		private function onEnterFrame(e:Event):void {
			stage3D.context3D.clear();
			//
			if (loaded) {
				if (_city != null && _city.ready == true) {
					_city.renderEvent();
					}
				//
				if (_gems != null) {
					_gems.renderEvent();
					}
				}
			//
			_starling.nextFrame();
			//
			stage3D.context3D.present();
			}
		//
	}
}