package social.params {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	//import src.remoting.objects.UserObj;
	import social.FacebookAPI;
	import social.TypesEnum;
	//import src.util.Global;
	
	public class FacebookParams {
		
		private static var users:*;
		
		public function FacebookParams() {
			//
			}
		//
		public static function getUIParams(type:String, user:* = null, args:Array = null):Object {
			users = user;
			var params:Object = { };
			//
			switch(type) {
				case TypesEnum.APP_REQUESTS:
					params.to = "100001431786829";
					params.title  = "APP_REQUESTS TITLE";
					params.message = "APP_REQUESTS TEXT";
					break;
				case TypesEnum.WALL_POST:
					//
					break;
				case TypesEnum.SEND_GIFT:
					params.app_id = FacebookAPI.APP_ID;
					params.from = FacebookAPI.FACEBOOK_ID;
					params.to = getUsers(type);
					params.link = "http://www.link.ua/";
					params.picture = image(type);
					params.source = ""; // priority, must be NULL!
					params.name = "Name";
					params.caption = "Caption";
					params.description = description(type);
					//params.properties = { text:"Text", href:"Href" };// "Array[Object{text, href}]";
					params.actions = [ { name:"actionText", link:"http://www.ex.ua/" } ];// "Array[Object{name, link}]";
					break;
				}
			
			//
			return params;
			}
		//
		public static function getParams(type:String, user:* = null, args:Array = null):Object {
			users = user;
			var params:Object = { };
			//
			switch(type) {
				case TypesEnum.WALL_POST:
					//
					break;
				case TypesEnum.SEND_GIFT:
					params.message = "Message";
					params.link = "http://www.link.ua/";
					params.picture = image(type);
					params.name  = "http://www.link.ua/";
					params.caption = "Caption"
					params.description = "Description"; // priority, must be NULL!
					params.actions = [ { name:"actionText", link:"http://www.ex.ua/" } ];
					params.access_token = FacebookAPI.ACCESS_TOKEN;
					//params.place = "place";
					//params.tags = description(type);
					//params.privacy  = { text:"Text", href:"Href" };// "Array[Object{text, href}]";
					//params.object_attachment  = 
					break;
				}
			
			//
			return params;
			}
		//
		private static function getUsers(type:String):String {
			var usersString:String = "";
			if (users is Array) {
				
				}
			//if (users is UserObj) {
				//usersString = (users as UserObj).m_UserVO.FacebookID;
				//}
			//
			return "100001431786829";// usersString;
			}
		//
		private static function description(type:String):String {
			var text:String = "";
			switch(type) {
				case TypesEnum.SEND_GIFT:
					text = "Глаша  has sent Лопата  a gift!";//Global.Instance.UserObj.m_UserVO.FirstName + " has sent " + (users as UserObj).m_UserVO.FirstName + " a gift";
					break;
				}
			return text;
			}
		//
		private static function image(type:String):String {
			var image:String = "";
			switch(type) {
				case TypesEnum.SEND_GIFT:
					image = "http://facebook.toonups.com/apps/abetterworld/images/wallicons/minigames/PositivePuzzler_WallIcon.png";// "giftsentthumb.jpg";
					break;
				}
			return image;
			}
	}
}