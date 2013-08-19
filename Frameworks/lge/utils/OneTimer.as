
import lge.apps.LGCustomEventManager;
import lge.apps.LGEvent;
import lge.utils.NumberUtil;
//import mx.utils.Delegate;
/**
 * Provides the method that can fire events 
 * after a specified period of time.<br><br>
 * During application development, some events may need to be fired periodically or repetitively,
 * but others need to be fired only once after a specified period of time and the timer must be closed.
 * For example, a pop-up window must be closed automatically if there is no user response after a specified period of time.
 * 
 * <br><br>
 * 
 * Events fired:
 * <ul> onTimePassed
 * 	<li>LGEvent value: TIME_PASSED</li>
 * 	<li>Event fired when the time specified in OneTimer has elapsed</li>
 * </ul>
 */
class lge.utils.OneTimer extends LGCustomEventManager {
	
	public function dealloc():Void {
		Key.removeListener(this);
		Mouse.removeListener(this);
		_global.ExtendedEvents.LGSmartTextEvent.removeListener(this);
		
		deleteEventHolder();
		onTimePassed = null;
		onFrameForTimer = null;
		super.dealloc();
	}
	
	private function deleteEventHolder():Void {
		evtHolder.onEnterFrame = null;
		evtHolder.removeMovieClip();
		evtHolder = null;
	}
	
	
	private var duration:Number;
	private var updateTimerOnUserEvent:Boolean;
	private var evtHolder:MovieClip;
	private var unik_id:Number;
	private var startMilli:Number = 0;
	
	/**
	 * Executes the timer.
	 * Fires the event with the ID "onTimePassed" (LGEvent.TIME_PASSED) after a specified period of time.
	 * 
	 * @param	$duration (Number) The time set in the timer (in seconds)
	 * @param	$updateTimerOnUserEvent (Boolean) Whether to reset the timer upon user response (e.g. mouse move or key press) 
	 * (Even if this value is set to "false", the timer can be reset manually using the updateTimer() method.) 
	 */
	public function start($duration:Number, $updateTimerOnUserEvent:Boolean):Void {	
		
		if (evtHolder == null) {			
			duration = NumberUtil.getNumber($duration, 10);
			updateTimerOnUserEvent = $updateTimerOnUserEvent;
			evtHolder = getOneTimerEventHolder();
			startMilli = getTimer();
			
			
			var kThis:OneTimer = this;
			evtHolder.onEnterFrame = function():Void {
				kThis.onFrameForTimer();
			}
			//evtHolder.onEnterFrame = Delegate.create(this, onFrameForTimer);
			
			if (updateTimerOnUserEvent) {
				Mouse.removeListener(this);
				Key.removeListener(this);
				_global.ExtendedEvents.LGSmartTextEvent.removeListener(this);
				
				Mouse.addListener(this);
				Key.addListener(this);
				_global.ExtendedEvents.LGSmartTextEvent.addListener(this);
			}
		}			
	}
	
	private function onFrameForTimer():Void {
		var kDisMilli:Number = getTimer() - startMilli;
		if (kDisMilli > duration * 1000) {
			onTimePassed();
		}
	}
	
	private function onTimePassed():Void {	
		
		deleteEventHolder();
		
		triggerEvent(LGEvent.TIME_PASSED, this);
		
		dealloc();
	}
	
	private function onMouseMove():Void {		
		updateTimer();
	}
	
	private function onKeyDown():Void {
		updateTimer();
	}
	
	private function onEvent($cmd:String):Void {
		updateTimer();
	}
	/**
	 * Resets the timer.
	 */
	public function updateTimer():Void {
		
		startMilli = getTimer();
	}
	
	
	
	
	
	
	
	private function getOneTimerEventHolder():MovieClip {
		if (unik_id == null) unik_id = _root.getNextHighestDepth();
		var kHolder:MovieClip = _root.createEmptyMovieClip("oneTimerEventHolder_" + unik_id, _root.getNextHighestDepth());	
		
		return kHolder;
		
	}
	
}