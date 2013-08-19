package gdt.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	
	import gdt.gui.styles.Style1;//*
	
	public class Button extends Sprite {
		private var label:String = "";
		
		private var style:*;
		
		/**
		* @param _label
		* текст кнопки
		* @param _autoSize
		* авто размер (если false, то используется _width и _height)
		* @param _autoPosition
		* авто позиция (если false, то используется manualX и manualY)
		*/ 
		public function Button(_label:String = "label", _autoSize:Boolean = true, _autoPosition:Boolean = false, _width:int = 100, _height:int = 60, _manualX:int = 0, _manualY:int = 0 ) {
			label = _label;
			//
			
			}
		
	}

}