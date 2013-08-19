package game.gui {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import com.demonsters.debugger.MonsterDebugger;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import game.events.EventManager;
	import game.events.GameEvent;
	import game.utils.GlobalInstance;
	import game.utils.GUIUtils;
	import game.utils.TutorialObject;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.easing.Linear;
	
	public class Tutorial extends Sprite {
		
		private static var _instance		: Tutorial;
		
		private static var tintLayer		: Shape;
		private static var tutorialLayer	: Sprite;
		
		private var actions					: Vector.<String> = new Vector.<String>();
		private var points					: Vector.<TutorialObject> = new Vector.<TutorialObject>();
		private var pointsDic				: Dictionary = new Dictionary();
		
		private var waitObject				: String = "";
		
		private var arrow					: Sprite;
		private var arrowBg					: MovieClip;
		
		private var tween					: TweenMax;
		private var tweenGlow				: TweenMax;
		
		private var glowObject				: Object = { color:0xFFFFFF, alpha:1, blurX:20, blurY:20, strength:3, quality:2 };
		
		public function Tutorial() {
			//
			}
		//
		public static function get instance():Tutorial {
			if (!_instance) {
				_instance = new Tutorial();
				}
			return _instance;
			}
		//
		public function stageLayer(layer:Sprite):void {
			TweenPlugin.activate([GlowFilterPlugin]);
			
			tutorialLayer = layer;
			tutorialLayer.visible = false;
			
			tintLayer = new Shape();
			tintLayer.graphics.beginFill(0x000000, 0.5);
			tintLayer.graphics.drawRect(0, 0, layer.stage.stageWidth, layer.stage.stageHeight);
			tintLayer.graphics.endFill();
			tintLayer.visible = false;
			tutorialLayer.addChild(tintLayer);
			//
			createArrow();
			}
		//
		private function createArrow():void {
			arrow = new Sprite();
			
			arrowBg = new TutorArrowBg();
			arrowBg.x = -(arrowBg.width / 2);
			arrowBg.y = -arrowBg.height;
			arrow.addChild(arrowBg);
			
			arrow.mouseEnabled = arrow.mouseEnabled = false;
			
			tutorialLayer.addChild(arrow);
			}
		//
		public function nextAction(id:String = ""):void {
			var tutorObject:TutorialObject;
			//
			if (waitObject == "" || waitObject != id) {
				MonsterDebugger.trace(this, id, "Danil", "Error > nextAction(); waitObject != id", 0xFF0000);
				return;
				}
			//
			if (waitObject == id) {
				tweenGlow.kill();
				tweenGlow = null;
				//
				}
			//
			if (actions.length <= 0) {
				MonsterDebugger.trace(this, "end tutorial", "Danil", "Error > actions is empty!", 0xFF0000);
				waitObject = "";
				
				if (tweenGlow) {
					tweenGlow.kill();
					tweenGlow = null;
					}
				
				tween.kill();
				tween = null;
				
				tutorialLayer.visible = false;
				return;
				}
			//
			tutorObject = pointsDic[actions[0]] as TutorialObject;
			//
			var point:Point = getPoint(tutorObject.object);
			arrow.x = point.x;
			arrow.y = point.y;
			setPosition(tutorObject);
			tween.restart();
			
			tweenGlow = new TweenMax(tutorObject.object, 0.5, { glowFilter:glowObject, ease:Linear.easeInOut, repeat: -1, yoyo:true, delay:3 } );
			
			tutorialLayer.visible = true;
			
			waitObject = tutorObject.id;
			actions.shift();
			}
		//
		public function addPoint(point:TutorialObject):void {
			points.push(point);
			pointsDic[point.id] = point;
			}
		//
		public function addActions(_actions:String):void {
			actions = new Vector.<String>();
			var raw:Array = _actions.split(",");
			var i:int;
			//
			for (i = 0; i < raw.length; i++) {
				actions.push(raw[i]);
				}
			//
			tween = new TweenMax(arrowBg, 0.4, { y: -(arrowBg.height + 10), ease:Linear.easeInOut, repeat: -1, yoyo:true } );
			tween.pause();
			}
		//
		public function startActions():void {
			var tutorObject:TutorialObject = pointsDic[actions[0]] as TutorialObject;
			
			var point:Point = getPoint(tutorObject.object);
			arrow.x = point.x;
			arrow.y = point.y;
			setPosition(tutorObject);
			tween.restart();
			
			tweenGlow = new TweenMax(tutorObject.object, 0.5, { glowFilter:glowObject, ease:Linear.easeInOut, repeat: -1, yoyo:true, delay:3 } );
			
			tutorialLayer.visible = true;
			
			waitObject = tutorObject.id;
			actions.shift();
			}
		//
		private function removeArrow():void {
			//tween.kill();
			//arrow.visible = false;
			}
		//
		private function getPoint(object:*):Point {
			var point:Point = GlobalInstance.instance.MainStage.stage.localToGlobal(new Point(object.x, object.y));
			
			if (object.parent is Gui) {
				point.offset((object.parent as Gui).x, (object.parent as Gui).y);
				}
			if (object.parent is PopUpBase) {
				point.offset((object.parent as PopUpBase).x, (object.parent as PopUpBase).y);
				}
			
			return point;
			}
		//
		private function setPosition(tutorObject:TutorialObject):void {
			switch(tutorObject.align) {
				case GUIUtils.ALIGN_CENTER:
					arrow.x = arrow.x + (tutorObject.object.width / 2);
					arrow.y = arrow.y + (tutorObject.object.height / 2);
					arrow.rotation = 0;
					break;
				case GUIUtils.ALIGN_TOP:
					arrow.x = arrow.x + (tutorObject.object.width / 2);
					arrow.rotation = 0;
					break;
				case GUIUtils.ALIGN_TOP_LEFT:
					arrow.rotation = -45;
					break;
				case GUIUtils.ALIGN_LEFT:
					arrow.y = arrow.y + (tutorObject.object.height / 2);
					arrow.rotation = -90;
					break;
				case GUIUtils.ALIGN_RIGHT:
					arrow.x = arrow.x + tutorObject.object.width;
					arrow.y = arrow.y + (tutorObject.object.height / 2);
					arrow.rotation = 90;
					break;
				case GUIUtils.ALIGN_TOP_RIGHT:
					arrow.x = arrow.x + tutorObject.object.width;
					arrow.rotation = 45;
					break;
				case GUIUtils.ALIGN_BOTTOM_LEFT:
					arrow.y = arrow.y + tutorObject.object.height;
					arrow.rotation = -135;
					break;
				case GUIUtils.ALIGN_BOTTOM_RIGHT:
					arrow.x = arrow.x + tutorObject.object.width;
					arrow.y = arrow.y + tutorObject.object.height;
					arrow.rotation = 135;
					break;
				case GUIUtils.ALIGN_BOTTOM:
				case GUIUtils.ALIGN_BOTTOM_CENTER:
					arrow.x = arrow.x + (tutorObject.object.width / 2);
					arrow.y = arrow.y + tutorObject.object.height;
					arrow.rotation = 180;
					break;
				}
			//
			if (tutorObject.offset != 0) {
				arrow.x = arrow.x + tutorObject.offset;
				arrow.y = arrow.y + tutorObject.offset;
				}
			}
	}
}