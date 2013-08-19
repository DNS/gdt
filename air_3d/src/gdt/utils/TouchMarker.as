package gdt.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	
	public class TouchMarker extends Sprite {
		private var _marker:Bitmap;
		
		public function TouchMarker() {
			visible = false;
			_marker = new Bitmap(new TouchMarkerImg());
			addChild(_marker);
			}
		//
		public function sate(e:*):void {
			switch(e.type) {
				case MouseEvent.MOUSE_DOWN:
					visible = true;
					break;
				case MouseEvent.MOUSE_UP:
					visible = false;
					break;
				}
			}
	}
}