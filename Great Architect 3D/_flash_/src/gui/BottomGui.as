package gui {
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import feathers.controls.Button;
	import feathers.display.Image;
	import feathers.display.Sprite;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.GUIUtils;
	
	public class BottomGui extends Sprite {
		
		public var fixedHeight	: int = 130;
		
		private var fon			: Quad;
		
		public function BottomGui() {
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			}
		//
		private function onAdded(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			//
			fon = new Quad(stage.stageWidth, fixedHeight, 0xC0C0C0);
			fon.alpha = 0.7;
			addChild(fon);
			//
			var testBut:Button = new Button();
			testBut.height = 30;
			testBut.label = "Test йцук";
			testBut.useHandCursor = true;
			testBut.addEventListener(Event.TRIGGERED, onClick);
			addChild(testBut);
			testBut.validate();
			//
			var testBut2:Button = new Button();
			testBut2.height = 30;
			testBut2.label = "kajshd 2";
			testBut2.useHandCursor = true;
			testBut2.addEventListener(Event.TRIGGERED, onClick);
			addChild(testBut2);
			testBut2.validate();
			//
			testBut2.y = testBut.height + 5;
			}
		//
		private function onClick(e:Event):void {
			
			}
		//
	}
}