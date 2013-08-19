

import lge.views.ImageView;
import lge.views.TextView;
import lge.views.View;
import lge.apps.LGEvent;
/**
 * Creates a button with the background and label
 * and provides the method and event to control it.
 * It also creates handlers to respond to events.
 * 
 * {@code
 *
 * // Create a new MovieClip and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
import lge.views.Button;
import lge.views.TextView;
import lge.apps.LGEvent;

var view:Button = new Button();
view.addEventReceiver(this);

view.x = 120;
view.y = 50;
view.background = "lnk_bg_btn";
view.backgroundWidth = 300;
view.backgroundHeight = 44;
view.label = "Hello this is first work";

view.draw(this);

function onEventReceived($evt:LGEvent):Void {
	var kID:String = $evt.id;
	// The button status change can be checked.
	var btn:Button = Button($evt.data);
	var textview:TextView = TextView(btn.getChildViewAt(Button.LABEL_INDEX));
	if (kID == LGEvent.FOCUS_BUTTON) {
		// Scrolls the text when the button gains focus. 
		textview.startScroll();		
	} else if(kID == LGEvent.NORMAL_BUTTON || kID == LGEvent.SELECT_BUTTON){
		textview.stopScroll();
	}
}
 * 
 * }
 * 
 * <br><br>
 * 
 * Events fired:
 * <ul> onSelectButton
 * 	<li>LGEvent value: SELECT_BUTTON</li>
 * 	<li>Event fired when the button is selected</li>
 * </ul>
 * <ul> onNormalButton
 * 	<li>LGEvent value: NORMAL_BUTTON</li>
 * 	<li>Event fired when the button returns to the default status</li>
 * </ul>
 * <ul> onFocusButton
 * 	<li>LGEvent value: FOCUS_BUTTON</li>
 * 	<li>Event fired when the button gains focus</li>
 * </ul>
 * <ul> onRollOver
 * 	<li>LGEvent value: ROLL_OVER</li>
 * 	<li>Event fired when the mouse is rolled over</li>
 * </ul>
 * <ul> onRollOut
 * 	<li>LGEvent value: ROLL_OUT</li>
 * 	<li>Event fired when the mouse is rolled out</li>
 * </ul>
 * <ul> onRelease
 * 	<li>LGEvent value: RELEASE</li>
 * 	<li>Event fired when the mouse is released</li>
 * </ul>
 * <ul> onPress
 * 	<li>LGEvent value: PRESS</li>
 * 	<li>Event fired when the mouse is pressed</li>
 * </ul>
 */

 
class lge.views.Button extends View {	
	
	public function dealloc():Void {
		detachMouseEvent();
		super.dealloc();
	}
	/** Labels displayed 
	 * @see lge.views.TextView#label
	 */
	public var label:String;
	
	/** The color of the label when the button is in normal status (default: 0x000000)
	 * @see lge.views.TextView#fontColor */
	public var normalFontColor:Number = 0x000000;
	
	/** The color of the label when the button gains focus (default: 0xFFFFFF)*/
	public var focusedFontColor:Number = 0xFFFFFF;
	
	/** The color of the label when the button is selected (default: 0xFFFFFF)*/
	public var selectedFontColor:Number = 0xFFFFFF;
	
	/** The font size of the label (defailt: 20)
	 * @see lge.views.TextView#fontSize*/
	
	public var fontSize:Number = 20;
	
	/** The X coordinate of the label (default: center of the button)
	 * @see lge.views.View#x*/
	public var labelX:Number;
	
	/** The Y coordinate of the label (default: center of the button)
	 * @see lge.views.View#y*/
	public var labelY:Number;	
	
	/** The identifier of the background or external URL 
	 * @see lge.views.ImageView#image*/
	public var background:String;
	/** The width of the background 
	 * @see lge.views.View#width*/
	public var backgroundWidth:Number;
	/** The height of the background 
	 * @see lge.views.View#height*/
	public var backgroundHeight:Number;
	/** The X coordinate of the background 
	 * @see lge.views.View#x*/
	public var backgroundX:Number;
	/** The Y coordinate of the background 
	 * @see lge.views.View#y*/
	public var backgroundY:Number;
	/** Whether to keep the aspect ratio of the background (default: false) 
	 * @see lge.views.ImageView#maintainAspectRatio*/
	public var backgroundMaintainAspectRatio:Boolean = false;	
	
