package gdt.events {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.Event;
	import gdt.assets.Asset;
	
	public class AssetsManagerEvents extends Event {
		public static const ALL_ASSETS_LOADED	: String = "ASSETS_LOADED";
		public static const ASSET_LOADED		: String = "ASSET_LOADED";
		public static const GUI_ASSETS_LOADED	: String = "GUI_ASSETS_LOADED";
		public static const GAME_ASSETS_LOADED	: String = "GAME_ASSETS_LOADED";
		public static const ASSETS_NEED_LOADED	: String = "ASSETS_NEED_LOADED";
		
		private var _asset:Asset = null;
		
		public function AssetsManagerEvents(type:String, asset:Asset = null) { 
			super(type);
			_asset = asset;
			} 
		
		public override function clone():Event  {
			return new AssetsManagerEvents(type, _asset);
			}
		
		public override function toString():String {
			return formatToString( "AssetsManagerEvents", "type", "bubbles", "cancelable", "eventPhase", "asset");
			}
		
		public function get asset():Asset {
			return _asset;
			}
	}
}