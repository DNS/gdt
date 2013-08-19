package gems {
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
	import alternativa.engine3d.resources.TextureResource;
	import alternativa.engine3d.shadows.DirectionalLightShadow;
	import alternativa.engine3d.core.events.MouseEvent3D;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	public class Gems extends Sprite 
	{		
		private var stage3D			: Stage3D;
		private var match_three		: MatchThree;
		
		public function Gems(_stage3D:Stage3D) 
		{
			stage3D = _stage3D;
			//
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		//
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			match_three = new MatchThree(stage3D);
			match_three.startMatchThree();
			
			addChild(match_three);
		}
		//
		public function renderEvent():void 
		{
			if (match_three != null && match_three.ready == true) 
			{
				match_three.renderEvent();
			}
		}
	}
}