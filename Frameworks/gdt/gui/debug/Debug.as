package gdt.gui.debug {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import com.adobe.images.JPGEncoder;
	
	import gdt.gui.GUIConfig;
	
	import net.hires.debug.Stats;
	
	public class Debug extends Sprite {
		
		private var onShow:Boolean = true;
		
		private var showHide:Button;
		private var clear:Button;
		private var path:Button;
		private var log:Log;
		
		private var monitor:Stats;
		
		public function Debug() {
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			showHide = new Button("Show/Hide", show);
			addChild(showHide);
			showHide.x = stage.stageWidth - showHide.width - 5;
			showHide.y = 5;
			
			clear = new Button("Clear", clearLog);
			addChild(clear);
			clear.x = showHide.x - clear.width - 5;
			clear.y = 5;
			
			path = new Button("Save file", getPaths);
			addChild(path);
			path.x = clear.x - path.width - 5;
			path.y = 5;
			
			log = new Log(stage.stageWidth - 200, 300);
			log.x = stage.stageWidth - log.width - 5;
			log.y = showHide.height + 10;
			addChild(log);
			
			monitor = new Stats();
			addChild(monitor);
			
			}
		//
		private function getPaths():void {
			var bitm:Bitmap = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false));
			bitm.bitmapData.draw(stage); 
			
			
			var jpg:JPGEncoder = new JPGEncoder(100);
			
			addLog("File.documentsDirectory: " + (uint(File.documentsDirectory.spaceAvailable / 1048576))+" Mb");
			var file:File = File.documentsDirectory;
			file = file.resolvePath("Air_3d/" + String(int(Math.random() * 9999)) + ".jpg");
			
			var rawBytes:ByteArray = new ByteArray();
			rawBytes.writeBytes(jpg.encode(bitm.bitmapData));
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(rawBytes);
			fileStream.close();
			}
		//
		private function show():void {
			onShow = !onShow;
			clear.visible = onShow;
			path.visible = onShow;
			log.visible = onShow;
			monitor.visible = onShow;
			}
		//
		private function clearLog():void {
			log.clear();
			}
		//
		public function addLog(text:*):void {
			log.add(text);
			}
	}
}