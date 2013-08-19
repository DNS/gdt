package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import game.gui.events.GUIEvent;
	
	import game.utils.GUIUtils;
	
	import org.bytearray.display.ScaleBitmapSprite;
	
	public class PopUpBase extends Sprite {
		
		public static const DEFAULT_BG:String = "PopupBg";
		
		public var childsList	: Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public var fixedWidth	: int = 0;
		public var fixedHeight	: int = 0;
		public var innerPadding	: int = 0;
		public var tintStage	: Boolean = true;
		
		public var customBg		: String = DEFAULT_BG;
		
		private var bgData		: BitmapData;
		private var bgRect		: Rectangle;
		private var bg			: ScaleBitmapSprite;
		private var closeBtn	: BaseButton;
		
		public var lastX		: int = 0;
		public var lastY		: int = 0;
		
		public var canClose		: Boolean = true;
		
		public function PopUpBase() {
			switch(customBg) {
				case DEFAULT_BG:
					bgData = new PopupBg();
					bgRect = new Rectangle(30, 30, 240, 240);
					innerPadding = 30;
					break;
				}
			//
			addEventListener(Event.ADDED_TO_STAGE, added);
			}
		//
		private function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
			//
			bg = new ScaleBitmapSprite(bgData, bgRect);
			bg.width = fixedWidth;
			bg.height = fixedHeight;
			addChild(bg);
			//
			if (canClose) {
				closeBtn = new BaseButton(BaseButton.CLOSE_BTN, closeClick, 35);
				addChild(closeBtn);
				}
			//
			GUIUtils.setPosition(closeBtn, GUIUtils.ALIGN_TOP_RIGHT, 3);
			//
			GUIUtils.setPosition(this, GUIUtils.ALIGN_CENTER);
			//
			dispatchEvent(new GUIEvent(GUIEvent.POPUP_OPEN));
			}
		//
		private function closeClick():void {
			close();
			}
		//
		public function init(...args):void {
			
			}
		//
		public function open():void {
			
			}
		//
		public function close():void {
			
			}
		//
		public function add(object:DisplayObject):void {
			
			}
		//
		public function br():void {
			
			}
		//
		public function remove():void {
			closeBtn.removeEventListener(MouseEvent.CLICK, closeClick);
			//
			bg.bitmapData.dispose();
			closeBtn.remove();
			
			removeChild(closeBtn);
			removeChild(bg);
			
			while (numChildren > 0) {
				if (getChildAt(0) is Bitmap) {
					(getChildAt(0) as Bitmap).bitmapData.dispose();
					}
				if (getChildAt(0) is BaseButton) {
					(getChildAt(0) as BaseButton).remove();
					}
				removeChildAt(0);
				}
			
			parent.removeChild(this);
			
			GUIUtils.GC();
			}
		//
		public function get innerWidth():int {
			return fixedWidth - (innerPadding * 2);
			}
		public function get innerHeight():int {
			return fixedHeight - (innerPadding * 2);
			}
		//
		public function get closeButton():BaseButton {
			return closeBtn;
			}
		//
		public function onResize():void {
			GUIUtils.setPosition(this, GUIUtils.ALIGN_CENTER);
			}
	}
}