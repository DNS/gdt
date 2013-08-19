

import lge.views.Checker;
import lge.views.Button;
import lge.apps.LGEvent;

/**
 * Creates a button with a check box and label and provides the method and event to control it.
 * 
 * {@code
 *  // Create a MovieClip to be used as the background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
 *  // Create a MovieClip to be used as the checker's background and set the "Identifier" field to "lnk_box" in the "Linkage Properties" window.
 *  // Create a MovieClip to be used as the checker's marker and set the "Identifier" field to "lnk_marker" in the "Linkage Properties" window.
 * 
import lge.apps.LGEvent;
import lge.views.View;
import lge.views.Button;
import lge.views.CheckButton;

var layout:View = new View();
layout.addEventReceiver(this);
layout.draw(this);

var btn:CheckButton = new CheckButton();
{
	btn.addEventReceiver(this);
	btn.x = 150;
	btn.y = 150;

	btn.backgroundWidth = 200;

	btn.background = "lnk_bg_btn";
	btn.label = "Checker";

	btn.checkerBackground = "lnk_box";
	btn.checkerMarker = "lnk_marker";
	btn.checked = false;
};

layout.addChildView(btn);

function onEventReceived($evt:LGEvent):Void {
	var kID:String = $evt.id;
	if (kID == LGEvent.DRAW_COMPLETED) {
		var kBgView:View = btn.getChildViewAt(Button.BG_INDEX);
		var kLabel:View = btn.getChildViewAt(Button.LABEL_INDEX);
		var kChecker:View = btn.getChildViewAt(CheckButton.CHECK_INDEX);

		// Sets the position of the checker.
		var kY:Number = (kBgView.height-kChecker.height)/2;
		kChecker.setPosition(4,kY);
		// Sets the position of the label.
		var kX:Number = kChecker.x+kChecker.width+4;
		kY = (kBgView.height-kLabel.height)/2;
		kLabel.setPosition(kX,kY);

	}
}
 * }
 */

class lge.views.CheckButton extends Button {		
	
	/** The identifier of the checker's background or external URL 
	 * @see lge.views.ImageView#image*/
	public var checkerBackground:String;
	/** The identifier of the checker's marker or external URL 
	 * @see lge.views.ImageView#image*/
	public var checkerMarker:String;
	
	/** The X coordinate of the checker 
	 * @see lge.views.View#x*/
	public var checkerX:Number;
	/** The Y coordinate of the checker 
	 * @see lge.views.View#y*/
	public var checkerY:Number;
	/** The width of the checker 
	 * @see lge.views.View#width*/
	public var checkerWidth:Number;
	/** The height of the checker 
	 * @see lge.views.View#height*/
	public var checkerHeight:Number;	
	/**
	 * Sets the initial state of the checker. (default: false);
	 */
	public var checked:Boolean = false;
	
	/** A constant that indicates the index of the checker. It is set to {@link lge.views.View #getNextHighestChildIndex()} when CheckButton is created.
	 * @see lge.views.View#getIndex()*/
	private static var _CHECK_INDEX:Number;
	public static function get CHECK_INDEX():Number { 
		if (_CHECK_INDEX == null) _CHECK_INDEX = VIEW_COUNT++;
		return _CHECK_INDEX;
	}
	
		
	private function populateElements():Void {
		
		super.populateElements();
		
		createChecker();	
		
	}	
	
	
	private function createChecker():Void {
		
		var kView:Checker = new Checker();
		kView.addEventReceiver(this);		
		kView.index = CHECK_INDEX;		
		kView.background = checkerBackground;
		kView.marker = checkerMarker;
		kView.checked = checked;		
		kView.width = checkerWidth;
		kView.height = checkerHeight;
		kView.x = checkerX;
		kView.y = checkerY;			
		
		addChildView(kView);	
			
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;
		if (kID == LGEvent.CHECK_STATE_CHANGED) {
			triggerEvent(kID, this);
		}else {
			super.onEventReceived($evt);
		}
						
	}	
	
	private function onPress():Void {
		super.onPress();
		toggle();
	}
	
	/**
	 * Toggles the checker's status.
	 */
	public function toggle():Void {
		var kChecker:Checker = Checker(getChildViewAt(CHECK_INDEX));
		
		kChecker.toggle();
	}
	
	/**
	 * Sets the checker to the passed parameter.
	 * 
	 * @param	$checked (Boolean) Whether to set the checker to checked
	 */
	public function setChecked($checked:Boolean):Void {
		var kChecker:Checker = Checker(getChildViewAt(CHECK_INDEX));
		kChecker.setChecked($checked);
	}
	
	/**
	 * Returns the status of the checker. (true if it is checked; otherwise false)
	 * 
	 * @return (Boolean)
	 */
	public function getChecked():Boolean {
		var kChecker:Checker = Checker(getChildViewAt(CHECK_INDEX));
		return kChecker.getChecked();
	}
	
}