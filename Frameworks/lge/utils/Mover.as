
import lge.apps.LGCustomEventManager;
import lge.utils.NumberUtil;
import lge.utils.ClipUtil;
import lge.apps.LGEvent;

/**
 * Provides the method and event to move the MovieClip to the specific position.
 * It fires an event with the ID "onEndMove" (LGEvent.END_MOVE) when the MovieClip has finished moving.
 * 
 * {@code
 * 	
 * // Positions the MovieClip on the stage and sets the instance name to "pack".
 * 
	import lge.apps.LGEvent;
	import lge.utils.Mover;
	
	var kMover:Mover = new Mover();
	kMover.addEventReceiver(this);
	kMover.move(pack, 100, 200, 0.5, 30);
	function onEventReceived($evt:LGEvent):Void {		
		var kID:String = $evt.id;			
		if (kID == LGEvent.END_MOVE) {
			//--mover에서 pack의 이동을 끝낸 후 호출 		
			trace("end move")
		}
	}
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onEndMove
 * 	<li>LGEvent value: END_MOVE</li>
 * 	<li>Event fired when the MovieClip has finished moving</li>
 * </ul>
 */
class lge.utils.Mover extends LGCustomEventManager {
	
	public function dealloc():Void {		
		deleteLoopHolder();		
		clip = null;		
		super.dealloc();
	}
	
	 private function deleteLoopHolder():Void {
		delete loopHolder.onEnterFrame;
		loopHolder.removeMovieClip();
		loopHolder = null;
	}
	
	private var clip:MovieClip;
	private var loopHolder:MovieClip;
	private var targetX:Number;
	private var targetY:Number;
	private var rate:Number;
	private var permit:Number;
	private var tX:Number;
	private var tY:Number;
	
	private static var cnt:Number = 0;
	
	/**
	 * Moves the MovieClip. It fires an event with the ID "onEndMove" (LGEvent.END_MOVE) when the MovieClip has finished moving.
	 * 
	 * @param	$clip (MovieClip) The MovieClip to be moved
	 * @param	$targetX (Number) The X coordinate of the final position 
	 * @param	$targetY (Number) The X coordinate of the final position
	 * @param	$rate (Number) The movement rate per frame. For example, if it is 0.5, the MovieClip is moved half of the distance to the final position.
	 * If it is equal to or less than 0, it should be set to 1. If it is 1, the MovieClip is moved to the destination in one frame.
	 * @param	$permit (Number) If the remaining distance is smaller than this value, the MovieClip is assumed to have reached the final position.
	 */
	public function move($clip:MovieClip, $targetX:Number, $targetY:Number, $rate:Number, $permit:Number):Void {	
		clip = $clip;
		
		deleteLoopHolder();
		
		loopHolder = ClipUtil.createEmptyHolder(clip, "evt_holder_"+cnt++);
			
		tX = clip._x;
		tY = clip._y;
		targetX = $targetX;
		targetY = $targetY;
		if ($rate < 0) {
			rate = 1;
		}else {
			rate = NumberUtil.getNumber($rate, 0.9);
		}
		
		
		permit = NumberUtil.getNumber($permit, 20);
		
		var kThis:Mover = this;
		if (rate >= 1) {			
			onEndMove();			
		}else if (targetX != null && targetY != null) {
			loopHolder.onEnterFrame = function():Void {
				kThis.onFrameForBoth();
			}			
		}else if (targetX != null) {
			loopHolder.onEnterFrame = function():Void {
				kThis.onFrameForHor();
			}			
		}else if (targetY != null) {
			loopHolder.onEnterFrame = function():Void {
				kThis.onFrameForVer();
			}			
		}else {
			onEndMove();
		}
	}
	
	private function onFrameForBoth():Void {		
		var kDisX:Number = targetX - tX;
		var kDisY:Number = targetY - tY;
		var kDis:Number = int(Math.sqrt(kDisX * kDisX + kDisY * kDisY)) // NumberUtil.getDistanceWithXYDistance(kDisX, kDisY);
		if (kDis > permit) {
			tX = tX + kDisX * rate;
			clip._x = tX;
			tY = tY + kDisY * rate;
			clip._y = tY;
		}else {			
			onEndMove();
		}
	}
	
	private function onFrameForHor():Void {		
		var kDisX:Number = targetX - tX;	
		
		var kDis:Number = kDisX; //Math.abs(kDisX); // NumberUtil.getDistanceWithXYDistance(kDisX, null);
		if (kDis < 0) {
			kDis = kDis * -1;
		}
		
		if (kDis > permit) {
			tX = tX + kDisX * rate;
			clip._x = tX;	
		}else {				
			onEndMove();
		}
	}
	
	private function onFrameForVer():Void {			
		var kDisY:Number = targetY - tY;
		var kDis:Number = kDisY; //Math.abs(kDisY);
		if (kDis < 0) {
			kDis = kDis * -1;
		}
		if (kDis > permit) {
			tY = tY + kDisY * rate;
			clip._y = tY;
		}else {				
			onEndMove();
		}
	}	
	
	private function onEndMove():Void {		
		if (targetX != null) {
			clip._x = targetX;
		}
		
		if (targetY != null) {
			clip._y = targetY;
		}
		
		//deleteLoopHolder();	
		
		triggerEvent(LGEvent.END_MOVE, this);
		
		//dealloc();
		deleteLoopHolder();		
		clip = null;	
	}
}