	/** A constant that indicates the normal button */
	public static var NORMAL:String = "normal";
	/** A constant that indicates the selected button */
	public static var SELECTED:String = "selected";
	/** A constant that indicates the focused button */
	public static var FOCUSED:String = "focused";
	
	/** A constant that the index of the button background (ImageView) 
	 * @see lge.views.View#getIndex()*/
	//public static var BG_INDEX:Number = 0;
	private static var _BG_INDEX:Number;
	public static function get BG_INDEX():Number { 
		if (_BG_INDEX == null) _BG_INDEX = VIEW_COUNT++;
		return _BG_INDEX;
	}
	/** A constant that the index of the button label (TextView) 
	 * @see lge.views.View#getIndex()*/
	//public static var LABEL_INDEX:Number = 1;	
	private static var _LABEL_INDEX:Number;
	public static function get LABEL_INDEX():Number { 
		if (_LABEL_INDEX == null) _LABEL_INDEX = VIEW_COUNT++;
		return _LABEL_INDEX;
	}
	
	private var state:String;
	
	
	private function populateElements():Void {
		createBgView();				
				
		createLabelView();	
		
		positionLabel();
		
		normal();
		
		attachMouseEvent();
	}
	
	
	private function createBgView():Void {		
		if (background != null) {
			var kView:ImageView = new ImageView();	
			
			kView.addEventReceiver(this);
			kView.putString("name", "btn_bg");
			
			kView.index = BG_INDEX;
			kView.image = background;
			kView.width = backgroundWidth;
			kView.height = backgroundHeight;
			kView.x = backgroundX;
			kView.y = backgroundY;
			kView.maintainAspectRatio = backgroundMaintainAspectRatio;
			
			addChildView(kView);	
		}		
	}	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;
		
		if (kID == LGEvent.LOAD_SUCCEED) {			
			//--배경이 로드되는 경우엔 로드가 성공한 후에 마우스 이벤트를 붙이도록 한다.
			if ($evt.data.getString("name") == "btn_bg") {
				attachMouseEvent();
			}
			refreshSize();			
		}
		
