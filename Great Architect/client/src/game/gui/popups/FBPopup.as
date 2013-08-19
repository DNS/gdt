package game.gui.popups {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import game.events.EventManager;
	import game.events.EventParams;
	import game.events.GameEvent;
	import game.gui.Alert;
	import game.gui.BaseButton;
	import game.gui.events.GUIEvent;
	import game.gui.List;
	import game.gui.PopUpBase;
	import game.gui.Tutorial;
	import game.utils.GUIUtils;
	import social.Social;
	import social.TypesEnum;
	
	import social.FacebookAPI;
	
	public class FBPopup extends PopUpBase {
		
		private var but			: BaseButton;
		private var but2		: BaseButton;
		private var but3		: BaseButton;
		
		public function FBPopup() {
			super.fixedWidth = 700;
			super.fixedHeight = 500;
			
			super.customBg = PopUpBase.DEFAULT_BG;
			}
		//
		override public function open():void {
			add(new BaseButton("Save photo", postPhoto, 120));
			add(new BaseButton("Send gift UI", sendGiftUI, 120));
			add(new BaseButton("Send gift", sendGift, 120));
			add(new BaseButton("Save photo", savePhoto, 120));
			
			var apBut:BaseButton = new BaseButton("apprequest", appreq, 120);
			add(apBut);
			
			closeButton.tutorialAction("CloseFBPopUp", GUIUtils.ALIGN_LEFT);
			
			onOpen();
			}
		//
		override public function add(object:DisplayObject):void {
			addChild(object);
			object.x = lastX + innerPadding;
			object.y = lastY + innerPadding;
			//
			lastX += (object as BaseButton).fixedWidth + 5;
			}
		//
		override public function br():void {
			lastX = 0;
			lastY += 35;
			}
		//
		private function onOpen():void {
			MonsterDebugger.log("onOpen FB");
			}
		//
		private function appreq():void {
			//Social.instance.appreq();
			}
		//
		private function savePhoto():void {
			Social.instance.savePhoto(stage);
			}
		//
		private function sendGiftUI():void {
			Social.instance.PostToWall("100001431786829", TypesEnum.SEND_GIFT, true, null);
			}
		//
		private function sendGift():void {
			Social.instance.PostToWall(Social.userId, TypesEnum.SEND_GIFT, false, null);
			}
		//
		private function postPhoto():void {
			/*var bitmap:Bitmap = new Bitmap();
			var bData:BitmapData = new BitmapData(500, 500);
			bData.draw(stage);
			bitmap.bitmapData = bData;
			
			var params:Object = { message:'Test photo', fileName:'FILE_NAME', image:bitmap };
			
			FacebookAPI.instance.uploadPhoto(params);*/
			}
		//
		override public function close():void {
			var closeEvent:GUIEvent = new GUIEvent(GUIEvent.POPUP_CLOSE);
			closeEvent.params = { closed:"TestPopup" };
			dispatchEvent(closeEvent);
			}
	}
}