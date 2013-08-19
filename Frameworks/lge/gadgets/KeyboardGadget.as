

import lge.apis.PathFinder;
import lge.apps.LGEvent;
import lge.gadgets.Gadget;

/**
 * Provides the user environment for a virtual keyboard.  
 * The country is automatically set as the one set in the device
 * and the keyboard face is set accordingly.
 * If a key event handler is attached, it responds according to the user's key input.
 * 
 * {@code
 * // Create an input text field with the instance name "fld" in the top of the stage.
 * // Insert the following code in the first frame of the stage.
 * // The keyHandler is attached when the gadget completes loading. If the focus tries to move outside the left border, the keyHandler is detached.
 * 
 * import lge.gadgets.KeyboardGadget;
 * import lge.apps.LGEvent;
 * 
 * var holder:MovieClip = this.createEmptyMovieClip("keyboardHolder",1);
 * holder._y = 200;
 * var keyboarder:KeyboardGadget = new KeyboardGadget();
 * keyboarder.open(holder, fld, 0x00FF00, false);
 * function onEventReceived($evt:LGEvent):Void{
 * 	var kId:String = $evt.id;
 * 	trace("id - "+kId);
 * 	if(kId ==LGEvent.GADGET_LOADED){		
 * 		keyboarder.attachKeyHandler();
 * 	}else if(kId==LGEvent.TRY_TO_MOVE_BEYOND_LEFT){
 * 		keyboarder.detachKeyHandler();
 * 	}
 * }
 * keyboarder.addEventReceiver(this);
 * }
 * <br><br>
 * 
 * Events fired:
 * 
 * <ul> onTryToMoveBeyoundRightBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_RIGHT</li>
 * 	<li>Event fired when the focus of the KeyboardGadget tries to move outside the right border</li>
 * </ul>
 * <ul> onTryToMoveBeyoundLeftBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_LEFT</li>
 * 	<li>Event fired when the focus of the KeyboardGadget tries to move outside the left border</li>
 * </ul>
 * <ul> onTryToMoveBeyoundTopBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_TOP</li>
 * 	<li>Event fired when the focus of the KeyboardGadget tries to move outside the top border</li>
 * </ul>
 * <ul> onTryToMoveBeyoundBottomBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_BOTTOM</li>
 * 	<li>Event fired when the focus of the KeyboardGadget tries to move outside the bottom border</li>
 * </ul>
 * <ul> onTextChanged
 * 	<li>LGEvent value: TEXT_CHANGED</li>
 * 	<li>Event fired when the text in the text filed changes</li>
 * </ul>
 * <ul> onRollOver
 * 	<li>LGEvent value: ROLL_OVER</li>
 * 	<li>Event fired when the mouse is rolled over </li>
 * </ul>
 * <ul> onRollOut
 * 	<li>LGEvent value: ROLL_OUT</li>
 * 	<li>Event fired when the mouse is rolled out </li>
 * </ul>
 */

class lge.gadgets.KeyboardGadget extends Gadget {
	
	
	public function dealloc():Void {		
		//targetFld = null;			
		super.dealloc();
	}	
	
	private var targetFld:TextField;
	private var caretColor:Number = 0xFFFFFF;
	private var isSignIn:Boolean = false;	
	private var maxLen:Number;
	
	/**
	 * language
	 */
	public var lang:String;
	/**
	 * the time length for caret
	 */
	public var caretTime:Number;//sec
	
	/**
	 * offset value of caret width which is added to the basic caret width
	 */
	  
	public var caretOffsetWidth:Number;
	/**
	 * offset value of caret height which is added to the basic caret height
	 */
	public var caretOffsetHeight:Number;
	/**
	 * offset value of horizontal distance between the caret and the character, which is added to the basic distance
	 */
	public var caretOffsetDistanceX:Number;	
	/**
	 * offset value of vertical distance between the caret and the character, which is added to the basic distance
	 */
	public var caretOffsetDistanceY:Number;
	
	function KeyboardGadget() {
		super();
	}
	
	/**
	 * Opens the virtual keyboard application.
	 * 
	 * @param	$holder (MovieClip) The MovieClip to display the keyboard
	 * @param	$targetFld (TextField) The text field to display the text combined through key inputs
	 * @param	$caretColor (Number) The color of the caret that indicates the input position in the text field
	 * @param	$isSignIn (Boolean) Whether the type of the input text field is for sign in
	 * If the input environment is for sign in, the .com key is displayed.	 
	 */
	public function open($holder:MovieClip, $targetFld:TextField, $caretColor:Number, $isSignIn:Boolean, $version:Number):Void {				
			
		caretColor = (isNaN($caretColor))?caretColor:$caretColor;
		
		isSignIn = ($isSignIn == null)?isSignIn:$isSignIn;
		
		targetFld = $targetFld;			
		
		var kPath:String = getGadgetPath($version);				
		
		super.open($holder, kPath);
	}
	
	
	
	
	private function initAppAfterLoad($app:Object):Void {		
		
		var kTxt:String = targetFld.text;
		
		app.init(targetFld, isSignIn, lang );
		
		targetFld.text = kTxt;
		
		app.setCaret(caretColor, caretTime, caretOffsetWidth, caretOffsetHeight, caretOffsetDistanceX, caretOffsetDistanceY);
		
		setInputTextField(targetFld, null, maxLen);
		
	}	
	
