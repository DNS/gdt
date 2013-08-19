package gdt.gui.buttons {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.MouseEvent;
	import flash.events.ScreenMouseEvent;
	
	import gdt.events.EventsManager;
	import gdt.events.GUIEvents;
	import gdt.gui.GUI;
	import gdt.gui.GUIConfig;
	
	import gdt.assets.AssetsManager;
	import gdt.assets.Asset;
	
	public class SimplyButton extends Sprite {
		private var type			: String;
		private var align			: String;
		private var asset			: Asset;
		private var clickEvent		: String;
		
		private var buttonSource	: * ;
		private var buttonShape		: Sprite;
		private var customAction	: Function = null;
		
		public var padding			: int = 5;
		
		/**
		* @param assetName
		* Имя актива для кнопки
		* @param _type
		* Тип кнопки: ButtonsSettings.SIMPLY_BUTTON - просто кнопка; ...
		* @param _align
		* Выравнивание кнопки в окне
		* @param _customAction
		* Дополнительный action для кнопки
		*/
		public function SimplyButton(assetName:String, _type:String = GUIConfig.SIMPLY_BUTTON, _align:String = GUIConfig.ALIGN_NONE, _customAction:Function = null) {
			type = _type;
			align = _align;
			//asset = Application.assets.getAsset(assetName);
			
			init();
			}
		//
		private function init():void {
			buttonSource = asset.getContent();
			addChild(buttonSource);
			
			buttonShape = new Sprite();
			buttonShape.graphics.beginFill(0x000000, 0);
			buttonShape.graphics.drawRect(0, 0, buttonSource.width, buttonSource.height);
			buttonShape.graphics.endFill();
			buttonShape.cacheAsBitmap = true;
			addChild(buttonShape);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		//
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			GUIConfig.setPosition(this);
			//
			actionByType();
			}
		
		private function actionByType():void {
			switch(type) {
				case GUIConfig.SIMPLY_BUTTON:
					
					break;
				}
			//
			switch(AssetsManager.getPlatform) {
				case AssetsManager.DESKTOP:
					buttonMode = true;
					addEventListener(MouseEvent.CLICK, onClick);
					clickEvent = MouseEvent.CLICK;
					break;
				case AssetsManager.ANDROID:
				case AssetsManager.ANDROID_TAB:
					addEventListener(TouchEvent.TOUCH_TAP, onClick);
					clickEvent = TouchEvent.TOUCH_TAP;
					break;
				}
			}
		//
		public function get getAlign():String {
			return align;
			}
		//
		private function onClick(e:*):void {
			dispatchEvent(new GUIEvents(GUIEvents.BUTTON_CLICK));
			}
		//
		public function destroy():void {
			removeEventListener(clickEvent, onClick);
			//
			if (buttonSource is Bitmap) {
				(buttonSource as Bitmap).bitmapData.dispose();
				}
			removeChild(buttonShape);
			removeChild(buttonSource);
			this.parent.removeChild(this);
			}
	}
}