		super.onEventReceived($evt);
	}
	
	private function createLabelView():Void {
		if (label != null) {
			label = String(label);
		}
		
		if (label.length > 0) {
			var kView:TextView = new TextView();

			kView.index = LABEL_INDEX;		
			kView.label = label;			
			
			kView.fontColor = normalFontColor;
			kView.fontSize = fontSize;			
			kView.x = labelX;
			kView.y = labelY;
			
			addChildView(kView);	
		}		
	}
	
	private function positionLabel():Void {		
		
		var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));
		
		var kLabelView:TextView = TextView(getChildViewAt(LABEL_INDEX));
		
		//-- lableX와 labelY가 지정되어 있지 않으면 중앙 정렬이 Default
		if (labelX == null) {
			labelX = Math.round((kBgView.width - kLabelView.width) / 2);			
		}
		
		if (labelY == null) {
			labelY = Math.round((kBgView.height - kLabelView.height) / 2);
		}		
		
		kLabelView.setPosition(labelX, labelY);		
		
	}
	
	/**
	 * Sets the button to normal status.<br>
	 * - The background MovieClip is moved to frame 1.<br>
	 * - The color of the label is set to normalFontColor.<br>
	 * - It fires the event notifying that the button is set to "normal".
	 * 
	 * @see lge.apps.LGEvent#NORMAL_BUTTON
	 */
	public function normal():Void {
		if (state != NORMAL) {
			state = NORMAL;
			
			var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));		
			var kBgClip:MovieClip = kBgView.getClip();
			
			kBgClip.gotoAndStop(1);
			
			var kTextView:TextView = TextView(getChildViewAt(LABEL_INDEX));
			kTextView.setFontColor(normalFontColor);				
			
			triggerEvent(LGEvent.NORMAL_BUTTON, this);
		}
		
	}
	/**
	 * Sets the button to focused status.<br>
	 * - The background MovieClip is moved to frame 1.<br>
	 * - The color of the label is set to focusedFontColor.<br>
	 * - It fires the event notifying that the button is set to "focused".
	 * @see lge.apps.LGEvent#FOCUS_BUTTON
	 */
	public function focus():Void {
		if (state != FOCUSED) {
			state = FOCUSED;
			
			var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));		
			var kBgClip:MovieClip = kBgView.getClip();
			kBgClip.gotoAndStop(2);
			
			var kTextView:TextView = TextView(getChildViewAt(LABEL_INDEX));
			kTextView.setFontColor(focusedFontColor);		
			
			//triggerEvent(LGEvent.BUTTON_STATE_CHANGED, this);	
			triggerEvent(LGEvent.FOCUS_BUTTON, this);
		}
		
	}
	/**
	 * Sets the button to selected status'.<br>
	 * - The background MovieClip is moved to frame 3.<br>
	 * - The color of the label is set to selectedFontColor.<br>
	 * - It fires the event notifying that the button is set to "selected".
	 * @see lge.apps.LGEvent#SELECT_BUTTON
	 */
	public function select():Void {
		if (state != SELECTED) {
			
			state = SELECTED;
			
			var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));		
			var kBgClip:MovieClip = kBgView.getClip();
			kBgClip.gotoAndStop(3);
			
			var kTextView:TextView = TextView(getChildViewAt(LABEL_INDEX));
			kTextView.setFontColor(selectedFontColor);				
			
			triggerEvent(LGEvent.SELECT_BUTTON, this);
			
		}
		
	}
	/**
	 * Attaches mouse events to the button (default: mouse events are attached).
	 * @see lge.apps.LGEvent#PRESS
	 * @see lge.apps.LGEvent#RELEASE
	 * @see lge.apps.LGEvent#ROLL_OVER
	 * @see lge.apps.LGEvent#ROLL_OUT
	 */
	public function attachMouseEvent():Void {
		
		var kThis:Button = this;
		
		var kEventClip:MovieClip;
		
		if (background == null) {
			kEventClip = getClip();
		}else {
			kEventClip = getChildViewAt(BG_INDEX).getClip();
		}		
		
		
		kEventClip.onRollOver = function():Void {			
			kThis.onRollOver();
		}
		kEventClip.onRollOut = function():Void {
			kThis.onRollOut();
		}
		kEventClip.onPress = function():Void {
			kThis.onPress();
		}
		kEventClip.onRelease = function():Void {
			kThis.onRelease();
		}	
		kEventClip.onReleaseOutside = function():Void {			
			kThis.onRollOut();
		}
		
	}
	/**
	 * Detaches mouse events.
	 */
	public function detachMouseEvent():Void {
		var kEventClip:MovieClip;
		if (background == null) {
			kEventClip = getClip();
		}else {
			kEventClip = getChildViewAt(BG_INDEX).getClip();
		}	
		
		kEventClip.onRollOver = null;
		kEventClip.onRollOut = null;
		kEventClip.onPress = null;
		kEventClip.onRelease = null;
		kEventClip.onReleaseOutside = null;
		
		delete kEventClip.onRollOver;
		delete kEventClip.onRollOut;
		delete kEventClip.onPress;
		delete kEventClip.onRelease;
		delete kEventClip.onReleaseOutside;
		
	}
	
	private function onRollOver():Void {		
		focus();
		triggerEvent(LGEvent.ROLL_OVER, this);			
	}
	
	private function onRollOut():Void {
		normal();
		triggerEvent(LGEvent.ROLL_OUT, this);			
	}
	
	private function onPress():Void {
		select();
		triggerEvent(LGEvent.PRESS, this);			
	}
	
	private function onRelease():Void {
		focus();
		triggerEvent(LGEvent.RELEASE, this);			
	}
	
	/** Returns the button's current status. 
	 * @see lge.views.Button#NORMAL
	 * @see lge.views.Button#SELECTED
	 * @see lge.views.Button#FOCUSED
	 * */
	public function getButtonState():String {
		return state;
	}
	
	
	public function setButtonState($state:String):Void {
		state = $state;
	}
	
}