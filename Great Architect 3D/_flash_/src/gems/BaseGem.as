package gems {
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
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class BaseGem extends GeoSphere	
	{	
		public var col					: int;
		public var row					: int;
		public var type					: int;
		
		private var locked				: Boolean = false;
		private var canMove				: Boolean = true;
		//
		public function BaseGem(r:uint, s:uint) 
		{
			super(r, s);
		}
		//
		public function select(val:Boolean = false):void 
		{

		}
		
		public function get isLocked():Boolean { return locked; }
		
		public function get isWall():Boolean { return !canMove; }
		public function set isWall(value:Boolean):void { canMove = !value; }
	}
}