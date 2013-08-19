

import lge.views.ImageView;
import lge.views.View;
import lge.apps.LGEvent;

/**
 * Creates a check box and provides the method and event to control it.<br>
 * Note that this object does not provide a label.
 * To create a check box with the label, use the {@link lge.views.CheckButton} object.
 * 
 * {@code
 *  // Create a MovieClip to be used as the checker's background and set the "Identifier" field to "lnk_box" in the "Linkage Properties" window.
 *  // Create a MovieClip to be used as the checker's marker and set the "Identifier" field to "lnk_marker" in the "Linkage Properties" window.
 * // When executed, a checker with checked state is created. Clicking on it toggles its state.
 * 
import lge.views.View;
import lge.views.Checker;
import lge.apps.LGEvent;

var checker:Checker = new Checker();
checker.addEventReceiver(this);
checker.x = 150;
checker.y = 150;
checker.background = "lnk_box";
checker.marker = "lnk_marker";
checker.checked = true;

checker.draw(this);

var mc:MovieClip = checker.getClip();
mc.onPress = function():Void{
	checker.toggle();	
}

function onEventReceived ($evt:LGEvent):Void {
	if($evt.id == LGEvent.CHECK_STATE_CHANGED){
		trace(checker.getChecked());
	}
}

 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onCheckStateChanged
 * 	<li>LGEvent value: CHECK_STATE_CHANGED</li>
 * 	<li>Event fired when the checker's state changes</li>
 * </ul>
 */
class lge.views.Checker extends View {	
	
	/**
	 * Sets the initial state of the checker. Once the checker is created, use the {@link lge.views.Checker#setChecked()} method. (default: false);
	 */
	public var checked:Boolean = false;
	
	/** The background's identifier or external URL 
	 * @see lge.views.ImageView#image*/
	public var background:String;	
	/** The identifier or external URL of the marker 
	 * @see lge.views.ImageView#image*/
	public var marker:String;
	
	/** A constant that indicates the index of the background (ImageView) 
	 * @see lge.views.View#getIndex()*/
	//public static var BG_INDEX:Number = 0;
	private static var _BG_INDEX:Number;
	public static function get BG_INDEX():Number { 
		if (_BG_INDEX == null) _BG_INDEX = VIEW_COUNT++;
		return _BG_INDEX;
	}
	/** A constant that indicates the index of the marker (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _MARKER_INDEX:Number ;
	public static function get MARKER_INDEX():Number { 
		if (_MARKER_INDEX == null) _MARKER_INDEX = VIEW_COUNT++;
		return _MARKER_INDEX;
	}
	
	//--- Override ----
	private function populateElements():Void {		
		createBgView();			
		createCheckMarkView();		
		setChecked(checked);
		
		onDrawCompleted();			
	}
	
	private function createBgView():Void {
		if (background != null) {
			
			var kView:ImageView = new ImageView();	
			kView.index = BG_INDEX;
			kView.image = background;
			kView.width = width;
			kView.height = height;			
			kView.maintainAspectRatio = false;			
			addChildView(kView);	
		}		
	}	
	
	private function createCheckMarkView():Void {		
		if (marker != null) {
			var kView:ImageView = new ImageView();	
			kView.index = MARKER_INDEX;
			kView.image = marker;
			kView.width = width;
			kView.height = height;			
			kView.maintainAspectRatio = false;			
			addChildView(kView);	
		}		
				
	}
	/**
	 * Toggles the checker's status.
	 */
	public function toggle():Void {		
		setChecked(!checked);		
	}
	/**
	 * Sets the checker to the passed parameter.
	 * 
	 * @param	$checked (Boolean) Whether to set the checker to checked
	 */
	public function setChecked($checked:Boolean):Void {
		checked = $checked;
		var kView:ImageView = ImageView(getChildViewAt(MARKER_INDEX));
		kView.setVisible(checked);
		
		triggerEvent(LGEvent.CHECK_STATE_CHANGED, this);
	}
	/**
	 * Returns the status of the checker. (true if it is checked; otherwise false)
	 * 
	 * @return (Boolean)
	 */
	public function getChecked():Boolean {
		return checked;
	}
	
}