package assets {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import alternativa.engine3d.loaders.events.TexturesLoaderEvent;
	import alternativa.engine3d.loaders.Parser3DS;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import assets.events.AssetsEvent;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import com.demonsters.debugger.MonsterDebugger;
	import utils.TextureObject;
	import utils.Utils3D;
	
	import flash.display.Stage3D;
	import flash.events.EventDispatcher;
	
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.LightMapMaterial;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.materials.EnvironmentMaterial;
	import alternativa.engine3d.materials.Material;
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.data.DataLoaderVars;
	
	public class Assets extends EventDispatcher {
		
		private static var _instance	: Assets;
		
		private var _assetsList			: XMLList;
		private var stage3D				: Stage3D;
		private var _loader				: LoaderMax;
		
		private var textureLoader		: TexturesLoader;
		
		private var _externalTextures	: Vector.<ExternalTextureResource> = new Vector.<ExternalTextureResource>();
		private var _externalTexturesDic: Dictionary = new Dictionary();
		
		private var _textures			: Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
		private var _textureDic			: Dictionary = new Dictionary();
		
		private var _models				: Vector.<Mesh> = new Vector.<Mesh>();
		private var _modelsDic			: Dictionary = new Dictionary();
		
		private var event				: AssetsEvent;
		
		public function Assets() {
			//
			}
		//
		public static function get instance():Assets {
			if (!_instance) {
				_instance = new Assets();
				}
			return _instance;
			}
		//
		public function init(_stage3D:Stage3D):void {
			stage3D = _stage3D;
			//
			_loader = new LoaderMax( { onProgress:onProgressLoad, onComplete:onCompleteLoad, onCancel:onErrorLoad, onError:onErrorLoad, onIOError:onErrorLoad, onHTTPStatus:onErrorLoad, onScriptAccessDenied:onErrorLoad } );
			_loader.autoLoad = false;
			}
		//
		private function onProgressLoad(e:LoaderEvent):void {
			event = new AssetsEvent(AssetsEvent.LOAD_PROGRESS);
			event.data = { progress:_loader.progress };
			dispatchEvent(event);
			}
		private function onCompleteLoad(e:LoaderEvent):void {
			createModels();
			}
		private function onErrorLoad(e:LoaderEvent):void {
			//log(e, "onErrorLoad", true);
			}
		//
		public function load():void {
			var _assetsXML:XMLLoader = new XMLLoader("models/assets.xml", { name:"assetsXML", onComplete:completeLoadXML } );
			_assetsXML.load();
			}
		//
		private function completeLoadXML(e:LoaderEvent):void {
			_assetsList = new XMLList(LoaderMax.getContent("assetsXML"));
			parseTextures(_assetsList.child("textures").children());
			}
		//
		private function parseTextures(list:XMLList):void {
			var textureObj:TextureObject;
			var texture:Material;
			for each (var textureData:XML in list) {
				textureObj = Utils3D.getTextureFromString(textureData);
				texture = textureObj.material;
				addExternalTextures(textureObj.resourses);
				_textures.push(texture);
				_textureDic[texture.name] = texture;
				}
			//
			parse3DS(_assetsList.child("models").children());
			}
		//
		private function addExternalTextures(resourses:Array):void {
			var i:int;
			for (i = 0; i < resourses.length; i++) {
				if (_externalTexturesDic[resourses[i].url] == null) {
					_externalTextures.push(resourses[i]);
					_externalTexturesDic[resourses[i].url] = resourses[i];
					}
				}
			}
		//
		private function parse3DS(list:XMLList):void {
			var _dataLoader:DataLoader;
			var _dataLoaderVars:DataLoaderVars;
			for each (var model:XML in list) {
				_dataLoaderVars = new DataLoaderVars();
				_dataLoaderVars.name(model.@name.toString());
				_dataLoaderVars.format("binary");
				_dataLoaderVars.prop("texture", model.@texture.toString());
				_dataLoaderVars.prop("level", model.@level.toString());
				
				_dataLoader = new DataLoader(model.@url.toString(), _dataLoaderVars);
				_loader.append(_dataLoader);
				}
			//
			_loader.load();
			}
		//
		private function createModels():void {
			var allModels:Array = _loader.getChildren();
			var i:int;
			var _mesh:Mesh;
			for (i = 0; i < allModels.length; i++) {
				var parser:Parser3DS = new Parser3DS();
				parser.parse(allModels[i].content as ByteArray);
				//
				_mesh = parser.objects[0] as Mesh;
				_mesh.name = allModels[i].vars.name;
				_mesh.userData = { level:allModels[i].vars.level };
				_mesh.setMaterialToAllSurfaces(_textureDic[allModels[i].vars.texture]);
				//
				_models.push(_mesh);
				_modelsDic[_mesh.name] = _mesh;
				//
				parser.clean();
				parser = null;
				}
			//
			event = new AssetsEvent(AssetsEvent.MODELS_LOADED);
			dispatchEvent(event);
			//
			loadTextures();
			}
		//
		private function loadTextures():void {
			textureLoader = new TexturesLoader(stage3D.context3D);
			textureLoader.loadResources(_externalTextures, true, true);
			textureLoader.addEventListener(Event.COMPLETE, onTexturesLoaded);
			}
		//
		private function onTexturesLoaded(event:Event):void {
			var e:TexturesLoaderEvent = TexturesLoaderEvent(event);
			var bitmapDataVector:Vector.<BitmapData> = Vector.<BitmapData>(e.getBitmapDatas());
			var bitmapResource:BitmapTextureResource = new BitmapTextureResource(bitmapDataVector[0]);
			bitmapResource.upload(stage3D.context3D);
			//
			event = new AssetsEvent(AssetsEvent.TEXTURES_LOADED);
			dispatchEvent(event);
			}
		//
		private function log(data:*, type:String = "", error:Boolean = false):void {
			var color:uint = 0x008000;
			if (error) {
				color = 0xD90000;
				}
			MonsterDebugger.trace(this, data, "Assets: " + type, "log", color);
			}
	}
}