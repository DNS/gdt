package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	import game.utils.Errors;
	import game.utils.GUIUtils;
	
	import game.gui.PopUpEnum;
	import game.gui.events.GUIEvent;
	
	public class PopupManager {
		
		private static var _instance	: PopupManager;
		
		private var tintLayer			: Shape;
		private var popupLayer			: Sprite;
		private var openPopUp			: PopUpBase;
		private var popups				: Vector.<PopUpBase> = new Vector.<PopUpBase>();
		
		public function PopupManager() { }
		//
		public static function get instance():PopupManager {
			if (!_instance) {
				_instance = new PopupManager();
				}
			return _instance;
			}
		//
		public function stageLayer(layer:Sprite):void {
			popupLayer = layer;
			popupLayer.visible = false;
			
			tintLayer = new Shape();
			tintLayer.graphics.beginFill(0x000000, 0.5);
			tintLayer.graphics.drawRect(0, 0, layer.stage.stageWidth, layer.stage.stageHeight);
			tintLayer.graphics.endFill();
			tintLayer.visible = false;
			popupLayer.addChild(tintLayer);
			}
		//
		public function showPopUp(popUp:Class):void {
			if (openPopUp != null) {
				trace("Popup is already opened");
				return;
				}
			
			openPopUp = new popUp();
			popupLayer.addChild(openPopUp);
			openPopUp.open();
			//
			if (openPopUp.tintStage) {
				tintLayer.visible = true;
				}
			//
			popupLayer.visible = true;
			//
			openPopUp.addEventListener(GUIEvent.POPUP_CLOSE, onClose);
			}
		//
		private function onClose(e:GUIEvent):void {
			openPopUp.remove();
			openPopUp = null;
			popupLayer.visible = false;
			tintLayer.visible = false;
			}
		//
		public function onResize():void {
			tintLayer.graphics.clear();
			tintLayer.graphics.beginFill(0x000000, 0.5);
			tintLayer.graphics.drawRect(0, 0, popupLayer.stage.stageWidth, popupLayer.stage.stageHeight);
			tintLayer.graphics.endFill();
			
			if (openPopUp) {
				openPopUp.x = (popupLayer.stage.stageWidth / 2) - (openPopUp.fixedWidth / 2);
				openPopUp.y = (popupLayer.stage.stageHeight / 2) - (openPopUp.fixedHeight / 2);
				}
			}
	}
}