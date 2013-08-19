package gdt.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import flash.display.Stage;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import gdt.gui.Button;//*
	import gdt.gui.Window;//*
	import gdt.gui.windows.MainWindow;//*
	import gdt.events.GUIEvents;
	
	import flash.system.System;
	
	public class GUI {
		private static var instance:GUI;
		//
		public static var parentStage:Stage;
		//
		
		// windows manager
		//public static const MAIN_WINDOW:Window = MainWindow as Window;
		//public static const LOAD_WINDOW:Class = "LOAD_WINDOW";
		
		public static var windowOpen	: Boolean = false;
		private static var openWindows	: Array = new Array();
		private static var widowsStack	: Array = new Array();
		//
		public function GUI() {
			
			}
		//
		public static function getInstance():GUI {
			if (!instance) {
				instance = new GUI();
				}
			return instance;
			}
		//
		private static function checkInstance():Boolean {
			return Boolean(instance);
			}
		//
		//
		/**
		* @param _stage
		* родительская stage на которую добавляются элементы GUI если не указан window
		*/ 
		public function setStage(_stage:Stage):void {
			parentStage = _stage;
			}
		//////////////////////////////////////////////////////////////////////////////
		
		/**
		* @param windowClass
		* класс окна (GUI.MAIN_WINDOW)
		* @param params
		* дополнительные параметры окна если надо (Object)
		*/ 
		public static function showWindow(windowClass:*, params:Object = null):void {
			var window:Window = new windowClass() as Window;
			
			/*if (params) {
				window.params = params;
				}*/
			window.addEventListener(GUIEvents.WINDOW_CLOSE, onWindowClose);
			
			widowsStack.push(window);
			
			// если есть открытые окна, делаем их не активными
			if (openWindows.length > 0) {
				var i:int;
				for (i = 0; i < openWindows.length; i++ ) {
					(openWindows[i] as Window).disable();
					}
				}
			
			window.open();
			openWindows.push(window);
			
			System.gc();
			}
		//
		
		private static function onWindowClose(e:GUIEvents):void {
			e.target.removeEventListener(GUIEvents.WINDOW_CLOSE, onWindowClose);
			parentStage.removeChild(e.params.window);
			
			var window:int = 0;
			while (openWindows.length > window) {
				if (openWindows[window] == e.params.window) {
					openWindows.splice(window, 1);
					window = 0;
					break;
					}
				window++
				}
			while (widowsStack.length > window) {
				if (widowsStack[window] == e.params.window) {
					widowsStack.splice(window, 1);
					break;
					}
				window++
				}
			
			System.gc();
			}
	}

}