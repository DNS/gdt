package gdt.assets {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import flash.display.DisplayObject;
	
	import gdt.assets.AssetsManager;
	
	import gdt.events.EventsManager;
	import gdt.events.AssetsManagerEvents;
	
	import flash.filesystem.File;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderStatus;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.BinaryDataLoader;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	
	public class Asset {
		public static const STATUS_ON_DEVICE		: String = "STATUS_ON_DEVICE";
		public static const STATUS_ON_LOADED		: String = "STATUS_ON_LOADED";
		public static const STATUS_IS_NEED_LOADING	: String = "STATUS_IS_NEED_LOADING";
		public static const STATUS_ON_FAIL			: String = "STATUS_ON_FAIL";
		
		public var path			: String;
		public var type			: String;
		public var name			: String;
		
		public var status		: String;
		
		private var loader		: LoaderCore;
		
		public function Asset(data:Object) {
			for (var field:String in data) {
				this[field] = data[field];
				}
			}
		//
		public function get fileExists():Boolean {
			
			return (status == STATUS_ON_LOADED) ? true : false;
			}
		
		public function getLoader():LoaderCore {
			path = checkFileOnDevice() + path;
			
			switch(type) {
				case "bitmap":
					loader = new ImageLoader(path);
					break;
				case "sound":
					loader = new MP3Loader(path);
					break;
				case "swf":
					loader = new SWFLoader(path);
					break;
				case "xml":
					loader = new XMLLoader(path);
					break;
				case "data":
					loader = new BinaryDataLoader(path);
					break;
				}
			
			if (status != STATUS_ON_DEVICE) {
				loader.addEventListener(LoaderEvent.COMPLETE, onLoaded);
				loader.addEventListener(LoaderEvent.FAIL, onLoadedFail);
				loader.load();
				}
			//
			return loader;
			}
		//
		private function checkFileOnDevice():String {
			var devicePath:String = "";
			switch(AssetsManager.getPlatform) {
				case AssetsManager.DESKTOP:
					devicePath = File.applicationDirectory.nativePath;
					break;
				case AssetsManager.ANDROID:
				case AssetsManager.ANDROID_TAB:
					devicePath = File.applicationDirectory.nativePath;
					break;
				}
			
			var file:File = new File(devicePath + path);
			if (file.exists) {
				status = STATUS_ON_DEVICE;
				}else {
					status = STATUS_IS_NEED_LOADING;
					}
			
			return devicePath;
			}
		//
		public function load():void {
			loader.addEventListener(LoaderEvent.COMPLETE, onLoaded);
			loader.addEventListener(LoaderEvent.FAIL, onLoadedFail);
			loader.load();
			}
		//
		private function onLoaded(e:LoaderEvent):void {
			loader.removeEventListener(LoaderEvent.COMPLETE, onLoaded);
			loader.removeEventListener(LoaderEvent.FAIL, onLoadedFail);
			//trace("loaded: " + name + ", target: " + e.target);
			status = STATUS_ON_LOADED;
			EventsManager.getInstance().dispatchEvent(new AssetsManagerEvents(AssetsManagerEvents.ASSET_LOADED, this));
			}
		//
		private function onLoadedFail(e:LoaderEvent):void {
			trace("onLoadedFail: " + name + ", text: " + e.text);
			}
		//
		/**
		* @private getContent
		* зависит от типа (ImageLoader, BinaryDataLoader, ...)
		*/
		public function getContent():* {
			var content:*;
			if (loader is ImageLoader) {
				content = (loader as ImageLoader).rawContent;
				}
			if (loader is XMLLoader) {
				content = (loader as XMLLoader).content;
				}
			if (loader is BinaryDataLoader) {
				content = (loader as BinaryDataLoader).content;
				}
			return content;
			}
		//
		public function get getPath():String {
			return path;
			}
	}
}