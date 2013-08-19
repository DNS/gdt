package utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	import feathers.display.Image;
	import feathers.textures.Scale9Textures;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import starling.textures.Texture;
	import utils.ConstGUI;
	
	public class GUIUtils {
		
		private static var _instance:GUIUtils;
		
		private static const BUTTON_RECT:Rectangle = new Rectangle(9, 9, 17, 17);
		//
		public function GUIUtils() {
			//
			}
		//
		public static function get instance():GUIUtils {
			if (!_instance) {
				_instance = new GUIUtils();
				}
			return _instance;
			}
		//
		//
		public function graphics(form:String, width:int, height:int, color:uint, round:int = 0, contur:int = 0, conturColor:uint = 0):Bitmap {
			var _shape:Shape = new Shape();
			//
			if (contur > 0) {
				_shape.graphics.lineStyle(contur, conturColor);
				}
			
			_shape.graphics.beginFill(color);
			
			if (form == ConstGUI.CIRCLE) {
				_shape.graphics.drawCircle(width, height, round);
				}
			if (form == ConstGUI.RECT) {
				_shape.graphics.drawRoundRect(0, 0, width, height, round, round);
				}
			//
			var data:BitmapData = new BitmapData(_shape.width, _shape.height, true, 0x000000);
			data.draw(_shape);
			var _bitmap:Bitmap = new Bitmap(data);
			//
			return _bitmap;
			}
		//
	}
}