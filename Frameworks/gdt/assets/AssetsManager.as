package gdt.assets {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.greensock.events.LoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import gdt.events.AssetsManagerEvents;
	import flash.utils.getTimer;
	
	import gdt.events.EventsManager;
	import gdt.assets.Asset;
	
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.BinaryDataLoader;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.core.LoaderItem;
	
	public class AssetsManager extends EventDispatcher {
		public static const DESKTOP		: String = "desktop";
		public static const ANDROID		: String = "ANDROID";
		public static const ANDROID_TAB	: String = "ANDROID_TAB";
		public static const IOS_PHONE	: String = "IOS_PHONE";
		public static const IOS_TAB		: String = "IOS_TAB";
		
		private var loader:LoaderMax;
		
		[Embed(source="../../../lib/assets/Assets.xml", mimeType="application/octet-stream")]
		protected const EmbeddedXML:Class;
		
		private static var platform		: String;
		
		private static var guiAssets	: Vector.<Asset> = new Vector.<Asset>();
		private static var gameLevels	: Vector.<Asset> = new Vector.<Asset>();
		private static var gameAssets	: Vector.<Asset> = new Vector.<Asset>();
		
		private static var assetDic:Dictionary = new Dictionary();
		
		public function AssetsManager(_platform:String, debug:Boolean = false) {
			platform = _platform;
			//
			loader = new LoaderMax();
			loader.skipPaused = true;
			
			LoaderMax.activate([BinaryDataLoader, ImageLoader, SWFLoader]);
			
			loader.autoLoad = false;
			//
			parseXML();
			//
			if (debug) {
				
				}
			}
		//
		public static function get getPlatform():String {
			return platform;
			}
		//
		private function parseXML():void {
			var byteArray:ByteArray = new EmbeddedXML() as ByteArray;
			var _xml:XMLList = new XMLList(byteArray.readUTFBytes(byteArray.length));
			
			var a:int;
			var _asset:Asset;
			var _data:Object;
			for (a = 0; a < _xml[platform].gui.asset.length(); a++ ) {// GUI
				_data = new Object();
				_data.path = _xml[platform].gui.asset[a].@path;
				_data.type = _xml[platform].gui.asset[a].@type;
				_data.name = _xml[platform].gui.asset[a].@name;
				
				_asset = new Asset(_data);
				loader.append(_asset.getLoader());
				guiAssets.push(_asset);
				assetDic[_asset.name] = _asset;
				}
			//
			for (a = 0; a < _xml[platform].levels.level.length(); a++ ) {// Levels
				_data = new Object();
				_data.path = _xml[platform].levels.level[a].@path;
				_data.type = _xml[platform].levels.level[a].@type;
				_data.name = _xml[platform].levels.level[a].@name;
				
				_asset = new Asset(_data);
				loader.append(_asset.getLoader());
				gameLevels.push(_asset);
				assetDic[_asset.name] = _asset;
				}
			//
			for (a = 0; a < _xml[platform].game.asset.length(); a++ ) {// Game
				_data = new Object();
				_data.path = _xml[platform].game.asset[a].@path;
				_data.type = _xml[platform].game.asset[a].@type;
				_data.name = _xml[platform].game.asset[a].@name;
				
				_asset = new Asset(_data);
				loader.append(_asset.getLoader());
				gameAssets.push(_asset);
				assetDic[_asset.name] = _asset;
				}
			//
			//loader.load();
			}
		//
		public function init():void {
			var assetsReady:int = 0;
			
			var a:int;
			for (a = 0; a < guiAssets.length; a++) {
				if (guiAssets[a].status == Asset.STATUS_ON_DEVICE) {
					assetsReady++;
					}
				}
			for (a = 0; a < gameAssets.length; a++) {
				if (gameAssets[a].status == Asset.STATUS_ON_DEVICE) {
					assetsReady++;
					}
				}
			for (a = 0; a < gameLevels.length; a++) {
				if (gameLevels[a].status == Asset.STATUS_ON_DEVICE) {
					assetsReady++;
					}
				}
			//
			var allAssets:int = guiAssets.length + gameAssets.length + gameLevels.length;
			trace("loaded: " + assetsReady + " of " + allAssets);//
			if (assetsReady < allAssets) {
				EventsManager.getInstance().dispatchEvent(new AssetsManagerEvents(AssetsManagerEvents.ASSETS_NEED_LOADED));
				//load();
				}
			
			if (assetsReady == allAssets) {
				EventsManager.getInstance().dispatchEvent(new AssetsManagerEvents(AssetsManagerEvents.ALL_ASSETS_LOADED));
				}
			}
		//
		/////////////////////////////////////////////////////////////////////
		public function load():void {
			//loader.addEventListener(LoaderEvent.PROGRESS, onProgress);
			loader.addEventListener(LoaderEvent.COMPLETE, onComplete);
			//loader.addEventListener(LoaderEvent.ERROR, onError);
			loader.load();
			}
		//
		private function onComplete(e:LoaderEvent):void {
			loader.removeEventListener(LoaderEvent.COMPLETE, onComplete);
			EventsManager.getInstance().dispatchEvent(new AssetsManagerEvents(AssetsManagerEvents.ALL_ASSETS_LOADED));
			}
		//
		
		/**
		 * @param name 
		 * Name of asset:String;
		 */
		public function getAsset(name:String):void {
			if ((assetDic[name] as Asset).status == Asset.STATUS_ON_LOADED) {
				EventsManager.getInstance().dispatchEvent(new AssetsManagerEvents(AssetsManagerEvents.ASSET_LOADED, assetDic[name] as Asset));
				}else {
					(assetDic[name] as Asset).load();
					}
			}
		//
		
		public function get get3dAssets():Vector.<Asset> { 
			return gameAssets;
			}
		
	}
}