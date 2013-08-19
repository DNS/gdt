package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import game.utils.GUIUtils;
	import game.gui.VerticalScrollbar;
	import game.utils.MacMouseWheel;
	import game.utils.MouseWheelTrap;
	import org.bytearray.display.ScaleBitmapSprite;
	
	public class List extends Sprite {
		
		public var topPadding	: int = 0;
		
		private var scroll		: VerticalScrollbar;
		private var scrollBut	: ScaleBitmapSprite = null;
		private var sheetBg		: Sprite = new Sprite();
		private var sheet		: Sprite = new Sprite();
		private var sheetMask	: Sprite = new Sprite();
		private var content		: Vector.<ListItem> = new Vector.<ListItem>();
		private var lastY		: int = 0;
		
		private var parentPopUp	: PopUpBase;
		
		public function List(popUp:PopUpBase) {
			parentPopUp = popUp;
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			sheetBg = GUIUtils.createSprite(0xFFFFFF, parentPopUp.innerWidth, parentPopUp.innerHeight - topPadding, 10, 0x005266, 1.2);
			addChild(sheetBg);
			//
			sheet = new Sprite();
			addChild(sheet);
			//
			sheetMask = GUIUtils.createMask(sheet, 10, new Rectangle(0, 0, parentPopUp.innerWidth, parentPopUp.innerHeight - topPadding));
			addChild(sheetMask);
			sheet.mask = sheetMask;
			//
			scrollBut = new ScaleBitmapSprite(new ScrollBg(), new Rectangle(3, 3, 5, 29));
			scrollBut.buttonMode = true;
			scrollBut.width = 11;
			scrollBut.height = 50;
			scrollBut.x = sheetBg.x + sheetBg.width - scrollBut.width;
			addChild(scrollBut);
			//
			var i:int;
			var listItm:ListItem;
			for (i = 0; i < int(Math.random() * 100 + 1); i++) {
				listItm = new ListItem();
				addItem(listItm);
				}
			//
			MacMouseWheel.setup(stage);
			MouseWheelTrap.setup(stage);
			//
			scroll = new VerticalScrollbar(stage, scrollBut, new Rectangle(0, 0, parentPopUp.innerWidth, parentPopUp.innerHeight - topPadding), sheetMask, sheet);
			redrawScroll();
			}
		//
		private function redrawScroll():void {
			if (sheet.height < sheetBg.height) {
				scroll.visible = scroll.wheelEnabled = false;
				}
			// TODO: Допилить!
			}
		//
		public function addItem(item:ListItem):void {
			sheet.addChild(item);
			item.y = lastY;
			
			content.push(item);
			lastY = content[content.length - 1].y + content[content.length - 1].height + 5;
			}
		//
		public function removeItem(item:ListItem):void {
			// TODO: допилить
			}
	}
}