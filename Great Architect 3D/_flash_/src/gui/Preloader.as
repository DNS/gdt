package gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import feathers.display.Image;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	import flash.utils.setTimeout;
	import flash.utils.setInterval;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import utils.ConstGUI;
	import utils.GUIUtils;
	
	public class Preloader extends Sprite {
		
		private var progressLineBg	: Image;
		private var progressLine	: Scale3Image;
		private var progressText	: TextField;
		
		public function Preloader() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		//
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			//
			progressLineBg = new Image(Texture.fromBitmap(GUIUtils.instance.graphics(ConstGUI.RECT, 250, 30, 0xFFFFFF)));
			progressLineBg.x = int((stage.stageWidth / 2) - (progressLineBg.width / 2));
			progressLineBg.y = int((stage.stageHeight / 2) - (progressLineBg.height / 2));
			addChild(progressLineBg);
			//
			var lineTexture:Scale3Textures = new Scale3Textures(Texture.fromBitmap(GUIUtils.instance.graphics(ConstGUI.RECT, 5, 30, 0x006AD5)), 2, 2, Scale3Textures.DIRECTION_HORIZONTAL);
			
			progressLine = new Scale3Image(lineTexture);
			progressLine.x = progressLineBg.x;
			progressLine.y = progressLineBg.y;
			addChild(progressLine);
			}
		//
		private function updateProgress(value:int):void {
			progressLine.width = int(Math.random() * 250 + 4);
			
			//progressLine.color = Math.random() * 0xFFFFFF;
			//progressLine.readjustSize();
			}
		//
	}
}