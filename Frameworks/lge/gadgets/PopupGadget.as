

import lge.apps.LGEvent;
import lge.apis.PathFinder;
import lge.gadgets.Gadget;


/**
 * Loads an intrinsic popup and provides the method and event to control it.
 * Developers can add the icon, title, message and buttons in the popup.
 * The width of the popup is resized horizontally according to the size of the message.
 * {@code
 * // Insert the following code in the first frame of the stage.
 * // When the loading is completed, the gadget is aligned to the center of the window and a KeyHandler is attached to it. 
 * // When the button is clicked, a value is displayed in the output window.
 * 
 *
 * import lge.gadgets.PopupGadget;
 * import lge.apps.LGEvent;
 * 
 * var title:String = "This is Title";
 * var msg:String = "This is body message. It's extending according text length. Wow it's Great. Anyway you can click a button";
 * var btnLabelArr:Array = ["OK", "Cancel"];
 * 
 * var holder:MovieClip = this.createEmptyMovieClip("holder",1);
 * var popupWin:PopupGadget = new PopupGadget();
 * popupWin.open(holder,title, msg, 2,btnLabelArr);
 * function onEventReceived($evt:LGEvent):Void{
 * 	var kID:String = $evt.id;
 * 	if(kID==LGEvent.DRAW_COMPLETED){		
 * 		var kX:Number = (Stage.width-popupWin.getWidth())/2;
 * 		var kY:Number = (Stage.height-popupWin.getHeight())/2;		
 * 		popupWin.setPosition(kX,kY);
 * 		popupWin.attachKeyHandler();
 * 	}else if(kID==LGEvent.SELECT_BUTTON){
 * 		var kIdx:Number = popupWin.getFocusedButtonIndex();
 * 		trace("selected btn index is "+kIdx);
 * 	}
 * }
 * popupWin.addEventReceiver(this);
 * }
 * <br><br>
 * 
 * Events fired:
 * 
 * <ul> onSelectButton
 * 	<li>LGEvent value: SELECT_BUTTON</li>
 * 	<li>Event fired when the button of PopupGadget is selected</li>
 * </ul>
 */

class lge.gadgets.PopupGadget extends Gadget {
	
	public function dealloc():Void {	
		buttonLabelArray = null;
		
		super.dealloc();
	}	
	
	private var title:String;
	private var message:String;
	private var iconType:Number;
	private var buttonLabelArray:Array;
	private var titleFontSize:Number ;
	private var messageFontSize:Number;
	private var titleAlign:String;
	private var messageAlign:String;
	
	public static var ICON_ALERT:Number = 0;
	public static var ICON_ERROR:Number = 1;
	public static var ICON_INFO:Number = 2;
	public static var ICON_HELP:Number = 3;
	
	private var centerWin:Boolean = true;
	
	/**
	 * Opens the popup application.
	 * 
	 * @param	$holder (MovieClip) The MovieClip to load the popup application
	 * @param	$title (String) The label to be displayed in the popup title 
	 * @param	$msg (String) The text to be displayed in the popup body 
	 * @param	$iconType (Number) The icon to be displayed on the left of the title<br>
	 * Alert icon - 0<br>
	 * Error icon - 1<br>
	 * Information icon - 2<br>
	 * Help icon - 3
	 * @param	$btnLabelArr (Array) An array of the labels of the buttons to be displayed at the bottom of the popup (if it is null, no button is displayed.)	 
	 * @param	$centerWin (Boolean) 
	 * @param	$titleFontSize (Number)  The font size of the title (default: 26)
	 * @param	$msgFontSize (Number)  The font size of the message (default: 24)
	 * @param	$titleAlign (String) The alignment of the title text (left/center/right, default: center)
	 * @param	$msgAlign (String) The alignment of the message text (left/center/right, default: center)
	 */	
	public function open($holder:MovieClip, $title:String, $msg:String, $iconType:Number, $btnLabelArr:Array, $centerWin:Boolean,$titleFontSize:Number, $msgFontSize:Number, $titleAlign:String, $msgAlign:String):Void {			
		
		title = $title;
		message = $msg;
		iconType = $iconType;
		buttonLabelArray = $btnLabelArr;		
		centerWin = ($centerWin == null)?true:$centerWin;	
		
		titleFontSize = $titleFontSize;
		messageFontSize = $msgFontSize;
		titleAlign = $titleAlign;
		messageAlign = $msgAlign;
		
		super.open($holder, getGadgetPath());		
	}
		
	private function initAppAfterLoad($app:Object):Void {
		
		app.init(title, message, iconType, buttonLabelArray, centerWin, titleFontSize, messageFontSize, titleAlign, messageAlign);
		
	}	
	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kId:String = $evt.id;
		switch(kId) {
			case LGEvent.KEY_PRESSED:
				doSomeWithKey($evt.data.code);
			break;
			
			default:
				super.onEventReceived($evt);
			break;
		}
						
	}	
	
	/**
	 * Returns the index of the currently focused button.
	 * @return (Number) The index of the currently focused button 
	 */
	public function getFocusedButtonIndex():Number {
		return app.getFocusedButtonIndex();
	}
	
	private function getGadgetPath():String{
		return PathFinder.getCommonPath()+"PopupGadget/PopupGadget.swf";
	}
	
	
	
	
}