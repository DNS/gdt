package main
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import game.MatchThree;
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class Main extends Sprite {
		public var gemSize:int = 64;
		//
		public var _gameScore:TextField;
		public var _game:MatchThree;
		
		private var startBot:Sprite;
		
		private static var instance:Main;
		public static function getInstance():Main {
			return instance; 
		}
		//
		public function Main():void	{
			instance = this;
			//
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			
			// entry point
			_gameScore = new TextField();
			_gameScore.width = 200;
			_gameScore.defaultTextFormat = new TextFormat("CooperBlackStd", 16, 0xFFFFFF);
			addChild(_gameScore);
			//
			_game = new MatchThree();
			addChild(_game);
			_game.startMatchThree();
			//
			_game.x = -50;
			_game.y = -50;
			//
			_gameScore.y = _game.height + 20;
		}
		//
		
	}
}