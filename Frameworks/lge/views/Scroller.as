
import lge.views.ListView;
import lge.views.ImageView;
import lge.views.View;
import lge.utils.NumberUtil;
import lge.apps.LGEvent;
/**
 * Provides the method and event to create and control the scroller.<br>
 * The scroller has 2 basic views.<br>
 * - train: Icon that moves according to the degree.<br>
 * - rail: Shows the path and movement range of the train. 
 * <br><br>
 * If a MovieClip to be used as a scroller is placed on the stage,
 * the scroller can be set and controlled as a view object.<br>
 * Note that the instance specified as the scroller's MovieClip must have 
 * the MovieClips named "rail" and "train".
 * 
 * {@code
 * // Uses a MovieClip on the stage as a scroller.
 * 
import lge.views.Scroller;
import lge.apps.LGEvent;
import lge.views.View;

var topView:View = new View();
topView.setPreBuiltContainer(this);

var scroller:Scroller = new Scroller();
scroller.setPreBuiltContainer(scrollerClip);// The scrollerClip contains the "rail" and "train" MovieClips. 
scroller.addEventReceiver(this);

populateAttributesForScroller(scroller);

topView.addChildView(scroller);

function populateAttributesForScroller($view:Object):Void{	
	$view.x = 180;
	$view.y = 80;	
	$view.orientation = Scroller.VERTICAL;
	$view.minValue = 0;
	$view.maxValue =100;
}

function onEventReceived($evt):Void{
	var kID:String = $evt.id;
	trace(kID+"*** Current Value is "+scroller.getCurrentValue());
}
 * }
 * 
 * <br>
 * {@code
 * // A scroller using a MovieClip in the library
 * 
 * import lge.views.Scroller;
import lge.apps.LGEvent;
import lge.views.View;

var layout:View = new View();
layout.setPreBuiltContainer(this);
layout.addEventReceiver(this);

var scroller:Scroller = new Scroller();
scroller.addEventReceiver(this);
scroller.x = 80;
scroller.y = 80;

populateAttributesForScroller(scroller);

layout.addChildView(scroller);

function populateAttributesForScroller($view:Object):Void{	
	$view.orientation = View.HORIZONTAL;
	$view.minValue = 0;
	$view.maxValue =100;	
	
	$view.rail = "lnk_rail";	
	$view.railWidth = 300;
	$view.railHeight = 10;
	
	$view.train = "lnk_train";	
}

function onEventReceived($evt):Void{
	var kID:String = $evt.id;
	trace(kID+"*** Current Value is "+scroller.getCurrentValue());
}
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onPressRail
 * 	<li>LGEvent value: PRESS_RAIL</li>
 * 	<li>The onPress mouse event occurring in the scroller's rail</li>
 * </ul>
 * <ul> onReleaseRail
 * 	<li>LGEvent vbalue: RELEASE_RAIL</li>
 * 	<li>The onRelease mouse event occurring in the scroller's rail</li>
 * </ul>
 * <ul> onRollOverRail
 * 	<li>LGEvent value: ROLL_OVER_RAIL</li>
 * 	<li>The onRollOver mouse event occurring in the scroller's rail</li>
 * </ul>
 * <ul> onRollOutRail
 * 	<li>LGEvent value: ROLL_OUT_RAIL</li>
 * 	<li>The onRollOut mouse event occurring in the scroller's rail</li>
 * </ul>
 * <ul> onScrollerTrainMoved
 * 	<li>LGEvent value: SCROLLER_TRAIN_MOVED</li>
 * 	<li>Event triggered when the scroller's train moves</li>
 * </ul>
 * <ul> onTrainDragEnded
 * 	<li>LGEvent value: TRAIN_DRAG_ENDED</li>
 * 	<li>Event triggered when the scroller's train is dragged</li>
 * </ul>
 */
class lge.views.Scroller extends View {	
	
	public function dealloc():Void {
		railView.dealloc();
		railView = null;
		
		trainView.dealloc();
		trainView = null;
		
		railClip = null;
		trainClip = null;
		
		boundListView = null;
		boundTextField = null;
		
		super.dealloc();
	}
	
	public var orientation:String = HORIZONTAL;
	
	/**
	 * The minimum value of the scroll
	 */
	public var minValue:Number;
	/**
	 * The maximum value of the scroll
	 */
	public var maxValue:Number;
	
	/** The identifier or external URL of the rail 
	 * @see lge.views.ImageView#image*/
	public var rail:String;
	/** The identifier or external URL of the train 
	 * @see lge.views.ImageView#image*/
	public var train:String;	
	
	
	/** The width of the rail 
	 * @see lge.views.View#width*/
	public var railWidth:Number;
	/** The height of the rail 
	 * @see lge.views.View#height*/
	public var railHeight:Number;
	
