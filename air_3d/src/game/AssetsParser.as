package game {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import game.utils.Level;
	
	import gdt.assets.AssetsManager;
	
	import gdt.events.EventsManager;
	import gdt.events.AssetsManagerEvents;
	import gdt.events.GameEvents;
	
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.utils.getTimer;
	
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.loaders.ParserMaterial;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.resources.ExternalTextureResource;
	
	public class AssetsParser {
		private static var context3d		: Context3D;
		private static var rootObject		: Object3D;
		private static var texturesLoader	: TexturesLoader;
		
		private static var currentLevel		: Level;
		
		private static var textureResources	: Vector.<ExternalTextureResource> = new Vector.<ExternalTextureResource>();
		
		public function AssetsParser() {
			
			}
		//
		public static function get loader():TexturesLoader { return texturesLoader; }
		
		public static function init(context:Context3D, rootObj:Object3D):void {
			context3d = context;
			rootObject = rootObj;
			texturesLoader = new TexturesLoader(context3d);
			}
		//
		public static function loadLevel(_level:int = 0):void {
			if (_level == 0) { trace("Load level ERROR"); return; }
			//
			EventsManager.getInstance().addEventListener(AssetsManagerEvents.ASSET_LOADED, onXML);
			Application.assets.getAsset("level_" + _level);
			}
		
		private static function onXML(e:AssetsManagerEvents):void {
			EventsManager.getInstance().removeEventListener(AssetsManagerEvents.ASSET_LOADED, onXML);
			
			currentLevel = new Level(e.asset.getContent());
			
			}
		//
		
		public function addAssets():void {
			textureResources = new Vector.<ExternalTextureResource>();
			texturesLoader = new TexturesLoader(context3d);
			
			//
			/*for each(var child:Object3D in parser.hierarchy) {
				rootContainer.addChild(child);
				}*/
			/*for each(var mat:ParserMaterial in parser.materials) {
				var obj:Object = mat.textures;
				for (var p:String in obj) {
					textureResources.push(obj[p]);
					trace("p: " + p + " = " + obj[p]);
					}
				}
			parser.clean();
			texturesLoader.loadResources(textureResources);*/
			//
			//uploadResource();
			}
		//
		public static function get level():Level {
			return currentLevel;
			}
	}
}