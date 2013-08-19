package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Linear;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import game.utils.GUIUtils;
	
	import org.bytearray.display.ScaleBitmapSprite;
	
	import silin.filters.ColorAdjust;
	
	import game.utils.TutorialObject;
	
	public class BaseButton extends Sprite {
		
		public var fixedWidth			: int = 0;
		
		private var bg					: ScaleBitmapSprite;
		private var label				: Bitmap;
		
		public var align				: String = GUIUtils.ALIGN_NONE;
		public var isActive				: Boolean = true;
		
		private var eventFunction		: Function = null;
		
		private var color				: ColorAdjust;
		
		private var tutorObject			: TutorialObject;
		private var tutorialArrow		: Sprite;
		
		private var icon				: Bitmap;
		
		public static const CLOSE_BTN	: String = "close_btn";
		
		public function BaseButton(_label:String, event:Function = null, _fixedWidth:int = 0) {
			fixedWidth = _fixedWidth;
			eventFunction = event;
			
			color = new ColorAdjust(ColorAdjust.CLEAR);
			//
			bg = new ScaleBitmapSprite(new ButtonBg(), new Rectangle(9, 9, 17, 17));
			addChild(bg);
			//
			if (_label == CLOSE_BTN) {
				icon = getIcon(_label);
				addChild(icon);
				icon.x = (fixedWidth / 2) - (icon.width / 2);
				icon.y = (fixedWidth / 2) - (icon.width / 2);
				//
				bg.width = fixedWidth > 0 ? fixedWidth : icon.width + 10;
				bg.height = icon.height + 10;
				//
				GUIUtils.setPosition(icon, GUIUtils.ALIGN_CENTER, 5);
				}else {
					label = GUIUtils.createBitmapTF(_label, GUIUtils.tfFormat(GUIUtils.MyriadProBoldFont, 0xFFFFFF, 14, GUIUtils.AUTOSIZE_LEFT, null, true), GUIUtils.getFilters([0]));
					addChild(label);
					//
					bg.width = fixedWidth > 0 ? fixedWidth : label.width + 10;
					bg.height = label.height + 5;
					//
					GUIUtils.setPosition(label, GUIUtils.ALIGN_CENTER, 5);
					}
			//
			mouseEnabled = true;
			buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			}
		//
		private function onOver(e:MouseEvent):void {
			color.saturation(2);
			filters = [color.filter];
			}
		//
		private function onOut(e:MouseEvent):void {
			filters = [];
			}
		//
		private function onDown(e:MouseEvent):void {
			color.saturation(0.5);
			filters = [color.filter];
			
			if (eventFunction != null) {
				eventFunction();
				}
			//
			if (tutorObject != null) {
				Tutorial.instance.nextAction(tutorObject.id);
				}
			}
		//
		private function onUp(e:MouseEvent):void {
			color.saturation(2);
			filters = [color.filter];
			}
		//
		public function set active(val:Boolean):void {
			isActive = val;
			//
			if (isActive) {
				mouseEnabled = true;
				buttonMode = true;
				addEventListener(MouseEvent.MOUSE_OVER, onOver);
				addEventListener(MouseEvent.MOUSE_OUT, onOut);
				addEventListener(MouseEvent.MOUSE_DOWN, onDown);
				addEventListener(MouseEvent.MOUSE_UP, onUp);
				filters = [];
				}else {
					mouseEnabled = false;
					buttonMode = false;
					removeEventListener(MouseEvent.MOUSE_OVER, onOver);
					removeEventListener(MouseEvent.MOUSE_OUT, onOut);
					removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
					removeEventListener(MouseEvent.MOUSE_UP, onUp);
					var matrix: Array = [0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0, 0, 0, 1, 0];
					filters = [new ColorMatrixFilter(matrix)];
					}
			}
		//
		public function onResize():void {
			if (align == GUIUtils.ALIGN_NONE) {
				return;
				}
			GUIUtils.setPosition(this, align);
			}
		//
		public function remove():void {
			removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			//
			bg.bitmapData.dispose();
			
			if (label) {
				label.bitmapData.dispose();
				removeChild(label);
				}
			
			if (icon) {
				icon.bitmapData.dispose();
				removeChild(icon);
				}
			
			removeChild(bg);
			}
		//
		private function getIcon(iconName:String):Bitmap {
			var iconBitmap:Bitmap = new Bitmap();
			//
			switch(iconName) {
				case CLOSE_BTN:
					iconBitmap.bitmapData = new PopupClose();
					break;
				}
			//
			return iconBitmap;
			}
		//
		public function tutorialAction(id:String, _align:String = "ALIGN_TOP", offset:int = 0):void {
			tutorObject = new TutorialObject(id, this, _align, offset);
			//
			Tutorial.instance.addPoint(tutorObject);
			}
		//
	}
}