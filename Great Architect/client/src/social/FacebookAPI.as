package social {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.facebook.graph.Facebook;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import game.gui.Alert;
	import social.params.FacebookParams;
	//import src.util.Global;
	
	public class FacebookAPI extends EventDispatcher {
		
		public static const SCOPE		: String = "user_about_me, user_birthday, user_photos, user_status, email, read_stream, publish_stream, status_update, share_item, read_friendlists, read_requests, publish_checkins";
		
		public static var APP_ID		: String = "";
		public static var FACEBOOK_ID	: String = "";
		public static var ACCESS_TOKEN	: String = "";
		
		public function FacebookAPI() {
			
			}
		//
		public function init(app_id:String):void {
			APP_ID = app_id;
			log("init: " + APP_ID, 0, true);
			Facebook.init(APP_ID, onInit, { status:true, cookie:true, oauth:true });
			}
		//
		private function onInit(success:Object, fail:Object):void {
			log("onInit", 0, true);
			if (success != null) { log(success); } else { log(fail, 1); }
			//
			if (success) {
				ACCESS_TOKEN = success.accessToken;
				FACEBOOK_ID = success.uid;
				}
			if (fail) {
				Alert.instance.showAlert([Alert.ALERT_OK], "Init", "init fail, restart!");
				return;
				}
			//
			Facebook.login(onLogin, { scope:"" } );
			//loadFriends();
			}
		//
		private function onLogin(success:Object, fail:Object):void {
			log("onLogin", 0, true);
			if (success != null) { log(success); } else { log(fail, 1); }
			//
			if (success) {
				loadFriends();
				}
			if (fail) {
				Alert.instance.showAlert([Alert.ALERT_OK], "Login", "fail");
				return;
				}
			}
		//
		public function loadFriends():void {
			var params:Object = { };
			var fields:String = "installed, name, picture";
			params.fields = fields;
			params.limit = 5000;
			params.access_token = ACCESS_TOKEN;
			
			Facebook.api("me/friends", onCallBack, params);
			}
		//
		public function save(st:Stage):void {
			var bitm:Bitmap = new Bitmap();
			var bData:BitmapData = new BitmapData(200, 200);
			bData.draw(st, null, null, null, new Rectangle(0, 0, 200, 200));
			bitm.bitmapData = bData;
			
			/*var params:Object = { };
			params.source = bitm;
			params.message = "...";
			params.no_story = "1";
			params.filename = "FILE_NAME";*/
			
			var params:Object = { message:"...", fileName:'FILE_NAME', image:bitm, no_story:1 };
			
			Facebook.postData("me/photos", onCallBack, params);
			}
		//
		public function requestUI():void {
			var params:Object = FacebookParams.getUIParams(TypesEnum.APP_REQUESTS);
			Facebook.ui("apprequests", params, onCallBack, "iframe");
			}
		//
		public function wallPost(type:String, user:*, UI:Boolean = true, args:Array = null):void {
			var params:Object = { };
			//
			if (UI) {
				params = FacebookParams.getUIParams(type, user, args);
				Facebook.ui("feed", params, onCallBack, "dialog");
				}else {
					params = FacebookParams.getParams(type, user, args);
					log(params, 2);
					Facebook.postData("me/feed/", onCallBack, params);
					}
			}
		//
		public function onCallBack(success:Object, fail:Object = null):void {
			log(success, 0, true);
			if (success != null) { log(success); } else { log(fail, 1); }
			//
			
			}
		//
		private function log(data:*, type:int = 0, br:Boolean = false):void {
			if (br) {
				MonsterDebugger.trace(this, data, "Danil", "----");
				return;
				}
			
			var color:uint = 0x000000;
			var label:String = ""
			switch(type) {
				case 0:
					color = 0x008000;
					label = "Result";
					break;
				case 1:
					color = 0xBB0000;
					label = "Error";
					break;
				case 2:
					color = 0xEC4D00;
					label = "Send data";
					break;
				}
			
			MonsterDebugger.trace(this, data, "Danil", label, color);
			}
	}
}