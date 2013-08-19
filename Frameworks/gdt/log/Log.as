package gdt.log {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	import flash.utils.getTimer;
	
	import gdt.gui.GUIConfig;
	import gdt.gui.buttons.Button;
	import gdt.connection.Connection;
	
	import net.hires.debug.Stats;
	
	public class Log extends Sprite {
		
		private var sizeW:int = 100;
		private var sizeH:int = 50;
		
		private var HEADER_LOG	: int = 0;
		private var MAX_LOG		: int = 100;
		private var _log		: Vector.<String> = new Vector.<String>();
		
		private var fon			: Sprite;
		
		private var textF		: TextField = new TextField();
		private var newLine		: Boolean = false;
		
		private var hideShow	: Button;
		private var enableSave	: Button;
		private var _onStage	: Boolean = false;
		public var saveLogF		: Boolean = false;
		
		private var monitor		: Stats;
		
		public function Log(onStage:Boolean = false) {
			_onStage = onStage;
			
			if (_onStage) { addEventListener(Event.ADDED_TO_STAGE, addToStage); }
			}
		//
		private function addToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addToStage)
			
			var _width:int = parent.stage.stageWidth / 100 * sizeW;
			var _height:int = parent.stage.stageHeight / 100 * sizeH;
			
			fon = new Sprite();
			fon.graphics.beginFill(0x000000, 0.5);
			fon.graphics.drawRect(0, 0, _width , _height);
			fon.graphics.endFill();
			fon.mouseEnabled = false;
			addChild(fon);
			
			textF.width = _width;
			textF.height = _height;
			textF.embedFonts = true;
			textF.defaultTextFormat = new TextFormat(new Calibri().fontName, 12, 0xFFFFFF, true);
			textF.wordWrap = true;
			textF.multiline = true;
			textF.borderColor = 0xFFFFFF;
			textF.border = true;
			textF.selectable = false;
			textF.mouseEnabled = false;
			addChild(textF);
			//
			hideShow = new Button("Log", GUIConfig.tfFormat(GUIConfig.CalibriFont, 0xFFFFFF, 18, GUIConfig.AUTOSIZE_LEFT, false), new Button1(), { x:2, y:2, w:4, h:4 }, showHideLog);
			addChild(hideShow);
			hideShow.x = 5;// textF.width - hideShow.width - 5;
			hideShow.y = textF.y + 5;
			hideShow.alpha = 0.4;
			
			/*enableSave = new Button("Log save", GUIConfig.tfFormat(GUIConfig.CalibriFont, 0xFFFFFF, 12, GUIConfig.AUTOSIZE_LEFT, false), new Button1(), { x:2, y:2, w:4, h:4 }, saveBool);
			addChild(enableSave);
			enableSave.x = hideShow.width + hideShow.x + 5;
			enableSave.y = textF.y + 5;*/
			
			monitor = new Stats();
			monitor.y = _height;
			addChild(monitor);
			
			mouseEnabled = false;
			
			showHideLog();
			}
		//
		private function saveBool():void {
			saveLogF = !saveLogF;
			add("Save log: " + (saveLogF ? "enabled" : "disabled"));
			}
		//
		public function add(val:String):void {
			if (val == "head_end") { HEADER_LOG = textF.numLines + 1; val = "#####################################"; }
			if (val.search("{time}") > 0) { 
				var time:Date = new Date();
				val = val.replace("{time}", ", time: " + time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
				time = null;
				}
			
			if (val.search("{timer}") > 0) { 
				val = val.replace("{timer}", ", timer: " + getTimer());
				}
			
			if (_log.length >= MAX_LOG - HEADER_LOG) {
				_log.splice(HEADER_LOG, 1);
				}
			
			_log.push("\n" + val);
			
			textF.appendText((newLine ? "\n":"") + val);
			textF.scrollV = textF.numLines;
			
			newLine = true;
			}
		//
		public function clear():void {
			textF.text = "";
			}
		//
		public function saveLog():void {
			var toJSON:Object = JSON.stringify(_log);
			Connection.instance.send(Connection.SAVE_LOG, { log:toJSON } );
			}
		//
		private function showHideLog():void {
			textF.visible = fon.visible = monitor.visible = !textF.visible;
			}
	}
}