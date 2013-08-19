

import lge.apis.Control;
import flash.external.ExternalInterface;
import lge.apps.LGObject;
import lge.utils.ArrayUtil;

/**
 * The proxy of the a keyboard in Smart Phone(s).
 * 
 * It support the functions to control the virtual keyboard in Smart Phone(s) and recieving the user text input event.<br>
 * <br>
 * It's assumed that the keyboard in the smart phone is consist of a text box that contains the whole typed text and a screen keyboard.<br>
 * <br>
 * This class use singleton pattern. So call getInstance function to get instance.<br>
 * Recommand that you call the dealloc function, if you want to use the instance any more.<br>
 * <br>
 * Caution:<br>
 * It's assumed that single smart phone is connected to TV,
 * and one or no keyboard is activated in the smart phone at the same time.<br>
 * Use it as single virtual keyboard that connected to TV.<br>
 * It can work in the case multiple smart phones is connected to TV, but it's exceptional case.<br>
 * 
 */
class lge.apps.LGSmartPhoneKeyboardProxy extends LGObject{	
	
	
		
	private var smartPhoneKeyboardController:Control;
	private var receiverLst:Array;
	static private var inst:LGSmartPhoneKeyboardProxy;
	
	/**< Smart Text string & position noti msg */
	public static var NOTI:Number = 0;

	/**< Smart Text string & position msg show */
	public static var SHOW:Number = 1;

	/**< Smart Text string & position msg hide */
	public static var HIDE:Number = 2; 

	/**< Smart Text string & position msg none */  
	public static var NONE:Number = 3;
	
	
	private function LGSmartPhoneKeyboardProxy() {
		receiverLst = new Array();
		ExternalInterface.addCallback( "LGSmartTextEvent", this, onEvent);	
	}
	
	/**
	 * Get instance of LGSmartPHoneKeyboardProxy class
	 * 
	 * @return A instance of LGSmartPHoneKeyboardProxy class
	 */	
	public static function getInstance():LGSmartPhoneKeyboardProxy	{
		if (inst == null) {
			inst = new LGSmartPhoneKeyboardProxy();			
		}
		return inst;
	}
	
	
	/**
	 * Show/hide the virtual keyboard in smart phone.
	 * 
	 * @param	$visible true, if you want to show the keyboard. false, if you want to hide the keyboard.
	 * 
	 */	
	public function setVisible($visible:Boolean):Void{
		if (smartPhoneKeyboardController == null) {
			smartPhoneKeyboardController	= new Control();
		}
		
		if($visible){
			smartPhoneKeyboardController.activateSmartText(SHOW, 0, 0, "");
		}else {
			smartPhoneKeyboardController.activateSmartText(HIDE, 0, 0, "");
		}
	}
	
	/**
	 * Set the text of the text box in the smart phone.
	 * 
	 * @param	$text	The whole text that want to change
	 * 
	 */
	
	public function setText($text:String):Void{
		if (smartPhoneKeyboardController == null) {
			smartPhoneKeyboardController	= new Control();
		}
		
		smartPhoneKeyboardController.activateSmartText(NOTI, 0, 0, $text);
	}
	
	/**
	 * Add listener of text input in the smart phone<br>
	 * if the text that user types in smart phone is changed, onTextEdited function of $receiver will be called.
	 * <br>
	 * Caution:<br>
	 * If same object is added, this class notifies to the object twice.<br>
	 * 
	 * @param	$receiver	The object to listen the text input event.
	 * 
	 */	
	public function addListener($receiver:Object):Void{
		var kAt:Number = ArrayUtil.getAt(receiverLst, $receiver, -1);
		if (kAt == -1) {
			receiverLst.push($receiver);
		}
	}
	
	/**
	 * Remove listener of text input in the smart phone<br>
	 * <br>
	 * Caution:<br>
	 * You need to call this function twice, if same object is added twice.<br>
	 * 
	 * @param	$receiver	The object to listen the text input event.
	 * 
	 */	
	public function removeListener($receiver:Object) {
		ArrayUtil.deleteOne(receiverLst, $receiver);		
	}
	
	
	
	private function onEvent($encodedData:String):Void{	
		var kTxt:String= unescape($encodedData);
		var kLen:Number = receiverLst.length;
		for (var i:Number = 0; i < kLen; i++) {
			receiverLst[i].onTextEdited(kTxt);
		}
	}
}