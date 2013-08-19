

import lge.apps.LGEvent;
import lge.utils.StringUtil;
import lge.views.Button;
import lge.views.GridView;
import lge.views.ImageView;
import lge.views.TextView;
//import lge.utils.ClipUtil;

/**
 * Provides the calendar type of a grid view.
 * 
 * {@code
 * 
// Create a MovieClip to be used as the item's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.

import lge.views.CalendarView;

var lv:CalendarView = new CalendarView();
lv.addEventReceiver(this);
lv.x = 20;
lv.y = 20;

lv.itemBackground = "lnk_bg_btn";

lv.draw(this);

lv.takeFocus();

Key.addListener(this);
this.onKeyDown = function():Void  {
	var kCode:Number = Key.getCode();
	lv.doSomeWithKey(kCode);
};

function onEventReceived($evt){
	trace($evt.id);
}

 * }
 * 
 * 
 * Events fired:
 * 
 * <ul> onTryToMoveBeyoundRightBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_RIGHT</li>
 * 	<li>Event fired when the focus of CalendarView tries to move outside the right border. This event only occurs on the last day.</li>
 * </ul>
 * <ul> onTryToMoveBeyoundLeftBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_LEFT</li>
 * 	<li>Event fired when the focus of CalendarView tries to move outside the left border. This event only occurs on the first day.</li>
 * </ul>
 * <ul> onTryToMoveBeyoundTopBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_TOP</li>
 * 	<li>Event fired when the focus of CalendarView tries to move outside the top border. This event only occurs on the first day.</li>
 * </ul>
 * <ul> onTryToMoveBeyoundBottomBorder
 * 	<li>LGEvent value: TRY_TO_MOVE_BEYOND_BOTTOM</li>
 * 	<li>Event fired when the focus of CalendarView tries to move outside the bottom border. This event only occurs on the last day.</li>
 * </ul>
 */
class lge.views.CalendarView extends GridView {	
	
	public function dealloc():Void {
		dateArr = null;
		super.dealloc();
	}
	
	/**
	 * The year displayed. For example, year 2010 is displayed as 2010 (default: the year of the setting date).
	 */
	public var year:Number;
	/**
	 * The month displayed. For example, January is displayed as 1 and February is 2 (default: the month of the setting date).
	 */
	public var month:Number;	
	
	private var dateArr:Array;	
	private var availableFirstIdx:Number;
	private var availableLastIdx:Number;	
	private var MAX_ROW_INDEX:Number = 4;		
	
	
	private function populateElements():Void {			
		
		rectifyDateProperties(year, month);	
		
		super.populateElements();	
				
	}
	
	private function createMasker():Void {		
	}
	
	/**
	 * Updates the calendar.
	 * 
	 * @param	$year (Number) The year. It must be in full year format. For example, 1983 and 2010
	 * @param	$month (Number) The month. 1 for January and 2 for February.
	 */
	public function updateCalendar($year:Number, $month:Number):Void {		
		
		rectifyDateProperties($year, $month);
		
		updateView();			
		
	}
	
	
	
	private function rectifyDateProperties($year:Number, $month:Number):Void {	
		
		rectifyColumnAndRowCount();
		
		labelX = (labelX == null)?1:labelX;
		labelY = (labelY == null)?1:labelY;
		
		var kDate:Date = new Date();
		if ($year == null) {			
			year = kDate.getFullYear();					
		}else {
			year = $year;
		}
		
		if ($month == null) {
			month = kDate.getMonth() + 1;	
		}else if ($month > 12) {			
			month = $month-12;			
		}else if ($month < 1) {
			month = 12;
		}else {
			month = $month;
		}
		
		dateArr = getDateArray(year, month);		
		
		labelArray = getLabelArrayWithDateArray(dateArr);	
		
	}
	
	//--처음 한번만 호출 된다.-----
	private function initializeView():Void {
		var kIdx:Number;
		var kTotal:Number = getTotalCount();		
		
		var kEndRow:Number = Math.floor(kTotal / columnCount);
		var kRow:Number;				
		//-- row loop
		for (var i:Number = 0; i < rowCount; i++) {				
			kRow = i;
			if (kRow >= 0 && kRow <= kEndRow) {
				//-- col loop
				for (var j:Number = 0; j < columnCount; j++) {
					kIdx = getIdxWithColAndRow(j,kRow);
					if (kIdx < kTotal) {
						
						drawItem(kIdx);
						
					}else {
						return;
					}
				}
			}			
		}	
		
	}
	
	private function updateView():Void {
		var kLen:Number = getTotalCount();
		for (var i:Number = 0; i < kLen; i++) {
			updateItem(i);
		}
	}
	
	
	private function drawItem($idx:Number):Void {
		
		super.drawItem($idx);
		
		makeButtonActiveAndCombine($idx);		
		
	}

	
	private function createButton($idx:Number):Button {
		var kBtn:Button = new Button();
		populateButtonAttributes(kBtn, $idx);	
		if (kBtn.label == null) {
			kBtn.label = "00";
		}
		return kBtn;
	}
	