	/** The width of the train 
	 * @see lge.views.View#width*/
	public var trainWidth:Number;
	/** The height of the train 
	 * @see lge.views.View#height*/
	public var trainHeight:Number;
	
	/** Whether to resize the train (default: false)
	 * */
	public var trainResizable:Boolean = false;	
	
	/** A constant that indicates the index of the rail (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _RAIL_INDEX:Number ;
	public static function get RAIL_INDEX():Number { 
		if (_RAIL_INDEX == null) _RAIL_INDEX = VIEW_COUNT++;
		return _RAIL_INDEX;
	}
	/** A constant that indicates the index of the train (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _TRAIN_INDEX:Number ;
	public static function get TRAIN_INDEX():Number { 
		if (_TRAIN_INDEX == null) _TRAIN_INDEX = VIEW_COUNT++;
		return _TRAIN_INDEX;
	}
	
	private var railView:ImageView;
	private var trainView:ImageView;
	private var railClip:MovieClip;
	private var trainClip:MovieClip;
	
	private var isTrainPressed:Boolean = false;
	private var boundListView:ListView;
	private var boundTextField:TextField;
	
	private var currentValue:Number;	
	
	
	private function populateElements():Void {
		
		railView = createRail();		
		
		trainView = createTrain();			
		
		focusTrain(false);
		initTrainPlace();
		setTrainSize();			
		attachMouseEvent();
		
		setValue(minValue);
		
	}
	
	private function createRail():ImageView {
		
		var kClip:MovieClip = getClip();		
		railClip = kClip.rail;
		
		if (railClip == null && rail == null) {
			return null;
		}		
		
		var kView:ImageView = new ImageView();	
		kView.index = RAIL_INDEX;				
		
		if (railClip != null) {			
			
			kView.setPreBuiltContainer(railClip);						
			
			kView.width = railClip._width;
			kView.height = railClip._height;				
			
			
		}else if (rail != null) {			
			
			kView.image = rail;
			kView.width = railWidth;
			kView.height = railHeight;					
			
			
		}
		
		addChildView(kView);
			
		railWidth = kView.width;
		railHeight = kView.height;
		railClip = kView.getClip();
		
		return kView;		
		
	}	
	
	private function createTrain():ImageView {
		
		var kClip:MovieClip = getClip();		
		trainClip = kClip.train;
		
		if (trainClip == null && train == null) {
			return null;
		}
		
		
		var kView:ImageView = new ImageView();	
		kView.index = TRAIN_INDEX;
		
		if (trainClip != null) {			
			
			kView.setPreBuiltContainer(trainClip);							
			
			kView.width = trainClip._width;
			kView.height = trainClip._height;					
			
			
		}else if (train != null) {	
			
			kView.image = train;
			kView.width = trainWidth;
			kView.height = trainHeight;				
		}
		
		addChildView(kView);	
			
		trainWidth = kView.width;
		trainHeight = kView.height;
		
		trainClip = kView.getClip();
		
		return kView;
	}	
	/**
	 * Whether to focus the scroller's train.
	 * (If the train MovieClip has 2 frames, it is moved to the second frame when it is focused.)
	 * 
	 * @param	$showFocus (Boolean) Whether to focus 
	 */
	public function focusTrain($showFocus:Boolean):Void {		
		if ($showFocus) {			
			trainClip.gotoAndStop(2);					
		}else {			
			trainClip.gotoAndStop(1);			
		}		
	}
	
	private function initTrainPlace():Void {
		
		var kX:Number = trainClip._x;
		var kY:Number = trainClip._y;
		if (getIsHorizontal()) {
			kY = Math.round(railClip._y + (railClip._height - getTrainOffsetY()) / 2);			
		}else {
			kX = Math.round(railClip._x + (railClip._width - getTrainOffsetX()) / 2);			
		}
		trainView.setPosition(kX, kY);
	}	
	
	
	
	private function setTrainSize():Void {		
		if (trainResizable) {
			var kGap:Number = getValueGap();
			if (!isNaN(kGap)) {	
				var kMinSize:Number = 10;
				if (getIsHorizontal()) {
					var kWid:Number = Math.round(railClip._width / (kGap + 1));
					kWid = Math.max(kWid, kMinSize);
					//trainClip._width = kWid;
					trainView.setSize(kWid, null);
				}else {
					var kHei:Number = Math.round(railClip._height / (kGap + 1));
					kHei = Math.max(kHei, kMinSize);
					//trainClip._height = kHei;
					trainView.setSize(null, kHei);
				}
			}			
		}
		trainWidth = trainClip._width;
		trainHeight = trainClip._height;
	}	
	/**
	 * Adds mouse event handlers to the scroller's train and rail.
	 */
	public function attachMouseEvent():Void {
		var kScroller:Scroller = this;
		
		trainClip.onRollOver = function():Void {
			kScroller.onRollOverTrain();
		}
		
		trainClip.onRollOut = function():Void {
			kScroller.onRollOutTrain();
		}
		
		trainClip.onReleaseOutside = function():Void {
			kScroller.onRollOutTrain();
		}
		
		trainClip.onPress = function():Void {
			kScroller.onPressTrain();	
		}		
		
		
		railClip.onPress = function ():Void {
			kScroller.onPressRail();
		}
		
		railClip.onRelease = function():Void {
			kScroller.onReleaseRail();
		}
		
		railClip.onRollOver = function():Void {
			kScroller.onRollOverRail();
		}
		
		railClip.onRollOut = function():Void {
			kScroller.onRollOutRail();
		}
		
		railClip.onReleaseOutside = function():Void {
			kScroller.onRollOutRail();
		}
	}
	
