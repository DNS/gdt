package game.city {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import game.gui.Tutorial;
	import game.utils.TutorialObject;
	import loader.LoadManager;
	
	public class HouseBase extends Sprite {
		
		private var currentImage		: Sprite;
		private var currentImageName	: String = "";
		private var _images				: Array;
		
		private var tutorObject			: TutorialObject;
		private var tutorialArrow		: Sprite;
		
		public function HouseBase() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			loadImages();
			}
		//
		public function loadImages():void {
			LoadManager.instance.loadImage(_images[0], onLoaded);
			}
		//
		private function onLoaded():void {
			trace("loaded");
			trace(LoadManager.instance.getImage(_images[0]));
			addChild(LoadManager.instance.getImage(_images[0]));
			}
		//
		public function setImages(imgs:Array):void {
			_images = imgs;
			}
		//
		public function click():void {
			
			}
		//
		public function tutorialAction(id:String, _align:String = "ALIGN_TOP", offset:int = 0):void {
			tutorObject = new TutorialObject(id, this, _align, offset);
			//
			Tutorial.instance.addPoint(tutorObject);
			}
	}
}