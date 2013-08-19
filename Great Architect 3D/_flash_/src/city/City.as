package city {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.lights.AmbientLight;
	import alternativa.engine3d.lights.DirectionalLight;
	import alternativa.engine3d.lights.OmniLight;
	import alternativa.engine3d.loaders.events.TexturesLoaderEvent;
	import alternativa.engine3d.loaders.Parser3DS;
	import alternativa.engine3d.loaders.ParserMaterial;
	import alternativa.engine3d.loaders.TexturesLoader;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Surface;
	import alternativa.engine3d.primitives.Box;
	import alternativa.engine3d.primitives.GeoSphere;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.resources.Geometry;
	import alternativa.engine3d.resources.TextureResource;
	import alternativa.engine3d.shadows.DirectionalLightShadow;
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import utils.Utils3D;
	
	public class City extends Sprite {
		private var textures			: Vector.<ExternalTextureResource>;
		private var textureLoader		: TexturesLoader;
		private var texturesDict		: Dictionary = new Dictionary();
		
		[Embed(source = "../../bin/models/map.3DS", mimeType = "application/octet-stream")]
		private var mapData:Class;
		
		private var rootContainer	: Object3D = new Object3D();
		
		private var camera			: Camera3D;
		private var stage3D			: Stage3D;
		
		private var box				: Object3D;
		
		public var ready			: Boolean = false;
		
		public function City(_stage3D:Stage3D) {
			stage3D = _stage3D;
			//
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			camera = new Camera3D(0.1, 10000000);
			camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0, 0, 4);
			camera.view.hideLogo();
			addChild(camera.view);
			//addChild(camera.diagram);
			//
			camera.rotationX = -120 * Math.PI / 180;
			camera.y = -500;
			camera.z = 400;
			rootContainer.addChild(camera);
			//
			
			//
			var ambientLight:AmbientLight = new AmbientLight(0xFFFFFF);
			rootContainer.addChild(ambientLight);
			
			var shadow:DirectionalLightShadow = new DirectionalLightShadow(1000, 1000, -500, 500, 1024, 0.2);
			shadow.biasMultiplier = 0.98;
			
			var tempDate:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7FFF));
			tempDate.upload(stage3D.context3D);
			
			var parser:Parser3DS = new Parser3DS();
			parser.parse(new mapData());
			
			var y:int;
			for (y = 0; y < parser.objects.length; y++ ){
			//for each (var object:Object3D in parser.objects) {
				var house:Mesh = parser.objects[y] as Mesh;
				//
				var tempTexture:StandardMaterial = new StandardMaterial(tempDate, tempDate);
				
				house.setMaterialToAllSurfaces(tempTexture);
				rootContainer.addChild(house);
				shadow.addCaster(house);
				}
			//
			var directionalLight:DirectionalLight = new DirectionalLight(0xFFFF60);
			directionalLight.lookAt(house.x, house.y, house.z);
			directionalLight.shadow = shadow;
			rootContainer.addChild(directionalLight);
			//
			for each (var resource:Resource in rootContainer.getResources(true)) {
				resource.upload(stage3D.context3D);
				}
			//
			ready = true;
			}
		//
		private function uploadResources(resources:Vector.<Resource>):void { 
			for each (var resource:Resource in resources) { 
				resource.upload(stage3D.context3D); 
				} 
			}
		//
		public function renderEvent():void {
			if (!ready) { return; }
			//
			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;
			//
			camera.render(stage3D);
			}
		//
		
		//
	}
}