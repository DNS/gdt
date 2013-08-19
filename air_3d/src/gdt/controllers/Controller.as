package gdt.controllers {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.ui.Mouse;
	
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.events.PressAndTapGestureEvent;
	import flash.events.TouchEvent;
	import flash.events.GesturePhase;
	import flash.events.TransformGestureEvent;
	
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import gdt.utils.TouchMarker;
	import gdt.gui.debug.Debug;
	
	public class Controller extends EventDispatcher	{
		public static const DESKTOP	: String = "DESKTOP";
		public static const TOUCH	: String = "TOUCH";
		
		public static var typeInput	: String = "NONE";
		
		public var x:int = 0;
		public var y:int = 0;
		
		public static var _debug	: Boolean = false;
		private var _marker			: TouchMarker;
		
		public function Controller() {
			
			}
		//
		public function set debug(val:Boolean):void {
			_debug = val;
			}
		//
		public function set inputType(type:String):void {
			typeInput = type;
			}
		//
		public function init():void {
			switch(typeInput) {
				case Controller.DESKTOP:
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);// Хз
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_UP, onClick);
					
					/*Application.gui.stage.addEventListener(MouseEvent.CLICK, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.CONTEXT_MENU, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.DOUBLE_CLICK, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_OUT, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_OVER, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_UP, onMouse);
					Application.gui.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouse);*/
					break;
				case Controller.TOUCH:
					if (Multitouch.supportsGestureEvents) {
						Application.gui.stage.addEventListener(MouseEvent.MOUSE_DOWN, onClick);// Хз
						//Application.gui.stage.addEventListener(MouseEvent.MOUSE_MOVE, onClick);
						Application.gui.stage.addEventListener(MouseEvent.MOUSE_UP, onClick);
						
						Multitouch.inputMode = MultitouchInputMode.GESTURE;
						Application.gui.stage.addEventListener(PressAndTapGestureEvent.GESTURE_PRESS_AND_TAP, onGesturePressAndTap);
						Application.gui.stage.addEventListener(TransformGestureEvent.GESTURE_PAN, onGestureTransform);
						Application.gui.stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onGestureTransform);
						Application.gui.stage.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onGestureTransform);
						Application.gui.stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onGestureTransform);
						}else {
							Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
							Application.gui.stage.addEventListener(TouchEvent.TOUCH_END, onTouch);
							Application.gui.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouch);
							Application.gui.stage.addEventListener(TouchEvent.TOUCH_TAP, onTouch);
							}
					break;
				}
			//
			if (_debug) {
				_marker = new TouchMarker();
				Application.debug.addChild(_marker);
				}
			}
		//
		// Touch
		private function onTouch(e:TouchEvent):void {
			Application.addLog(e);
			}
		
		private function onGesture(e:GestureEvent):void {
			Application.addLog(e);
			}
		
		private function onGesturePressAndTap(e:PressAndTapGestureEvent):void {
			Application.addLog(e);
			}
		
		private function onGestureTransform(e:TransformGestureEvent):void {
			Application.addLog(e);
			}
		
		private function onClick(e:MouseEvent):void {
			if (e.type == MouseEvent.MOUSE_DOWN) {
				Application.gui.stage.addEventListener(MouseEvent.MOUSE_MOVE, onClick);
				}
			if (e.type == MouseEvent.MOUSE_UP) {
				Application.gui.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onClick);
				}
			if (e.type == MouseEvent.MOUSE_MOVE) {
				
				}
			
			x = e.stageX;
			y = e.stageY;
			
			//Application.addLog(e);
			if (_debug) {
				marker(e);
				}
			}
		
		// Mouse
		private function onMouse(e:MouseEvent):void {
			//Application.addLog(e);
			}
		
		//
		private function marker(e:*):void {
			_marker.sate(e);
			_marker.x = x - _marker.width / 2;
			_marker.y = y - _marker.height / 2;
			}
	}
}