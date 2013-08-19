package game.gui {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.events.EventManager;
	import game.utils.GUIUtils;
	import org.bytearray.display.ScaleBitmapSprite;
	
	public class Alert extends Sprite {
		
		private static var _instance	: Alert;
		
		public static const DEFAULT_BG	: String = "PopupBg";
		
		public static const ALERT_YES	: String = "alert_yes";
		public static const ALERT_NO	: String = "alert_no";
		public static const ALERT_OK	: String = "alert_ok";
		
		public static const ALERT_OPEN	: String = "alert_open";
		public static const ALERT_CLOSE	: String = "alert_close";
		
		private static var tintLayer	: Shape;
		private static var alertLayer	: Sprite;
		
		private static var customBg		: String = DEFAULT_BG;
		
		private var alert				: Sprite;
		private var bgData				: BitmapData;
		private var bgRect				: Rectangle;
		private var bg					: ScaleBitmapSprite;
		private var innerPadding		: int;
		
		private var titleBitmap			: Bitmap;
		private var textBitmap			: Bitmap;
		
		private var but1				: BaseButton;
		private var but2				: BaseButton;
		
		private var callBack			: Function;
		
		public function Alert() {
			
			}
		//
		public static function get instance():Alert {
			if (!_instance) {
				_instance = new Alert();
				}
			return _instance;
			}
		//
		public function stageLayer(layer:Sprite):void {
			alertLayer = layer;
			alertLayer.visible = false;
			
			tintLayer = new Shape();
			tintLayer.graphics.beginFill(0x000000, 0.5);
			tintLayer.graphics.drawRect(0, 0, layer.stage.stageWidth, layer.stage.stageHeight);
			tintLayer.graphics.endFill();
			tintLayer.visible = false;
			alertLayer.addChild(tintLayer);
			}
		/**
		 * Массив [Alert.ALERT_YES, ...] не больше двух!
		 * @param	type
		 * @param	title
		 * @param	text
		 * @param	callback
		 */
		public function showAlert(type:Array, title:String, text:String, callback:Function = null):void {
			tintLayer.visible = true;
			alertLayer.visible = true;
			//
			switch(customBg) {
				case DEFAULT_BG:
					bgData = new PopupBg();
					bgRect = new Rectangle(30, 30, 240, 240);
					innerPadding = 30;
					break;
				}
			//
			alert = new Sprite();
			//
			bg = new ScaleBitmapSprite(bgData, bgRect);
			bg.width = 300;
			bg.height = 300;
			alert.addChild(bg);
			alertLayer.addChild(alert);
			//
			titleBitmap = GUIUtils.createBitmapTF(title, GUIUtils.tfFormat(GUIUtils.MyriadProBoldFont, 0x0059B3, 23, GUIUtils.AUTOSIZE_LEFT, null, true), GUIUtils.getFilters([1,0]));
			alert.addChild(titleBitmap);
			//
			textBitmap = GUIUtils.createBitmapTF(text, GUIUtils.tfFormat(GUIUtils.MyriadProFont, 0x0059B3, 16, GUIUtils.AUTOSIZE_NONE, GUIUtils.TEXT_ALIGN_CENTER, true), null, bgRect.width, bgRect.height - titleBitmap.height - innerPadding, false, true);
			alert.addChild(textBitmap);
			//
			GUIUtils.setPosition(titleBitmap, GUIUtils.ALIGN_TOP_CENTER, innerPadding);
			GUIUtils.setPosition(textBitmap, GUIUtils.ALIGN_TOP_CENTER, titleBitmap.height + innerPadding);
			//
			bg.height = titleBitmap.height + textBitmap.height + (innerPadding * 2) + 35;
			trace(titleBitmap.height, textBitmap.height)
			//
			if (type.length == 1) {
				but1 = new BaseButton(buttonLable(type[0]), onPositive, 80);
				alert.addChild(but1);
				GUIUtils.setPosition(but1, GUIUtils.ALIGN_BOTTOM_CENTER, innerPadding);
				}else {
					but1 = new BaseButton(buttonLable(type[0]), onPositive, 80);
					but2 = new BaseButton(buttonLable(type[1]), onNegative, 80);
					alert.addChild(but1);
					alert.addChild(but2);
					GUIUtils.setPosition(but1, GUIUtils.ALIGN_BOTTOM_CENTER, innerPadding);
					GUIUtils.setPosition(but2, GUIUtils.ALIGN_BOTTOM_CENTER, innerPadding);
					but1.x = ((alert.width / 2) / 2) - (but1.width / 2) + innerPadding;
					but2.x = ((alert.width / 2) / 2) - (but1.width / 2) + (alert.width / 2) - innerPadding;
					}
			//
			GUIUtils.setPosition(alert, GUIUtils.ALIGN_CENTER);
			//
			if (callback != null) {
				callBack = callback;
				}
			}
		//
		private function onPositive():void {
			if (callBack != null) { callBack(ALERT_YES); }
			//
			closeAlert();
			}
		//
		private function onNegative():void {
			if (callBack != null) { callBack(ALERT_NO); }
			//
			closeAlert();
			}
		//
		/**
		 * 
		 * @param	event
		 * @param	forAll
		 */
		public function dispatchAlertEvent(event:String, forAll:Boolean = false):void {
			dispatchEvent(new Event(event, false, true));
			if (forAll) {
				// TODO: EventManager.instance.dispatchEvent("bla bla bla");
				}
			}
		//
		private function buttonLable(value:String):String {
			var lable:String = "";
			switch(value) {
				case ALERT_YES:
					lable = "Yes"; // TODO: Язык и все такое.
					break;
				case ALERT_NO:
					lable = "No"; // TODO: Язык и все такое.
					break;
				case ALERT_OK:
					lable = "OK"; // TODO: Язык и все такое.
					break;
				}
			return lable;
			}
		//
		public function closeAlert():void {
			dispatchAlertEvent(ALERT_CLOSE);
			//
			tintLayer.visible = false;
			alertLayer.visible = false;
			//
			bg.bitmapData.dispose();
			alert.removeChild(bg);
			//
			but1.remove();
			alert.removeChild(but1);
			if (but2 != null) { but2.remove(); alert.removeChild(but2); }
			but1 = null;
			but2 = null;
			//
			titleBitmap.bitmapData.dispose();
			alert.removeChild(titleBitmap);
			titleBitmap = null;
			//
			textBitmap.bitmapData.dispose();
			alert.removeChild(textBitmap);
			textBitmap = null;
			//
			alertLayer.removeChild(alert);
			alert = null;
			}
		//
		public function onResize():void {
			tintLayer.graphics.clear();
			tintLayer.graphics.beginFill(0x000000, 0.5);
			tintLayer.graphics.drawRect(0, 0, alertLayer.stage.stageWidth, alertLayer.stage.stageHeight);
			tintLayer.graphics.endFill();
			//
			if (alert) {
				GUIUtils.setPosition(alert, GUIUtils.ALIGN_CENTER);
				}
			}
	}
}