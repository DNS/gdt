package game.gui.popups {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.gui.BaseButton;
	import game.gui.events.GUIEvent;
	import game.gui.List;
	import game.gui.PopUpBase;
	import game.utils.GUIUtils;
	
	public class TestPopup extends PopUpBase {
		
		private var but			: BaseButton;
		private var butUnActive	: BaseButton;
		private var list		: List;
		
		public function TestPopup() {
			super.fixedWidth = 700;
			super.fixedHeight = 500;
			
			super.customBg = PopUpBase.DEFAULT_BG;
			}
		//
		override public function open():void {
			list = new List(this);
			list.topPadding = list.y = 10;
			add(list);
			
			/*but = new BaseButton("Label Button");
			addChild(but);
			GUIUtils.setPosition(but, GUIUtils.ALIGN_CENTER);
			
			butUnActive = new BaseButton("Label test");
			addChild(butUnActive);
			butUnActive.active = false;
			GUIUtils.setPosition(butUnActive, GUIUtils.ALIGN_CENTER);
			butUnActive.y = but.y + but.height + 10;*/
			//
			onOpen();
			}
		//
		private function onOpen():void {
			EventManager.instance.dispatchEvent(new GameEvent(GameEvent.TUTORIAL_EVENT, new EventParams(EventParams.TUTORIAL, "List")));
			}
		//
		override public function add(child:DisplayObject):void {
			child.x = lastX + innerPadding;
			child.y = lastY + innerPadding + 8;
			addChild(child);
			
			lastX += child.x + child.width;
			
			childsList.push(child);
			}
		//
		override public function br():void {
			lastY = childsList[childsList.length - 1].y + childsList[childsList.length - 1].height;
			}
		//
		override public function close():void {
			var closeEvent:GUIEvent = new GUIEvent(GUIEvent.POPUP_CLOSE);
			closeEvent.params = { closed:"TestPopup" };
			dispatchEvent(closeEvent);
			}
	}
}