	private function onReleaseRail():Void {
		triggerEvent(LGEvent.RELEASE_RAIL, this);
	}
	
	private function onRollOverRail():Void {
		triggerEvent(LGEvent.ROLL_OVER_RAIL, this);
	}
	
	private function onRollOutRail():Void {
		triggerEvent(LGEvent.ROLL_OUT_RAIL, this);
	}
	
	/**
	 * Deletes the mouse event handlers.
	 */
	public function detachMouseEvent():Void {
		Mouse.removeListener(this);
		delete trainClip.onRollOver;
		delete trainClip.onRollOut;
		delete trainClip.onPress;
		
		delete railClip.onPress;
		delete railClip.onRelease;
		delete railClip.onRollOut;
		delete railClip.onRollOver;
		delete railClip.onReleaseOutside;
	}
	
	private function onMouseUp():Void {
		if (isTrainPressed) {
			isTrainPressed = false;
			trainClip.stopDrag();
			Mouse.removeListener(this);
			triggerEvent(LGEvent.TRAIN_DRAG_ENDED, this);
		}		
	}
	
	private function onMouseMove():Void {
		var kCurValue:Number = getCurrentValueWithTrain();
		
		setValueAsMouseEvent(kCurValue);
	}	
	
	private function onRollOverTrain():Void {
		focusTrain(true);		
	}
	
	private function onRollOutTrain():Void {
		focusTrain(false);		
	}
	
	private function onPressTrain():Void {
		isTrainPressed = true;
		Mouse.addListener(this);
		
		var kLeft:Number = getTrainMovableLeft();
		var kTop:Number = getTrainMovableTop();
		var kRight:Number = getTrainMovableRight();
		var kBottom:Number = getTrainMovableBottom();
		
		trainClip.startDrag(false, kLeft, kTop, kRight, kBottom);		
	}
	
	private function onPressRail():Void {
		
		if (getIsHorizontal()) {
			var kHalfWid:Number = Math.round(getTrainOffsetX() / 2);
			var kPressX:Number = clip._xmouse-kHalfWid;
			var kLeft:Number = getTrainMovableLeft();
			var kRight:Number = getTrainMovableRight();
			var kX:Number = NumberUtil.getNumberInScope(kPressX, kLeft, kRight, false);
			//trainClip._x = kX;
			trainView.setPosition(kX, null);
		}else {
			var kHalfHei:Number = Math.round(getTrainOffsetY()/ 2);
			var kPressY:Number = clip._ymouse - kHalfHei;
			var kTop:Number = getTrainMovableTop();
			var kBottom:Number = getTrainMovableBottom();
			var kY:Number = NumberUtil.getNumberInScope(kPressY, kTop, kBottom, false);
			//trainClip._y = kY;
			trainView.setPosition(null, kY);
		}
		
		onMouseMove();	
		
		triggerEvent(LGEvent.PRESS_RAIL, this);
	}
	
	//-- 사용자가 train을 움직였거나, rail을 클릭하여 변하였을 경우
	//-> 변한 값을 이벤트로 발생시켜 전달한다.
	private function setValueAsMouseEvent($value:Number):Void {
		var kCurValue:Number = NumberUtil.getNumberInScope($value, minValue, maxValue, false);
		
		if (kCurValue != currentValue) {
			currentValue = kCurValue;	
			
			doScrollBoundObject();
			
			triggerEvent(LGEvent.SCROLLER_TRAIN_MOVED, this);
		}		
	}	
	
