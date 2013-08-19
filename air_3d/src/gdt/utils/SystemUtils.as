package gdt.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.system.System;
	import flash.utils.setInterval;
	import flash.utils.SetIntervalTimer;
	import flash.utils.setTimeout;
	
	public class SystemUtils {
		private static var gcTimer		: uint;
		private static var gcTimeOut	: int;
		
		public function SystemUtils() {
			
			}
		//
		public static function GCTimer(time:int = 3000):void {
			gcTimeOut = time;
			gcTimer = setTimeout(onGCTime, time);
			}
		//
		private static function onGCTime():void {
			System.gc();
			gcTimer = setTimeout(onGCTime, gcTimeOut);
			//Application.addLog("System.gc()");
			}
	}
}