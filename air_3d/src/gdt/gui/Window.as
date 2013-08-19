package gdt.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import gdt.assets.Asset;
	
	import gdt.assets.AssetsManager;
	import gdt.events.GUIEvents;
	import gdt.utils.iGraphic;
	import gdt.gui.*;
	import gdt.gui.buttons.*;
	
	public class Window extends Sprite {
		private var _asset		: Asset;
		public var _assetName	: String;
		
		private var bg			: *;
		private var closeButton	: SimplyButton;
		
		public function Window() {
			//
			}
		//
		public function init(assetName:String):void {
			_assetName = assetName;
			//_asset = Application.assets.getAsset(_assetName);
			
			createWindow();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		//
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			//
			
			}
		
		private function createWindow():void {
			bg = _asset.getContent();
			addChild(bg);
			//
			closeButton = new SimplyButton("window_close", GUIConfig.SIMPLY_BUTTON, GUIConfig.ALIGN_TOP_LEFT);
			closeButton.addEventListener(GUIEvents.BUTTON_CLICK, close);
			addChild(closeButton);
			}
		
		public function open():void {
			this.x = (GUI.parentStage.stageWidth / 2) - (this.width / 2);
			this.y = (GUI.parentStage.stageHeight / 2) - (this.height / 2);
			GUI.parentStage.addChild(this);
			}
		
		public function close(e:GUIEvents = null):void {
			destroy();
			}
		//
		public function disable():void {
			mouseEnabled = false;
			iGraphic.useDeactivateFilter(this);
			}
		public function enable():void {
			mouseEnabled = true;
			filters = [];
			}
		///////////////////////////////////
		private function destroy():void {
			closeButton.removeEventListener(GUIEvents.BUTTON_CLICK, close);
			closeButton.destroy();
			//
			if (bg is Bitmap) {
				(bg as Bitmap).bitmapData.dispose();
				}
			removeChild(bg);
			//
			var disp:GUIEvents = new GUIEvents(GUIEvents.WINDOW_CLOSE);
			disp.params = { window:this };
			dispatchEvent(disp);
			}
	}
}