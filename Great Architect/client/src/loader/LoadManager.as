package loader {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.GlobalConfig;
	
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.LoaderStatus
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.data.ImageLoaderVars;
	import com.greensock.events.LoaderEvent;
	
	public class LoadManager extends EventDispatcher {
		
		private static var _instance:LoadManager;
		
		private var _loader		: LoaderMax;
		
		private var images		: Vector.<Bitmap> = new Vector.<Bitmap>();
		private var imagesName	: Dictionary = new Dictionary();
		
		public function LoadManager() {
			_loader = new LoaderMax();
			}
		//
		public static function get instance():LoadManager {
			if (!_instance) {
				_instance = new LoadManager();
				}
			return _instance;
			}
		//
		public function loadAll():void {
			loadCityBg();
			}
		//
		private function loadCityBg():void {
			var bgLoader:ImageLoader = imgLoader(ItemsManager.cityBg);
			bgLoader.addEventListener(LoaderEvent.PROGRESS, onProgress);
			bgLoader.addEventListener(LoaderEvent.COMPLETE, onLoad);
			bgLoader.addEventListener(LoaderEvent.ERROR, onLoadError);
			bgLoader.addEventListener(LoaderEvent.FAIL, onLoadError);
			bgLoader.addEventListener(LoaderEvent.IO_ERROR, onLoadError);
			bgLoader.addEventListener(LoaderEvent.SECURITY_ERROR, onLoadError);
			bgLoader.load();
			//
			function onProgress(e:LoaderEvent):void {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.LOADER_PROGRESS, new EventParams(EventParams.PROGRESS, e.target.progress)));
				}
			//
			function onLoad(e:LoaderEvent):void {
				removeListeners();
				//
				var bmp:Bitmap = new Bitmap();
				bmp.bitmapData = (e.target.rawContent as Bitmap).bitmapData.clone();
				images.push(bmp);
				imagesName[e.target.name] = bmp;
				//
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.CITYBG_LOADED));
				}
			
			function onLoadError(e:LoaderEvent):void {
				removeListeners();
				trace("Error! :: LoadManager > loadCityBg > onLoadError: " + e);
				}
			//
			function removeListeners():void {
				bgLoader.removeEventListener(LoaderEvent.PROGRESS, onProgress);
				bgLoader.removeEventListener(LoaderEvent.COMPLETE, onLoad);
				bgLoader.removeEventListener(LoaderEvent.ERROR, onLoadError);
				bgLoader.removeEventListener(LoaderEvent.FAIL, onLoadError);
				bgLoader.removeEventListener(LoaderEvent.IO_ERROR, onLoadError);
				bgLoader.removeEventListener(LoaderEvent.SECURITY_ERROR, onLoadError);
				}
			}
		//
		public function loadImage(name:String, callBack:Function = null):void {
			if (imagesName[name] != null) {
				if (callBack != null) {
					callBack();
					return;
					}
				}
			//
			var imgageLoader:ImageLoader = imgLoader(name + ".png");
			//
			imgageLoader.addEventListener(LoaderEvent.PROGRESS, onProgress);
			imgageLoader.addEventListener(LoaderEvent.COMPLETE, onLoad);
			imgageLoader.addEventListener(LoaderEvent.ERROR, onLoadError);
			imgageLoader.addEventListener(LoaderEvent.FAIL, onLoadError);
			imgageLoader.addEventListener(LoaderEvent.IO_ERROR, onLoadError);
			imgageLoader.addEventListener(LoaderEvent.SECURITY_ERROR, onLoadError);
			imgageLoader.load();
			//
			function onProgress(e:LoaderEvent):void {
				EventManager.instance.dispatchEvent(new GameEvent(GameEvent.LOADER_PROGRESS, new EventParams(EventParams.PROGRESS, e.target.progress)));
				}
			//
			function onLoad(e:LoaderEvent):void {
				removeListeners(e.target);
				//
				var bmp:Bitmap = new Bitmap();
				bmp.bitmapData = (e.target.rawContent as Bitmap).bitmapData.clone();
				images.push(bmp);
				imagesName[e.target.name] = bmp;
				//
				if (callBack != null) {
					callBack();
					}
				}
			
			function onLoadError(e:LoaderEvent):void {
				removeListeners(e.target);
				MonsterDebugger.trace(this, e, "Danil", "Error > onLoadError", 0xFF0000);
				}
			//
			function removeListeners(_loader:ImageLoader):void {
				_loader.removeEventListener(LoaderEvent.PROGRESS, onProgress);
				_loader.removeEventListener(LoaderEvent.COMPLETE, onLoad);
				_loader.removeEventListener(LoaderEvent.ERROR, onLoadError);
				_loader.removeEventListener(LoaderEvent.FAIL, onLoadError);
				_loader.removeEventListener(LoaderEvent.IO_ERROR, onLoadError);
				_loader.removeEventListener(LoaderEvent.SECURITY_ERROR, onLoadError);
				}
			}
		//
		public function getImage(name:String):Bitmap {
			if (imagesName[fileName(name)] != null) {
				return imagesName[fileName(name)];
				}
			return null;
			}
		//
		private function imgLoader(img:String):ImageLoader {
			var path:String = String(GlobalConfig.server + GlobalConfig.images + img);
			//var path:String = String(img);
			var params:Object = { name:fileName(img), smoothing:false, autoDispose:false }
			var _loader:ImageLoader = new ImageLoader(path, params);
			return _loader;
			}
		//
		private function fileName(name:String):String {
			var ext:String = name.replace(/\.jpg|\.png/gi, "");
			return ext;
			}
	}
}