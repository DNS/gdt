package utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.LightMapMaterial;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.materials.EnvironmentMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.resources.TextureResource;
	import alternativa.engine3d.resources.BitmapCubeTextureResource;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Utils3D {
		
		public function Utils3D() {
			
			}
		//
		public static function getTexture():Material {
			var texture:StandardMaterial = new StandardMaterial();
			texture.diffuseMap = new BitmapTextureResource(new BitmapData(256, 256, false, 0x808080));
			return texture;
			}
		//
		public static function getTempTexture():StandardMaterial {
			var tempDate:BitmapTextureResource = new BitmapTextureResource(new BitmapData(1, 1, false, 0x7F7FFF));
			var tempTexture:StandardMaterial = new StandardMaterial(tempDate);
			return tempTexture;
			}
		//
		public static function getTextureFromString(data:XML):TextureObject {
			var obj:TextureObject = new TextureObject();
			var material:Material;
			//
			if (data.@type == "StandardMaterial") {
				material = new StandardMaterial();
				(material as StandardMaterial).diffuseMap = new ExternalTextureResource(data.@diffuse);
				obj.addResourses((material as StandardMaterial).diffuseMap);
				if (data.@normal != "") { (material as StandardMaterial).normalMap = new ExternalTextureResource(data.@normal); obj.addResourses((material as StandardMaterial).normalMap); }
				if (data.@specular != "") { (material as StandardMaterial).specularMap = new ExternalTextureResource(data.@specular); obj.addResourses((material as StandardMaterial).specularMap); }
				if (data.@opacity != "") { (material as StandardMaterial).opacityMap = new ExternalTextureResource(data.@opacity); obj.addResourses((material as StandardMaterial).opacityMap); }
				material.name = data.@name;
				//
				obj.material = material;
				}
			//
			return obj;
			}
	}
}