	private function updateItem($idx:Number):Void {
		var kBtn:Button = Button(getChildViewAt($idx));
		var kLabelView:TextView = TextView(kBtn.getChildViewAt(Button.LABEL_INDEX));
		//--width를 null로 지정하지 않으면 이전 width로 크기를 조절하기 때문에 
		kLabelView.width = null;
		kLabelView.setLabel(labelArray[$idx]);
		
		makeButtonActiveAndCombine($idx);
		
	}
	
	private function makeButtonActiveAndCombine($idx:Number):Void {
		var kBtn:Button = Button(getChildViewAt($idx));
		
		var kVis:Boolean =  ($idx < labelArray.length)
		
		kBtn.setVisible(kVis);		
		
		
		if ($idx < availableFirstIdx || $idx > availableLastIdx) {						
			
			makeButtonActive(kBtn, false);	
			
		}else {
			
			makeButtonActive(kBtn, true);
			
			var kRow:Number = getRowIdxWithItemIdx($idx);
			
			if (kRow > MAX_ROW_INDEX) {
				combineTwoItems(Button(getChildViewAt($idx - 7)), kBtn);
			}else {
				//kBtn.setScale(null, 1);
				var kBg:ImageView = ImageView(kBtn.getChildViewAt(Button.BG_INDEX));
				kBg.setScale(null, 1);
			}
			
		}
	}
	
	private function getHalfItemIdxLst():Array {
		//35,36
		
		var kCheckLst:Array = [35, 36];
		
		var kLst:Array = new Array();
		var kIdx:Number;
		for (var i:Number = 0; i < kCheckLst.length; i ++ ) {
			
			kIdx = kCheckLst[i];
			
			if (kIdx >=availableFirstIdx && kIdx <= availableLastIdx) {				
				var kRow:Number = getRowIdxWithItemIdx(kIdx);				
				if (kRow > MAX_ROW_INDEX) {
					kLst.push(kIdx - 7);
					kLst.push(kIdx);					
				}			
			}
		}
		return kLst;
	}
	
	
	
	private function combineTwoItems($btn_1:Button, $btn_2:Button):Void {
		//$btn_1.setScale(null, 0.5);
		//$btn_2.setScale(null, 0.5);
		//$btn_2.setPosition(null, $btn_1.y + $btn_1.height);
		
		var kBg_1:ImageView = ImageView($btn_1.getChildViewAt(Button.BG_INDEX));
		var kBg_2:ImageView = ImageView($btn_2.getChildViewAt(Button.BG_INDEX));
		kBg_1.setScale(null, 0.5);
		kBg_2.setScale(null, 0.5);
		
		$btn_2.setPosition(null, $btn_1.y + kBg_1.height);
		
	}
	
	private function makeButtonActive($btn:Button,$active:Boolean):Void {
		if ($active) {
			$btn.setAlpha(100);
			$btn.attachMouseEvent();
		}else {
			$btn.setAlpha(20);
			$btn.detachMouseEvent();
		}
		
	}	
	
	
	private function getDateArray($year:Number, $month:Number):Array {
		var kLst:Array = new Array();
		
		var kMonthIdx:Number = $month - 1;
		var kDate:Date = new Date($year, kMonthIdx);
		var kMilli:Number = kDate.getTime();
		var kDayMilli:Number = 24 * 60 * 60 * 1000;
		var kObj:Object;
		while (kDate.getMonth() == kMonthIdx) {
			kObj = { il:kDate.getDate(), dayIdx:kDate.getDay(), milli:kMilli, month:month };
			kLst.push( kObj );
			kMilli += kDayMilli;
			kDate = new Date(kMilli);			
		}
		
		//--이전달 채우기--첫날이 일요일이 아니면 남아 있는 칸을 이전달로 채운다.
		var kFirstDate:Object = kLst[0];
		
		var kPreLst:Array = new Array();
		if (kFirstDate.dayIdx > 0) {
			kMilli = kFirstDate.milli;
			for (var i:Number = 0; i < kFirstDate.dayIdx; i++) {
				kMilli -= kDayMilli;
				kDate = new Date(kMilli);
				kObj = { il:kDate.getDate(), dayIdx:kDate.getDay(), milli:kMilli, month:month-1 };
				kPreLst.push( kObj );
			
			}
			kPreLst.reverse();
			kLst = kPreLst.concat(kLst);
		}
		
		//--- 실지 이달의 첫번째 index
		availableFirstIdx = kPreLst.length;
		availableLastIdx = kLst.length - 1;
		
		
		//--다음달 채우기-- 끝나는 달이 토요일이 아니면 남아 있는 칸을 다음달로 채운다.
		var kLastRow:Number = getRowIdxWithItemIdx(kLst.length - 1);
		if (kLastRow <= MAX_ROW_INDEX) {
			var kLastDate:Object = kLst[kLst.length-1];
					
			if (kLastDate.dayIdx < 6) {
				kMilli = kLastDate.milli;
				for (var i:Number = kLastDate.dayIdx; i < 6; i++) {
					kMilli += kDayMilli;
					kDate = new Date(kMilli);
					kObj = { il:kDate.getDate(), dayIdx:kDate.getDay(), milli:kMilli, month:month+1 };
					kLst.push( kObj );			
				}
				
			}	
		}		
		
		return kLst;
	}	
	
	
	private function getLabelArrayWithDateArray($dateArr:Array):Array {
		var kLen:Number = $dateArr.length;
		var kLst:Array = new Array();
		var kOne:Object;
		
		for (var i:Number = 0; i < kLen; i++) {
			kOne = $dateArr[i];
			kLst.push(kOne.il);
		}
		
		return kLst;
	}
	
	
	/**
	 * Moves the focus to the left.
	 */
	public function moveFocusLeft():Void {
		if (focusedIdx <= availableFirstIdx) {
			triggerEvent(LGEvent.TRY_TO_MOVE_BEYOND_LEFT, this);
		}else{
			moveFocusAt(focusedIdx - 1);			
		}	
	}
	/**
	 * Moves the focus to the right.
	 */
	public function moveFocusRight():Void {
		if (focusedIdx >= availableLastIdx) {
			triggerEvent(LGEvent.TRY_TO_MOVE_BEYOND_RIGHT, this);
		}else{
			moveFocusAt(focusedIdx + 1);			
		}	
	}
	/**
	 * Moves the focus up.
	 */
	public function moveFocusUp():Void {
		if (focusedIdx <= availableFirstIdx) {
			triggerEvent(LGEvent.TRY_TO_MOVE_BEYOND_TOP, this);
		}else{
			moveFocusAt(focusedIdx - columnCount);			
		}
		
	}
	/**
	 * Moves the focus down.
	 */
	public function moveFocusDown():Void {		
		if (focusedIdx >= availableLastIdx) {
			triggerEvent(LGEvent.TRY_TO_MOVE_BEYOND_BOTTOM, this);
		}else{
			moveFocusAt(focusedIdx + columnCount);			
		}
	}
	
	
	private function getValidIndex($idx:Number):Number {
		if ($idx < availableFirstIdx) {
			return availableFirstIdx
		}else if ($idx > availableLastIdx) {
			return availableLastIdx;
		}
		return $idx;
	}
	
