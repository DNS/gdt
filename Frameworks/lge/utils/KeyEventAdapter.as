/*The event keeps occuring while the key is pressed.
 * If its frequency is higher than the fps defined for the MovieClip, the operation is performed without updating the stage
 * and the result is applied when the key is depressed. For example, pressing and holding the down button in a list box 
 * is not applied immediately to the list box but. When the key is depressed, however, the result of the accumulated events is applied to the list box.<br>
 * This class is designed to catch one event per frame regardless of how many key events occur.*/

import lge.apps.LGCustomEventManager;
//import lge.utils.ClipUtil;
import lge.apps.LGEvent;

/**
 * 
 * This class inherits the LGCustomEventManager class, thus it provides the method and event to attach an event listener and
 * catch and handle the event that occurs in this class.<br>
 * Developers need to create an object for this class and attach an event listener to the object.
 * {@code
 * 
 * var eventer:KeyEventAdapter = new KeyEventAdapter()
 * eventer.addEventReceiver(this);
 * function onEventReceived($evt:LGEvent):Void{
 * 	if($evt.id == LGEvent.KEY_PRESSED){
 *    var kCode:Number = evt.data.code;
 *    //The execute statement 
 *  }
 * }
 * 
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onKeyPressed
 * 	<li>LGEvent value: KEY_PRESSED</li>
 * 	<li>Event fired when the key input is detected</li>
 * </ul>
 */
class lge.utils.KeyEventAdapter extends LGCustomEventManager{
	
	public function dealloc():Void {		
		Key.removeListener(this);			
		//onFrameForKey = null;	
		
		/*clip.onEnterFrame = null;			
		clip.removeMovieClip();
		clip = null;*/
		
		super.dealloc();
	}
	
	//private var savedKey:Number;
	//private var clip:MovieClip;	
	//private var clipName:String;	
	
	
	function KeyEventAdapter() {		
		//clip = getKeyEventClip();		
		init();
	}
	
	private function init():Void {			
		Key.removeListener(this);		
		Key.addListener(this);
		//var kThis:KeyEventAdapter = this;
		//clip.onEnterFrame = function():Void {
			//kThis.onFrameForKey();				
		//}
	}		
	
	private function onKeyDown():Void {
		triggerEvent(LGEvent.KEY_PRESSED, { code:Key.getCode() } );		
		//if(savedKey == null || savedKey == -1) {
			//savedKey = Key.getCode();
		//}		
	}

	/*private function onFrameForKey():Void {
		if (savedKey > -1) {			
			triggerEvent(LGEvent.KEY_PRESSED, { code:savedKey } );		
			savedKey = -1;
		}		
	}
	
	private function getKeyEventClip():MovieClip {
		if (clipName == null) {
			clipName = "evtHolder" + _level0.getNextHighestDepth();
		}
		
		var kHolder:MovieClip = ClipUtil.createEmptyHolder(_level0, clipName);
		return kHolder;
	}*/
}