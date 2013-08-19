package gdt.gui.debug {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Log extends Sprite {
		
		private var textF:TextField = new TextField();
		
		public function Log(_width:int, _height:int) {
			var fon:Sprite = new Sprite();
			fon.graphics.beginFill(0x000000, 0.7);
			fon.graphics.drawRect(0, 0, _width, _height);
			fon.graphics.endFill();
			addChild(fon);
			
			textF.width = _width;
			textF.height = _height;
			textF.embedFonts = true;
			textF.defaultTextFormat = new TextFormat(new Calibri().fontName, 12, 0xFFFFFF, true);
			textF.wordWrap = true;
			textF.multiline = true;
			textF.borderColor = 0xFFFFFF;
			textF.border = true;
			textF.selectable = false;
			textF.mouseEnabled = false;
			addChild(textF);
			}
		//
		public function add(val:String):void {
			textF.appendText("\n" + val);
			textF.scrollV = textF.numLines;
			}
		//
		public function clear():void {
			textF.text = "";
			}
	}
}