	//-- 스크롤이 없기 때문에 빈채로 둔다.
	private function doScroll($scrollIdx:Number):Void {			
	}
	
	
	/**
	 * Returns the day of week for the currently focused date in formatted string.
	 * 
	 * @param	$format (String) Available formats are: "UUU" (StringUtil.FORMAT_DAY_UUU, 'MON'),
	 * "k" (StringUtil.FORMAT_DAY_K, '월') and "ull" (StringUtil.FORMAT_DAY_ULL, 'Mon').
	 * @return (String)
	 */
	public function getFocusedDay($format:String):String {
		return getDayAt(focusedIdx,$format);
		
		
	}
	/**
	 * Returns the currently focused day of the month in number form (e.g. 12 for Day 12 and 30 for Day 30).
	 * 
	 * @return (Number)
	 */
	public function getFocusedDate():Number {
		return getDateAt(focusedIdx);
	}
	
	/**
	 * Moves the focus to the item corresponding to the day of the month passed as the parameter.
	 * 
	 * @param	$date (Number) Number corresponding to the day of the month for a specified date (e.g. 2 for April 2 and 23 for May 23).
	 */
	
	public function moveFocusWithDate($date:Number):Void {		
		moveFocusAt(getDateIndex($date));		
	}
	
	/**
	 * Returns the index of the item corresponding to the day of the month passed as the parameter.
	 * 
	 * @param	$date (Number) Number corresponding to the day of the month for a specified date (e.g. 2 for April 2 and 23 for May 23).
	 * @return (Number)
	 */
	public function getDateIndex($date:Number):Number {
		
		var kLen:Number = dateArr.length;
		for (var i:Number = availableFirstIdx; i < kLen; i++) {
			if (dateArr[i].il == $date) {
				return i;
			}
		}
		return null;
		
	}
	/**
	 * Returns the day of week for the item in the specified index.
	 * @param	$idx (Number) The index of the item
	 * @param	$format (String) Available formats are: "UUU" (StringUtil.FORMAT_DAY_UUU, 'MON'),
	 * "k" (StringUtil.FORMAT_DAY_K, '월') and "ull" (StringUtil.FORMAT_DAY_ULL, 'Mon').
	 * @return
	 */
	public function getDayAt($idx:Number,$format:String):String {
		var kObj:Object = dateArr[$idx];
		return StringUtil.getFormattedDay(kObj.dayIdx, $format);
	}
	
	/**
	 * Returns the day of the month for the item in the specified index in number form.
	 * 
	 * @param	$idx (Number) The idex of the item
	 * @return (Number)
	 */
	public function getDateAt($idx:Number):Number {
		var kObj:Object = dateArr[$idx];
		return kObj.il;
	}
	
	
	private function getIsHorizontal():Boolean {
		return false;
	}
	
	private function rectifyColumnAndRowCount():Void {
		
			columnCount = 7;
			rowCount = 6;
		
	}
	
	private function rectifyPreviewCount():Void {
		
		previewCount = 0;		
			
	}
	
	
	public function getTotalCount():Number {
		return 37;
		
	}
}