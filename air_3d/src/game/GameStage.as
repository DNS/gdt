package game {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import gdt.events.EventsManager;
	import gdt.events.GameEvents;
	import gdt.events.GUIEvents;
	
	import gdt.gui.debug.Log;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3DRenderMode;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TouchEventIntent;
	import flash.events.TransformGestureEvent;
	
	import game.AssetsParser;
	
	import game.characters.BaseCharacter;
	
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;	
	
	public class GameStage extends Sprite {
		private var rootStage:Stage;
		private var stage3D:Stage3D;
		private var camera:Camera3D;
		private var rootContainer:Object3D;
		private var controller:SimpleObjectController;
		
		/*//rotation variables
		private var move:Boolean = false;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		//movement variables
		private var drag:Number = 0.5;
		private var walkIncrement:Number = 2;
		private var strafeIncrement:Number = 2;
		private var walkSpeed:Number = 0;
		private var strafeSpeed:Number = 0;
		private var walkAcceleration:Number = 0;
		private var strafeAcceleration:Number = 0;
		
		private var pers:Pers;*/
		
		public function GameStage(parentStage:Stage) {
			rootStage = parentStage;
			//
			
			//add3DStage();
			}
		//
		public function init():void {
			camera = new Camera3D(0.01, 10000000000);
			camera.x = -50;
			camera.y = -300;
			camera.z = 100;
			controller = new SimpleObjectController(rootStage, camera, 200);
			controller.lookAtXYZ(0, 0, 0);
			camera.view = new View(rootStage.stageWidth, rootStage.stageHeight, false, rootStage.color, rootStage.alpha, 2);
			
			camera.debug = true;
			camera.view.hideLogo();
			
			rootStage.addChild(camera.view);
			
			rootContainer = new Object3D();
			rootContainer.addChild(camera);
			}
		//
		
		//
		public function startGame():void {
			//Log.add("stage3Ds: " + rootStage.stage3Ds.toString());
			if (rootStage.stage3Ds.length > 0 ) {
				stage3D = rootStage.stage3Ds[0];
				stage3D.addEventListener(Event.CONTEXT3D_CREATE, initAssets); 
				stage3D.requestContext3D(Context3DRenderMode.AUTO); 
				}
			}
		//
		private function initAssets(e:Event):void {
			AssetsParser.init(stage3D.context3D, rootContainer);
			
			//EventsManager.getInstance().addEventListener(GameEvents.LEVEL_PARSED, onLevelParsed);
			AssetsParser.loadLevel(1);
			
			
			/*for each (var resource:Resource in rootContainer.getResources(true)) {
				resource.upload(stage3D.context3D);
				}
			addEventListener(Event.ENTER_FRAME, onEnterFrame)*/
			}
		//
		private function onLevel():void {
			//AssetsParser.level;
			}
		//
		private function onEnterFrame(event:Event):void	{
			//set the camera height based on the terrain (with smoothing)
			//camera.y += 0.2*(terrain.getHeightAt(camera.x, camera.z) + 20 - camera.y);
			
			/*if (move) {
				cameraController.panAngle = 0.3*(stage.mouseX - lastMouseX) + lastPanAngle;
				cameraController.tiltAngle = 0.3*(stage.mouseY - lastMouseY) + lastTiltAngle;
				}
			
			if (walkSpeed || walkAcceleration) {
				walkSpeed = (walkSpeed + walkAcceleration)*drag;
				if (Math.abs(walkSpeed) < 0.01)
					walkSpeed = 0;
				cameraController.incrementWalk(walkSpeed);
				}
			
			if (strafeSpeed || strafeAcceleration) {
				strafeSpeed = (strafeSpeed + strafeAcceleration)*drag;
				if (Math.abs(strafeSpeed) < 0.01) {
					strafeSpeed = 0;
					}
				cameraController.incrementStrafe(strafeSpeed);
				}*/
			
			controller.update();
			camera.render(stage3D);
			}
		//
		/**
		 * Mouse down listener for navigation
		 */
		private function onMouseDown(event:MouseEvent):void {
			/*move = true;
			lastPanAngle = cameraController.panAngle;
			lastTiltAngle = cameraController.tiltAngle;
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;*/
			//stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		/**
		 * Mouse up listener for navigation
		 */
		private function onMouseUp(event:MouseEvent):void {
			//move = false;
			//stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		//
	}
}