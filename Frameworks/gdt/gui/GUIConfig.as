package gdt.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.filters.DropShadowFilter;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import gdt.gui.buttons.SimplyButton;
	
	public class GUIConfig {
		
		public static const SIMPLY_BUTTON		: String = "SIMPLY_BUTTON";
		
		public static const ALIGN_NONE			: String = "ALIGN_NONE";
		public static const ALIGN_CENTER		: String = "ALIGN_CENTER";
		public static const ALIGN_LEFT			: String = "ALIGN_LEFT";
		public static const ALIGN_RIGHT			: String = "ALIGN_RIGHT";
		public static const ALIGN_TOP			: String = "ALIGN_TOP";
		public static const ALIGN_BOTTOM		: String = "ALIGN_BOTTOM";
		public static const ALIGN_TOP_LEFT		: String = "ALIGN_TOP_LEFT";
		public static const ALIGN_BOTTOM_LEFT	: String = "ALIGN_BOTTOM_LEFT";
		public static const ALIGN_TOP_RIGHT		: String = "ALIGN_TOP_RIGHT";
		public static const ALIGN_BOTTOM_RIGHT	: String = "ALIGN_BOTTOM_RIGHT";
		
		public static var CalibriFont:String = new Calibri().fontName;
		
		public function GUIConfig() {
			
			}
		//
		/**
		* @param target
		* выравнивание кнопки в окне
		*/
		public static function setPosition(_target:*, align:String = ALIGN_NONE, padding:int = 0):void {
			if (!_target.parent) { return; }
			
			var align	: String = _target is BaseSprite ? _target.align : align;
			var padding	: int = _target is BaseSprite ? _target.padding : padding;
			var parent	: DisplayObject = _target.parent;
			
			switch(align) {
				case ALIGN_CENTER:
					_target.x = (parent.width / 2) - (_target.width / 2);
					_target.y = (parent.height / 2) - (_target.height / 2);
					break;
				case ALIGN_LEFT:
					//
					break;
				case ALIGN_TOP_LEFT:
					_target.x = parent.width - _target.width - padding;
					_target.y = _target.y + padding;
					break;
				default :	break;
				}
			}
		//
		/**
		* @param text
		* Текст
		* @param filters
		* Фильтры для текста
		*/
		public static function createBitmapTF(text:String, format:Object, filters:Array = null):Bitmap {
			var bitmap:Bitmap = new Bitmap();
			
			var tf:TextField = new TextField();
			
			tf.embedFonts = true;
			tf.defaultTextFormat = format.format;// new TextFormat(new CalibriFont().fontName, 12, 0xFFFFFF, true);
			tf.autoSize = format.align;
			tf.selectable = false;
			tf.mouseEnabled = false;
			//tf.border = true;
			//tf.borderColor = 0x00FF00;
			tf.text = text;
			
			if (filters) {
				tf.filters = filters;
				}
			
			bitmap.bitmapData = new BitmapData(tf.width + 1, tf.height + 1, true, 0x000000);
			bitmap.bitmapData.draw(tf);
			
			tf = null;
			
			return bitmap;
			}
		//
		/**
		* @param font
		* Имя шрифта
		* @param color
		* Цвет
		* @param size
		* Размер
		* @param align
		* Выравнивание TextFieldAutoSize
		* @param bold
		* Жирный
		*/
		public static function tfFormat(font:String, color:*, size:int, align:String, bold:Boolean):Object {
			var obj:Object = new Object();
			
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.color = color;
			format.size = size;
			format.bold = bold;
			
			obj.format = format;
			obj.align = align;
			
			return obj;
			}
		//
		/**
		* @param ids
		* Id фильтров
		* 0 - Тень для текста
		*/
		public static function getFilters(ids:Array):Array {
			var arr:Array = new Array();
			
			var i:int;
			for (i = 0; i < ids.length; i++ ) {
				switch(ids[i]) {
					case 0: // Тень для тектса
						arr.push(new DropShadowFilter(1, 90, 0x000000, 0.7, 2, 2, 1, 1));
						break;
					}
				}
			
			return arr;
			}
	}
}