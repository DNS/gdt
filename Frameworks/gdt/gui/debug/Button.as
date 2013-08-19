package gdt.gui.debug {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import gdt.gui.BaseSprite;
	import gdt.gui.GUIConfig;
	
	import flash.display.Sprite;
	
	import flash.geom.Rectangle;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import org.bytearray.display.ScaleBitmapSprite;
	
	public class Button extends BaseSprite {
		private var fon			: ScaleBitmapSprite = new ScaleBitmapSprite(new DebugButton(), new Rectangle(5, 5, 10, 10));
		private var label		: Bitmap;
		private var ClickEvent	: Function;
		
		public function Button(labelText:String, event:Function) {
			super();
			align = GUIConfig.ALIGN_CENTER;
			
			ClickEvent = event;
			
			addChild(fon);
			
			label = GUIConfig.createBitmapTF(labelText, GUIConfig.tfFormat(GUIConfig.CalibriFont, 0xFFFFFF, 25, TextFieldAutoSize.LEFT, true), GUIConfig.getFilters([0]));
			fon.addChild(label);
			fon.width = label.width + 4;
			fon.height = label.height - 4;
			
			GUIConfig.setPosition(label, GUIConfig.ALIGN_CENTER);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onPress);
			}
		//
		private function onPress(e:MouseEvent):void {
			ClickEvent();
			}
		//
		
	}
}