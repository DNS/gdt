package server {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.events.NetStatusEvent;
	import game.GlobalConfig;
	 
	public class Amf {
		private var nc : NetConnection = new NetConnection();
		
		
		public function Amf() {
			nc.connect(GlobalConfig.server + GlobalConfig.amf);
			nc.objectEncoding = 3;
			nc.addEventListener(NetStatusEvent.NET_STATUS, onStatus);
			}
		
		private function onStatus(e:NetStatusEvent):void {
			trace("NetStatusEvent: " + e.info.code);
			}
		
		public  function toamf(wht:String, cb:Function, ... args) : void {
			var resp:Responder = new Responder(cb, onFault);
			nc.call.apply(null, [wht, resp].concat(args));
			} 	
		
		private function onFault(res:Object):void {
			var str:String;
			for (var p:String in res) {
				str += p + " = " + res[p] + ", ";
				}
			trace("onFault: " + str);
			}
	}
}