	/**
	 * Sets the input text field. The text entered using the keyboard is combined in the text field passed as a parameter.
	 * 
	 * @param	$fld (TextField)
	 * @param $caretIdx (Number)
	 */
	public function setInputTextField($fld:TextField, $caretIdx:Number, $maxLen:Number):Void {
		
		targetFld = null;
		
		targetFld = $fld;
		
		maxLen = $maxLen;
		
		if ($fld != null && app != null) {	
			
			var kCaretIdx:Number = ($caretIdx == null)?$fld.text.length:$caretIdx;				
			
			app.setInputTextField(targetFld, kCaretIdx, $maxLen);
						
		}		
	}
	
	/**
	 * Sets the width and height of the keyboard in pixels.
	 * @param	$wid (Number) 
	 * @param	$hei (Number) 
	 */
	public function setSize($wid:Number, $hei:Number):Void {
		app.setSize($wid, $hei);		
	}
	
	/**
	 * Sets the width and height of the keyboard in ratio.
	 * @param	$xScale (Number) 0 - 100
	 * @param	$yScale (Number) 0 - 100
	 */
	public function setScale($xScale:Number, $yScale:Number):Void {
		app.setScale($xScale, $yScale);		
	}
	
	/**
	 * Initializes and prepares to take the key focus.
	 */
	public function takeFocus():Void {
		app.takeFocus();
	}
	
	/**
	 * Gives up the key focus.
	 */
	
	public function giveUpFocus():Void {
		app.giveUpFocus();
	}
	
	
	/**
	 * Positions the caret to the previous character.
	 */
	public function moveCaretPrev():Void {		
		app.winkPrev(false);		
	}	
	
	/**
	 * Positions the caret to the next character.
	 */
	public function moveCaretNext():Void {
		app.winkNext(false);
	}
	
	/**
	 * Positions the caret to the specified position.
	 * 
	 * @param	$index (Number) The position of the caret 
	 */
	public function moveCaretAt($index:Number):Void {
		app.getCareter().wink(false, $index);
	}
	
	public function moveCareterWithMousePress():Void {
		app.moveCareterWithMousePress();
	}
	
	/**
	 * Sets the visibility of the caret.
	 * 
	 * @param	$visible (Boolean) Whether the caret is visible
	 */
	public function setCaretVisible($visible:Boolean):Void {
		app.setCaretVisible($visible);
	}
	
	/**
	 * Returns the current visibility of the caret as boolean.
	 * 
	 * @return (Boolean) Whether the caret is visible
	 */
	public function getCaretVisible():Boolean {
		return app.getCareter().clip._visible;
	}	
	
	/**
	 * Sets the color of the caret.
	 * @param	$color (Number)
	 */
	public function setCaretColor($color:Number):Void {
		app.setCaretColor($color);
	}
	
	
	/**
	 * Returns the current position of the caret.
	 * 
	 * @return (Number) The current position of the caret 
	 */
	public function getCaretPostion():Number {
		return app.getCareter().getCaretIdx();
	}
	
	/**
	 * Displays the text passed as a parameter 
	 * in the input text field.
	 * 
	 * @param	$txt (String) The text to be displayed in the text field 
	 */
	public function setInputText($txt:String):Void {
		targetFld.text = $txt;
		moveCaretAt($txt.length);
	}
	
	/**
	 * Returns the text written in the input text field.
	 * 
	 * @return (String) The text in the input text field 
	 */
	public function getInputText():String {
		return targetFld.text;
	}
	
	
	
	private function getGadgetPath($version:Number):String {
		if (isNaN($version)) $version = 2;
		
		var kCommonPath:String =  PathFinder.getCommonPath();
		if ($version == 1) return kCommonPath + "KeyboardGadget/KeyboardGadget.swf";		
		return kCommonPath + "KeyboardGadget/KeyboardGadget_"+$version+".swf";
	}	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kId:String = $evt.id;		
		if (kId == LGEvent.ROLL_OVER || kId == LGEvent.ROLL_OUT) {			
			triggerEvent(kId, this);
		}else {
			super.onEventReceived($evt);
		}
	}
	
	
	
}