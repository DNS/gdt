package utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import alternativa.engine3d.materials.Material;
	
	public class TextureObject {
		
		private var _material:Material;
		
		private var _resourses:Array = new Array();
		
		public function TextureObject() {
			
			}
		//
		public function get material():Material {
			return _material;
			}
		//
		public function set material(value:Material):void {
			_material = value;
			}
		//
		public function get resourses():Array {
			return _resourses;
			}
		//
		public function addResourses(value:*):void {
			_resourses.push(value)
			}
		//
	}
}