	private function doScrollBoundObject():Void {
		if (boundListView != null) {	
			
			boundListView.moveFocusAt(currentValue);
			
		}else if (boundTextField != null) {
			boundTextField.scroll = currentValue;
		}
	}
	/**
	 * Binds the scroller to the list view.
	 * 
	 * @param	$listView (ListView) The list view to be bound
	 */
	public function bindToListView($listView:ListView):Void {
		boundListView = $listView;
		minValue = 0;
		//maxValue = $listView.getLastScrollIndex();
		maxValue = $listView.getTotalCount()-1;
		setValue($listView.getFocusedIndex());
		
		$listView.addEventReceiver(this);
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;			
		if ($evt.data instanceof ListView) {			
			var kListView:ListView = ListView($evt.data);
			if (kID == LGEvent.FOCUS_CHANGED) {
				//var kScrollIdx:Number = kListView.getScrollIndex();
				//setValue(kScrollIdx);
				var kValue:Number = kListView.getFocusedIndex();
				setValue(kValue);
			}
		}
	}
	/**
	 * Binds the scroller to the text field.
	 * 
	 * @param	$fld (TextField) The text field to be bound
	 */
	public function bindToTextField($fld:TextField):Void {
		boundTextField = $fld;
		minValue = 1;
		maxValue = $fld.maxscroll;
		setValue($fld.scroll);
		
		var kScroller:Scroller = this;
		$fld.onScroller = function():Void {
			kScroller.setValue(this.scroll);			
		}
	}
	
	
	
	/**
	 * Sets the value between the scroller's maximum and minimum and moves the train to the corresponding position.
	 * 
	 * @param	$value
	 */
	public function setValue($value:Number):Void {	
		
		if ($value <= maxValue) placeTrainWithValue($value);
		
	}
	
	private function placeTrainWithValue($value:Number):Void {
		if (!isTrainPressed) {						
			
			currentValue = NumberUtil.getNumberInScope($value, minValue, maxValue, false);
			
			var kGap:Number = getValueGap();			
			
			if (kGap > 0) {				
				var kRate:Number = ($value-minValue) / kGap;				
				var kSpan:Number = getMovableSpan();
				var kDis:Number = Math.round(kSpan * kRate);
				
				if (getIsHorizontal()) {	
					var kX:Number = railClip._x + kDis;					
					trainView.setPosition(kX, null);
				} else {	
					var kY:Number = railClip._y + kDis;					
					trainView.setPosition(null,kY);
				}
			}else if (kGap == 0) {
				if (getIsHorizontal()) {									
					trainView.setPosition(0, null);
				} else {										
					trainView.setPosition(null,0);
				}
			}
		}
		
	}
	
	
	
	
	/**
	 * Returns the value corresponding to the train's position.
	 * 
	 * @return (Number)
	 */
	public function getCurrentValue():Number {
		return currentValue;
	}
	
	private function getCurrentValueWithTrain():Number {
		var kMovedRate:Number = getTrainMovedRate();
		
		var kCurValue:Number = minValue + Math.round(getValueGap() * kMovedRate);
		
		return kCurValue;
	}
	
	private function getTrainMovedRate($pos:Number):Number {	
		var kMovedSpan:Number;	
		
		if (getIsHorizontal()) {
			kMovedSpan = trainClip._x - railClip._x;
		}else {
			kMovedSpan = trainClip._y - railClip._y;
		}	
		
		var kMovableSpan:Number = getMovableSpan();
		
		if (kMovableSpan > 0) {
			return kMovedSpan / kMovableSpan;
		}
		return 0;
	}
	
	private function getValueGap():Number {
		return (maxValue-minValue);
	}
	 
	private function getTrainMovableLeft():Number {	
		if (getIsHorizontal()) {			
			return railClip._x;
		}
		return trainClip._x;		
	}
	
	private function getTrainMovableRight():Number {	
		if (getIsHorizontal()) {			
			return railClip._x + railClip._width - getTrainOffsetX();
		}
		return trainClip._x;		
	}
	
	private function getTrainMovableTop():Number {	
		if (getIsHorizontal()) {			
			return trainClip._y;
		}
		return railClip._y;	
	}
	
	private function getTrainMovableBottom():Number {	
		if (getIsHorizontal()) {			
			return trainClip._y;
		}
		return railClip._y + railClip._height - getTrainOffsetY();	
	}	
	
	private function getProperTrainWidth():Number {
		
		if (trainWidth == null) {
			if (getIsHorizontal()) {
				return Math.round(railWidth/4);				
			}
			return railWidth;				
		}
		return trainWidth;
	}
	
	private function getProperTrainHeight():Number {
		if (trainHeight == null) {
			if (getIsHorizontal()) {
				return railHeight;				
			}
			return Math.round(railHeight/4);				
		}
		return trainHeight;
	}
	
	
	private function getMovableSpan():Number {
		var kSpan:Number;
		
		if (getIsHorizontal()) {
			
			kSpan = railClip._width - getTrainOffsetX(); 
			
		} else {
			
			kSpan = railClip._height - getTrainOffsetY(); 
			
		}
		return kSpan;
	}
	
	private function getIsHorizontal():Boolean {
		return (orientation == HORIZONTAL);
	}
	
	private function getTrainOffsetX():Number {
		return trainClip._width;
	}
	
	private function getTrainOffsetY():Number {
		return trainClip._height;
	}
}