package game.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.PixelSnapping;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import game.gui.Scene;
	
	import game.Main;
	
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import flash.system.System;
	
	import flash.filters.DropShadowFilter;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.AntiAliasType;
	
	public class GUIUtils {
		
		public static const AUTOSIZE_LEFT		: String = TextFieldAutoSize.LEFT;
		public static const AUTOSIZE_RIGHT		: String = TextFieldAutoSize.RIGHT;
		public static const AUTOSIZE_CENTER		: String = TextFieldAutoSize.CENTER;
		public static const AUTOSIZE_NONE		: String = TextFieldAutoSize.NONE;
		
		public static const TEXT_ALIGN_LEFT		: String = TextFormatAlign.LEFT;
		public static const TEXT_ALIGN_RIGHT	: String = TextFormatAlign.RIGHT;
		public static const TEXT_ALIGN_CENTER	: String = TextFormatAlign.CENTER;
		
		public static const ALIGN_NONE			: String = "ALIGN_NONE";
		public static const ALIGN_CENTER		: String = "ALIGN_CENTER";
		
		public static const ALIGN_LEFT			: String = "ALIGN_LEFT";
		public static const ALIGN_RIGHT			: String = "ALIGN_RIGHT";
		public static const ALIGN_TOP			: String = "ALIGN_TOP";
		public static const ALIGN_BOTTOM		: String = "ALIGN_BOTTOM";
		
		public static const ALIGN_TOP_CENTER	: String = "ALIGN_TOP_CENTER";
		public static const ALIGN_TOP_LEFT		: String = "ALIGN_TOP_LEFT";
		public static const ALIGN_TOP_RIGHT		: String = "ALIGN_TOP_RIGHT";
		
		public static const ALIGN_BOTTOM_LEFT	: String = "ALIGN_BOTTOM_LEFT";
		public static const ALIGN_BOTTOM_RIGHT	: String = "ALIGN_BOTTOM_RIGHT";
		public static const ALIGN_BOTTOM_CENTER	: String = "ALIGN_BOTTOM_CENTER";
		
		public static const ALIGN_LEFT_CENTER	: String = "ALIGN_LEFT_CENTER";
		
		
		public static var MyriadProFont			: String = new MyriadPro().fontName;
		public static var MyriadProBoldFont		: String = new MyriadProBold().fontName;
		
		public function GUIUtils() {
			
			}
		//
		/**
		* @param target
		* выравнивание
		*/
		public static function setPosition(target:DisplayObject, align:String = ALIGN_NONE, padding:int = 0):void {
			if (target.parent == null) {
				throw new Errors("parent is NULL!");
				}
			
			var parent:Object = target.parent is Main ? { width:target.parent.stage.stageWidth, height:target.parent.stage.stageHeight } : target.parent;
			
			if (parent is Scene) {
				parent = { width:(target.parent as Scene).fixedWidth, height:(target.parent as Scene).fixedHeight, x:0, y:0 };
				}
			
			//trace("target: " + target + ", parent" + target.parent);
			
			switch(align) {
				case ALIGN_CENTER:
					target.x = (parent.width / 2) - (target.width / 2);
					target.y = (parent.height / 2) - (target.height / 2);
					break;
				case ALIGN_LEFT:
					target.x = target.x + padding;
					break;
				case ALIGN_LEFT_CENTER:
					target.x = target.x + padding;
					target.y = (parent.height / 2) - (target.height / 2);
					break;
				case ALIGN_TOP_RIGHT:
					target.x = parent.width - target.width - padding;
					target.y = target.y + padding;
					break;
				case ALIGN_TOP_LEFT:
					target.x = parent.x + padding;
					target.y = target.y + padding;
					break;
				case ALIGN_TOP_CENTER:
					target.x = (parent.width / 2) - (target.width / 2);
					target.y = parent.y + padding;
					break;
				case ALIGN_RIGHT:
					target.x = (parent.width + parent.x) - target.width - padding;
					break;
				case ALIGN_BOTTOM_CENTER:
					target.x = (parent.width / 2) - (target.width / 2);
					target.y = parent.height - target.height - padding;
					break;
				default : throw new Errors("align is ALIGN_NONE!");	break;
				}
			}
		//
		/**
		* @param text
		* Текст
		* @param filters
		* Фильтры для текста
		*/
		public static function createBitmapTF(text:String = "null", format:Object = null, filters:Array = null, width:int = 0, height:int = 0, pass:Boolean = false, multiline:Boolean = false, cut:Boolean = true):Bitmap {
			var bitmap:Bitmap = new Bitmap(null, PixelSnapping.ALWAYS);
			
			var tf:TextField = new TextField();
			
			tf.displayAsPassword = pass;
			tf.embedFonts = true;
			tf.defaultTextFormat = format.format;
			tf.autoSize = format.autoSize;
			
			if (tf.autoSize == TextFieldAutoSize.NONE) {
				tf.width = width;
				tf.height = height;
				}
			
			tf.multiline = multiline;
			tf.wordWrap = multiline;
			tf.selectable = false;
			tf.mouseEnabled = false;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			
			//tf.border = true;
			//tf.borderColor = 0x00FF00;
			
			tf.text = text;
			
			if (filters) {
				tf.filters = filters;
				}
			
			if (multiline == true && cut) {
				tf.height = (tf.numLines + 1) * int(tf.defaultTextFormat.size);
				}
			
			bitmap.bitmapData = new BitmapData(tf.width + 2, tf.height + 2, true, 0xFFFFFF);
			bitmap.bitmapData.draw(tf, null, null, null, new Rectangle(tf.x, tf.y, (width == 0 ? tf.width : width), (height == 0 ? tf.height : height)));
			
			tf = null;
			
			return bitmap;
			}
		//
		public static function createTF(text:String, format:Object, width:int, height:int, multiline:Boolean = false, type:String = TextFieldType.DYNAMIC):TextField {
			var tf:TextField = new TextField();
			
			tf.embedFonts = true;
			tf.type = type;
			tf.defaultTextFormat = format.format;
			tf.width = width;
			tf.height = height;
			tf.multiline = multiline;
			tf.wordWrap = multiline;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			
			//tf.border = true;
			//tf.borderColor = 0x00FF00;
			
			tf.text = text;
			
			return tf;
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
		public static function tfFormat(font:String, color:*, size:int, auoSize:String, align:String, bold:Boolean = false, letterSpacing:int = 0):Object {
			var obj:Object = new Object();
			
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.color = color;
			format.size = size;
			format.bold = bold;
			format.align = align;
			
			if (letterSpacing != 0) {
				format.letterSpacing = letterSpacing;
				}
			
			obj.format = format;
			obj.autoSize = auoSize;
			
			return obj;
			}
		//
		/**
		* @param ids
		* Id фильтров
		* 0 - Тень для текста черная
		* 1 - Контур для текста белый
		*/
		public static function getFilters(ids:Array):Array {
			var arr:Array = new Array();
			
			var i:int;
			for (i = 0; i < ids.length; i++ ) {
				switch(ids[i]) {
					case 0:
						arr.push(new DropShadowFilter(1, 90, 0x000000, 0.7, 2, 2, 1, 1));
						break;
					case 1:
						arr.push(new DropShadowFilter(0, 90, 0xFFFFFF, 1, 2, 2, 10, 2));
						break;
					}
				}
			
			return arr;
			}
		//
		/**
		* Sprite с заливкой (или без) + контур и радиус
		* @param colorBg
		* Цвет заливки (0xFFFFFF)
		* @param radius
		* Радиус скругления
		* @param conturColor
		* Цвет контура
		* @param conturW
		* Тольщина контура
		*/
		public static function createSprite(colorBg:uint = 0xFFFFFF, width:int = 0, height:int = 0, radius:int = 0, conturColor:uint = 0x000000, thickness:int = 1):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle(thickness, conturColor, 1, true);
			sprite.graphics.beginFill(colorBg);
			sprite.graphics.drawRoundRect(0, 0, width, height, radius);
			sprite.graphics.endFill();
			
			return sprite;
			}
		//
		/**
		* Маска для Bitmap или Sprite
		* @param source
		* Bitmap или Sprite для которого создается маска
		* @param radius
		* Радиус скругления
		* @param coord
		* Если source еще пустой
		*/
		public static function createMask(source:*, radius:int = 0, coord:Rectangle = null):Sprite {
			//var source:* = source is Bitmap ? source as Bitmap : source as Sprite;
			
			var rect:Rectangle = source.width != 0 ? new Rectangle(0, 0, source.width, source.height) : coord;
			
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0x000000);
			mask.graphics.drawRoundRect(0, 0, rect.width, rect.height, radius);
			mask.graphics.endFill();
			
			return mask;
			}
		//
		/**
		* Пока не использавать!
		* @param ids
		* Id фильтров
		*/
		public static function resizeBitmap(img:Bitmap, width:int, height:int):Bitmap {
			var originalBitmap:Bitmap = new Bitmap();
			var originalBitmapData:BitmapData = img.bitmapData;
			
			var scale:Number = 0;
			
			if (img.width < img.height) {
				img.width = width;
				scale = img.scaleX;
				}else {
					img.height = height;
					scale = img.scaleY;
					}
				
			var frame:Rectangle = new Rectangle(10, 0, width, height);
			
			var scaledBitmapData:BitmapData = new BitmapData(width, height, true, 0xFFFFFFFF);
			
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(scale, scale);
			
			scaledBitmapData.draw(originalBitmapData, scaleMatrix, null, null, frame, true);
			originalBitmap.bitmapData = scaledBitmapData;
			
			return originalBitmap;
			}
		//
		/**
		* BitmapData, просто залитая
		* @param color
		* цвет (0xFF8040)
		* @param width
		* ну тут понятно
		* @param height
		* и тут тоже
		*/
		public static function getColorBg(color:uint, width:int, height:int):BitmapData {
			var bitmapD:BitmapData = new BitmapData(width, height, false, 0x000000);
			bitmapD.fillRect(new Rectangle(0, 0, width, height), color);
			return bitmapD;
			}
		//
		/**
		* Sprite залитый Bitmap тайлами
		* @param bitmap
		* BitmapData для заливки
		* @param width
		* ну тут понятно
		* @param height
		* и тут тоже
		*/
		public static function getBitmapBg(bitmap:BitmapData, width:int, height:int):Sprite {
			var bitmapShape:Sprite = new Sprite();
			
			bitmapShape.graphics.beginBitmapFill(bitmap);
			bitmapShape.graphics.drawRect(0, 0, width, height);
			bitmapShape.graphics.endFill();
			//bitmapShape.cacheAsBitmap = true;
			//bitmapShape.cacheAsBitmapMatrix = new Matrix();
			
			return bitmapShape;
			}
		//
		/**
		* Просто точка, хз зачем
		*/
		public static function point(addToStage:Point = null):Sprite {
			var sp:Sprite = new Sprite();
			
			var p:Shape = new Shape();
			p.graphics.beginFill(Math.round(Math.random()*0xFFFFFF), 0.7);
			p.graphics.drawCircle(0, 0, 8);
			p.graphics.endFill();
			p.graphics.lineStyle(1, Math.round(Math.random()*0xFFFFFF));
			p.graphics.moveTo( 0, -15);
			p.graphics.lineTo( 0, 15);
			p.graphics.moveTo( -15, 0);
			p.graphics.lineTo( 15, 0);
			
			sp.addChild(p);
			
			if (addToStage != null) {
				sp.x = addToStage.x;
				sp.y = addToStage.y;
				//
				var text:Bitmap = createBitmapTF("x: " + addToStage.x + ", y: " + addToStage.y, tfFormat(MyriadProFont, 0xFFFFFF, 8, AUTOSIZE_LEFT, TEXT_ALIGN_LEFT));
				sp.addChild(text);
				GlobalInstance.instance.MainStage.addChild(sp);
				}
			
			return sp;
			}
		//
		public static function convertPoint(target:DisplayObject, rect:Boolean = false):* {
			var _local:Point = new Point(target.x, target.y);
			var _global:Point = target.localToGlobal(_local);
			
			if (rect) {
				var _rect:Rectangle = new Rectangle(_global.x, _global.y, target.width, target.height);
				return _rect;
				}
			
			return _global;
			}
		//
		public static function GC():void {
			System.gc();
			System.gc();
			}
	}
}