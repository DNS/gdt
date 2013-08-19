

import lge.apps.LGObject;
import lge.utils.ArrayUtil;
import lge.apps.LGEvent;
import flash.external.ExternalInterface;
import lge.utils.XmlToObject;

/**
 * An class that handles an event fired from the device.
 * It sends the event fired from the device to the added event listener.
 * When an event is fired, the onExtendedEventReceived() method of the added event listener is called.
 * The parameter passed is an object of the lge.apps.LGEvent class. It has the string property, and must be cast from Object to String (String(data)). 
 */
class lge.apps.LGExtendedEventManager extends LGObject{	
	
	
	private static var inst:LGExtendedEventManager;	
	
	private var receiverLst:Array;
	
	
	private function LGExtendedEventManager () 	{
		receiverLst = new Array();
		//--이벤트가 발생하면 이 클래스의 onEvent($id, $data)가 호출된다.
		ExternalInterface.addCallback( "LGEvent", this, onEvent);
		ExternalInterface.addCallback( "LGAPPEvent", this, onEvent);
		ExternalInterface.addCallback( "LGTVAppsEvent", this, onEvent);
		ExternalInterface.addCallback( "LGSDPServerEvent", this, onEvent);
		ExternalInterface.addCallback( "LGCallback", this, onEvent);
	}	
	
	/**
	 * Creates an instance of the LGExtendedEventManager class and returns it.
	 * There exists only one instance of this class for all the applications.
	 * The instance is created with the Singleton method because ExtendedEvent, unlike the events fired from each object,
	 * is fired from the device. This means that only one event dispatcher exists,
	 * thus one instance is sufficient.
	 * 
	 * Since it cannot create an object with a constructor, the getInst() method must be used to return an object.
	 * {@code
	 * The following gets only one object of the LGExtendedEventManager class created.
	 * 
	 * var manager:LGExtendedEventManager = LGExtendedEventManager.getInst();
	 * }
	 * 
	 */
	public static function getInstance ():LGExtendedEventManager	{
		if (inst == null) {
			inst = new LGExtendedEventManager();
		}		
		return inst;
	}
	
		
	/**
	 * Adds the corresponding event to the ExtendedEvent class provided by the Flash.
	 * 
	 * {@code
	 * The following adds the specified object as an event listener.	 
	 * 
	 * var manager:LGExtendedEventManager = LGExtendedEventManager.getInst();
	 * manager.addEventReceiver(receiver);
	 * }
	 * 
	 * @param	$receiver The object that will receive the event. The method onExtendedEventReceived() must be implemented.	 
	 */
	public function addEventReceiver ($receiver:Object): Void	{		
		var kAt:Number = ArrayUtil.getAt(receiverLst, $receiver, -1);
		if (kAt == -1) {
			receiverLst.push($receiver);
		}
	}
	
	
	/**
	 * Removes the added EventedReceiver.
	 * 
	 * @param	$receiver The object added as an event listener 	 
	 */
	public function removeEventReceiver($receiver:Object):Void {
		ArrayUtil.deleteOne(receiverLst, $receiver);			
	}
	
	
	private function onEvent($evtName:String, $data:String):Void {	
		var kRetObj:Object = XmlToObject.parseXmlToObject($data);
		var kEvt:LGEvent = new LGEvent($evtName, kRetObj);		
		var kLen:Number = receiverLst.length;
		var kTmpLst:Array = receiverLst.concat();
		var kReceiver:Object;
		for (var i:Number = 0; i < kLen; i++) {
			kReceiver = kTmpLst[i];			
			kReceiver.onExtendedEventReceived(kEvt);					
		}
	}
	
	
	
}