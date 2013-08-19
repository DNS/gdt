

import lge.apps.LGEvent;
import lge.apps.LGObject;
import lge.utils.ArrayUtil;
/**
 * Fires a user-defined event
 * and adds an event listener for the event.
 * When an event is fired, the onEventReceived() method of the added event listener is called.
 * The parameter to be passed is an object of lge.apps.LGEvent.
 * Unlike LGExtendedEventManager, it can fire an event.
 */
class lge.apps.LGCustomEventManager extends LGObject{
	
	public function dealloc():Void {				
		receiverLst = null;
		super.dealloc();
	}
			
	private var receiverLst:Array;
	
	function LGCustomEventManager() {		
		receiverLst = new Array();
	}	
	
	/**
	 * Adds the object received as a parameter as an event listener.
	 * 
	 * @param	$receiver (Object) The object to be added as an event listener. The onEventReceived() method must be implemented.
	 */
	public function addEventReceiver($receiver:Object):Void {
		var kAt:Number = ArrayUtil.getAt(receiverLst, $receiver, -1);
		if (kAt == -1) {
			receiverLst.push($receiver);
		}
				
	}
	
	/**
	 * Removes the added event listener.
	 * 
	 * @param	$receiver (Object) The added event listener
	 */
	public function removeEventReceiver($receiver:Object):Void {
		if ($receiver != null) {
			ArrayUtil.deleteOne(receiverLst, $receiver);
		}				
	}
	
	/**
	 * Fires an event.
	 * 
	 * @param	$id (String) The ID of the event. It identifies the event. 
	 * @param	$data (Object) The value to be passed when an event is fired 
	 * {@code
	 * The following example creates LGCustomEventManager
	 * and adds its object as a listener.
	 * If EventManager's triggerEvent() is executed, the parameters passed are outputted.
	 * 
	 * var manager:LGCustomEventManager = new LGCustomEventManager();
	 * manager.addEventReceiver(this);
	 * function onEventReceived($evt:LGEvent):Void{
	 * 		trace($evt.id+" *** "+$evt.data.name);
	 * }
	 * manager.triggerEvent("onMyEvent",{name:"lge"});
	 * //Outputs onMyEvent *** lge
	 * }
	 */
	public function triggerEvent($id:String, $data:Object):Void {		
		var kEvt:LGEvent = new LGEvent($id, $data);		
		var kLen:Number = receiverLst.length;
		var kTmpLst:Array = receiverLst.concat();
		var kReceiver:Object;
		for (var i:Number = 0; i < kLen; i++) {
			kReceiver = kTmpLst[i];				
			kReceiver.onEventReceived(kEvt);			
		}
	}
	
}