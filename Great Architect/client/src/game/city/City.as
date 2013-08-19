package game.city {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.city.house.TestHouse;
	
	import game.events.EventManager;
	import game.events.GameEvent;
	import game.utils.GUIUtils;
	
	import loader.ItemsManager;
	import loader.LoadManager;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import com.greensock.events.TweenEvent;
	import com.greensock.plugins.*;
	
	public class City extends Sprite {
		
		private var points			: Vector.<Point> = new Vector.<Point>();// TODO: from server!
		private var houses			: Vector.<HouseBase> = new Vector.<HouseBase>();
		
		public var align			: String = GUIUtils.ALIGN_CENTER;
		
		private var tween			: TweenLite;
		
		private var zoom			: Number = 1;
		private var lastMousePoint	: Point = new Point();
		private var centerPoint		: Point = new Point();
		
		private var bg				: Sprite;
		private var housesL			: Sprite;
		
		private var cp				: Sprite = GUIUtils.point();
		
		public function City() {
			TweenPlugin.activate([ShortRotationPlugin, TransformAroundPointPlugin]);
			
			points.push(new Point(120, 120));
			points.push(new Point(200, 500));
			points.push(new Point(490, 930));
			points.push(new Point(600, 300));
			points.push(new Point(780, 650));
			points.push(new Point(1100, 750));
			points.push(new Point(1000, 240));
			points.push(new Point(1250, 350));
			points.push(new Point(1500, 450));
			points.push(new Point(1550, 140));
			points.push(new Point(1750, 970));
			
			houses.push(new TestHouse());
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			}
		//
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			housesL = new Sprite();
			//
			bg = new Sprite();
			bg.graphics.beginFill(0xFFFF00);
			bg.graphics.drawRect(0, 0, 1, 1);
			bg.graphics.endFill();
			addChild(bg);
			//
			bg.addChild(housesL);
			//
			lastMousePoint = globalToLocal(new Point(root.stage.stageWidth / 2, root.stage.stageHeight / 2));
			centerPoint = new Point(root.stage.stageWidth / 2, root.stage.stageHeight / 2);
			//
			//addHouses();
			visible = false;
			}
		//
		private function addHouses():void {
			var i:int;
			for (i = 0; i < houses.length; i++) {
				var house:HouseBase = houses[i];
				housesSprite.addChild(house);
				house.loadImages();
				house.x = points[i].x;
				house.y = points[i].y;
				}
			}
		//
		public function open():void {
			if (bg.numChildren > 1) {
				bg.addChild(LoadManager.instance.getImage(ItemsManager.cityBg));
				}
			//
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(MouseEvent.MOUSE_UP, onUp);
			addEventListener(MouseEvent.MOUSE_WHEEL, onZoom);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			//
			EventManager.instance.addEventListener(GameEvent.CITY_TO_POINT, toPointEvent);
			//
			setCenter();
			//
			visible = true;
			}
		//
		public function close():void {
			removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
			removeEventListener(MouseEvent.MOUSE_UP, onUp);
			removeEventListener(MouseEvent.MOUSE_WHEEL, onZoom);
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			//
			EventManager.instance.removeEventListener(GameEvent.CITY_TO_POINT, toPointEvent);
			//
			GUIUtils.GC();
			visible = false;
			}
		//
		private function onDown(e:MouseEvent):void {
			if (tween) { tween.kill(); }
			if (bg.width == root.stage.stageWidth && bg.height == root.stage.stageHeight) { return; }
			bg.startDrag();
			}
		//
		private function onUp(e:MouseEvent):void {
			bg.stopDrag();
			lastMousePoint = globalToLocal(new Point(root.stage.stageWidth / 2, root.stage.stageHeight / 2));
			}
		//
		private function onZoom(e:MouseEvent):void {
			if (e.delta > 0) {
				if (zoom >= 1.8) { return; }
				zoom = zoom + 0.2;
				TweenLite.to(bg, 0.3, { transformAroundPoint: { point:lastMousePoint, scaleX:zoom, scaleY:zoom }, ease:Quad.easeOut } );
				}else {
					if (zoom == 1) { return; }
					zoom = zoom - 0.2;
					TweenLite.to(bg, 0.3, { transformAroundPoint: { point:lastMousePoint, scaleX:zoom, scaleY:zoom }, ease:Quad.easeOut } );
					}
			}
		//
		private function enterFrame(e:Event):void {
			var newPos:Point = maxMin(bg.x, bg.y);
			bg.x = newPos.x;
			bg.y = newPos.y;
			}
		//
		private function maxMin(_x:int, _y:int):Point {
			var rect:Rectangle = new Rectangle(0, 0, root.stage.stageWidth, root.stage.stageHeight);
			var maxX:int = bg.width - rect.width;
			var maxY:int = bg.height - rect.height;
			if (_x > 0) { _x = 0; }
			if (_x < -maxX) { _x = -maxX; }
			if (_y > 0) { _y = 0; }
			if (_y < -maxY) { _y = -maxY; }
			return new Point(_x, _y);
			}
		//
		private function toPointEvent(e:GameEvent):void {
			//var target:Point = points[int(e.params.target)];
			var target:Point = points[int(Math.random() * points.length - 1)];// Temp
			//
			var zoomFactor:Point = new Point(target.x * zoom, target.y * zoom);
			moveToPoint(zoomFactor);
			}
		//
		public function moveToPoint(p:Point):void {
			var bgX:int = -p.x + centerPoint.x;
			var bgY:int = -p.y + centerPoint.y;
			//
			var newPos:Point = maxMin(bgX, bgY);
			//
			tween = new TweenLite(bg, 1, { x:newPos.x, y:newPos.y, ease:Quad.easeOut } );
			}
		//
		private function setCenter():void {
			var bgX:int = -(bg.width / 2) + centerPoint.x;
			var bgY:int = -(bg.height / 2) + centerPoint.y;
			//
			var newPos:Point = maxMin(bgX, bgY);
			//
			bg.x = newPos.x;
			bg.y = newPos.y;
			}
		//
		public function onResize():void {
			centerPoint = new Point(root.stage.stageWidth / 2, root.stage.stageHeight / 2);
			//
			cp.x = root.stage.stageWidth / 2;
			cp.y = root.stage.stageHeight / 2;
			setCenter();
			}
	}
}