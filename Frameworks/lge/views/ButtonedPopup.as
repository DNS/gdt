

import lge.views.Button;
import lge.utils.NumberUtil;
import lge.views.Popup;
import lge.apps.LGEvent;
import lge.utils.KeyCoder;
/**
 * Creates a popup containing buttons ({@link lge.views.Popup})
 * 
 * {@code
 * // Create a MovieClip to be used as the popup's background and set the "Identifier" field to "lnk_bg" in the "Linkage Properties" window.
 * // Create a MovieClip to be used as the button's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
 * // Prepare "img_0.jpg" to be used as an icon in the swf directory.
 * // When the pop-up is created, move its position to the center of the window and arrange the position of the buttons.
 * 
import lge.views.Button;
import lge.views.View;
import lge.views.TextView;
import lge.views.ButtonedPopup;
import lge.views.Popup;
import lge.apps.LGEvent;

var ppp:ButtonedPopup = new ButtonedPopup();
ppp.addEventReceiver(this);
ppp.background = "lnk_bg";
ppp.backgroundWidth = 410;
ppp.backgroundHeight = 210;

ppp.icon = "img_0.jpg";
ppp.iconX = 10;
ppp.iconY = 10;
ppp.iconWidth = 30;
ppp.iconHeight = 30;

ppp.title = "This is Title Text";
ppp.titleFontSize = 24;
ppp.titleColor = 0xFF6666;
ppp.titleX = 50;
ppp.titleY = 10;

ppp.message = "Hello my lady. It's world cup season. Please Enjoy. Hello my lady. It's world cup season. Please Enjoy.";
ppp.messageFontSize = 20;
ppp.messageX = 20;
ppp.messageY = 50;
ppp.messageColor = 0x33ff33;

ppp.buttonArray = getButtonArray();

ppp.draw(this);

// Sends the received key values to the pop-up.
Key.addListener(this);
this.onKeyDown= function  ():Void {
	var kCode:Number = Key.getCode();
	ppp.doSomeWithKey(kCode);
}

function getButtonArray():Array {
	var kLabelArray:Array = ["OK", "CANCEL"];
	var kButton:Button;
	var kArray:Array = new Array();
	for (var i:Number = 0; i<kLabelArray.length; i++) {
		kButton = new Button();
		kButton.label = kLabelArray[i];
		kButton.background = "lnk_bg_btn";
		
		kArray.push(kButton);
	}
	return kArray;
}

function onEventReceived($evt:LGEvent):Void {
	var kID:String = $evt.id;
	if (kID == LGEvent.DRAW_COMPLETED) {
		var tx:Number = (Stage.width - ppp.width)>>1;
		var ty:Number = (Stage.height - ppp.height)>>1;
		ppp.setPosition(tx, ty);
		
		repositionButtons();
	}else if(kID==LGEvent.PRESS || kID == LGEvent.ROLL_OVER){
		// Checks the button pressed and handles the event. 
		trace("You Pressed Button in buttonArray at "+ppp.getFocusedButtonIndex());
	}
}

function repositionButtons():Void{
	var kFirstBtn:Button = ppp.buttonArray[0];
	var kSecondBtn:Button = ppp.buttonArray[1];
	var kTotalWid:Number =kFirstBtn.width+kSecondBtn.width;
	
	var kPopWid:Number = ppp.width;
	var kMargin:Number = (kPopWid-kTotalWid)/3;
	var ty:Number = ppp.backgroundHeight - kFirstBtn.height - 30;
	kFirstBtn.setPosition(kMargin,ty);
	kSecondBtn.setPosition(kFirstBtn.x+kFirstBtn.width+kMargin, ty);	
}

 * }
 */
class lge.views.ButtonedPopup extends Popup {
	
	public function dealloc():Void {	
		buttonArray = null;		
		super.dealloc();
	}	
	
	/** Specifies an array containing buttons to be displayed.
	 * @see lge.views.Button*/
	public var buttonArray:Array;	
		
	private var updateTimerOnUserEvent:Boolean = true;	
	
	private var focusedIdx:Number;
	
	private function onEvent($cmd:String, $data:String):Void {		
		if ($cmd == LGEvent.MOTIONREMOCON_ON) {
			giveUpFocus();	
		}else if ($cmd == LGEvent.MOTIONREMOCON_OFF) {
			takeFocus();
		}
		super.onEvent($cmd, $data);
	}
	
	
	private function populateElements():Void {	
		
		super.populateElements();
		
		createButtons();			
		
	}
	
	private function createButtons():Void {	
		
		var kLen:Number = buttonArray.length;
		
		var kButton:Button;
		
		for (var i:Number = 0; i < kLen; i++) {
			kButton = Button(buttonArray[i]);
			kButton.putNumber("subIndex", i);
			kButton.addEventReceiver(this);		
			addChildView(kButton);	
		}
		
	}
	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;	

		if ($evt.data instanceof Button) {	
			
			var kBtn:Button = Button($evt.data);
			
			if (kID == LGEvent.FOCUS_BUTTON) {
				focusedIdx = kBtn.getNumber("subIndex");					
			}
			
			triggerEvent(kID, kBtn);
			
		}else {
			super.onEventReceived($evt);
		}		
		
	}	
	
	
	
	/**
	 * Prepares to take the focus.
	 */
	public function takeFocus():Void {
		moveFocusAt(focusedIdx);
	}
	
	/**
	 * Gives up the focus. If an button is focused, it returns to the normal state.
	 */
	public function giveUpFocus():Void {
		normalAt(focusedIdx);
	}
	
	/**
	 * Moves the focus to the button in the specified index.
	 * 
	 * @param	$idx (Number)
	 */
	public function moveFocusAt($idx:Number):Void {
		normalAt(focusedIdx);
		
		focusedIdx = NumberUtil.getNumberInScope($idx, 0, buttonArray.length - 1, true);				
		
		focusAt(focusedIdx);		
	}
	
	/**
	 * Moves the focus to the previous item.
	 */
	public function moveFocusPrev():Void {
		moveFocusAt(focusedIdx - 1);
	}
	
	/**
	 * Moves the focus to the next item.
	 */
	public function moveFocusNext():Void {
		moveFocusAt(focusedIdx + 1);
	}
	
	private function normalAt($idx:Number):Void {
		var kBtn:Button = buttonArray[$idx];
		kBtn.normal();
	}
	
	private function focusAt($idx:Number):Void {		
		var kBtn:Button = buttonArray[$idx];
		kBtn.focus();
	}
	/**
	 * This method is provided for developers convenience.<br>
	 * When a key event occurs, passing the key's code value  
	 * allows the button popup to perform its basic functions.<br>
	 * Detects the input of the left, right and Enter keys.
	 * 
	 * @param	$code (Number) The code value of the pressed key
	 */
	public function doSomeWithKey($code:Number):Void {
		
		if ($code == KeyCoder.RIGHT || $code==KeyCoder.DOWN) {
			moveFocusNext();
		}else if ($code == KeyCoder.LEFT || $code==KeyCoder.UP) {
			moveFocusPrev();
		}else if ($code == KeyCoder.ENTER) {
			triggerEvent(LGEvent.SELECT_BUTTON, this);
		}
	}
	
	/**
	 * Returns the index of the focused button.
	 * @return (Number)
	 */
	public function getFocusedButtonIndex():Number {		
		return focusedIdx;
	}
	
}