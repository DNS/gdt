

import lge.utils.ArrayUtil;
import lge.views.Button;
import lge.views.View;
import lge.utils.ClipUtil;
import lge.utils.NumberUtil;
import lge.apps.LGEvent;
import lge.utils.DrawUtil;
import lge.utils.Mover;
import lge.utils.KeyCoder;
/**
 * Creates a list box and
 * and provides the method and event to control it.<br>
 * All items in the ListView class are the objects of the ButtonView class.
 * 
 * {@code
 * // Create a MovieClip to be used as the item's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
 * 
import lge.views.ListView;
import lge.views.View;
import lge.apps.LGEvent;
import lge.views.Button;
import lge.views.TextView;

var layout:View = new View();
layout.setPreBuiltContainer(this);

var listView:ListView = new ListView();
listView.addEventReceiver(this);
populateListView(listView);

function populateListView($listView:ListView):Void {

	$listView.x = 50;
	$listView.y = 150;
	$listView.itemBackground = "lnk_bg_btn";

	$listView.labelArray = getLabelArray();

	$listView.orientation = ListView.VERTICAL;
	$listView.rowCount = 4;	
}

layout.addChildView(listView);

listView.takeFocus();

Key.addListener(this);
this.onKeyDown = function():Void  {
	var kCode:Number = Key.getCode();
	listView.doSomeWithKey(kCode);
};

function onEventReceived($evt:LGEvent) {	
	trace($evt.id);
}

function getLabelArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {
		kLst.push("label "+i);
	}
	kLst.push("Last");
	return kLst;
}
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onFocusChanged
 * 	<li>LGEvent value: FOCUS_CHANGED</li>
 * 	<li>Event fired when the focus of the list view changes</li>
 * </ul>
 * <ul> onSelectListItem
 * 	<li>LGEvent value: SELECT_LIST_ITEM</li>
 * 	<li>Event triggered when an item in the list view is selected</li>
 * </ul>
 */
class lge.views.ListView extends View {
	
	public function dealloc():Void {		
		labelArray = null;		
		masker.removeMovieClip();
		masker = null;		
		pack.removeMovieClip();
		pack = null;
		
		super.dealloc();
	}	
	
	private var className:String = "ListView";
	
	
	/**
	 * An array containing the items' labels. It creates as many items as the length of the array.
	 */
	public var labelArray:Array;
	
	/** The identifier or external URL of the item's background 
	 * @see lge.views.ImageView#image*/
	public var itemBackground:String;
	/**
	 * The orientation of the list to be created (default: View.VERTICAL)
	 */
	public var orientation:String;
	/**
	 * The mumber of columns (default: 1)
	 */
	public var columnCount:Number = 1;
	/**
	 * The number of rows (default: 1)
	 */
	public var rowCount:Number = 1;
	/** The width of the background 
	 * @see lge.views.View#width*/
	public var itemWidth:Number;
	/** The height of the background 
	 * @see lge.views.View#height*/
	public var itemHeight:Number;
	/**
	 * The number of items to be created before scrolling (default: columnCount or rowCount, depending on the orientation)
	 */
	public var previewCount:Number;
	
	/** The color of the item label when the button is in normal status (default: 0x000000)
	 * @see lge.views.TextView#fontColor */
	public var normalFontColor:Number = 0x000000;
	/** The color of the item label when the button gains focus (default: 0xFFFFFF)*/
	public var focusedFontColor:Number = 0xFFFFFF;
	/** The color of the item label when the button is selected (default: 0xFFFFFF)*/
	public var selectedFontColor:Number = 0xFFFFFF;
	/** The font size of the item label (defailt: 20)
	 * @see lge.views.TextView#fontSize*/
	public var fontSize:Number = 20;
	/** The X coordinate of the item label (default: center of the button)
	 * @see lge.views.View#x*/
	public var labelX:Number;
	/** The Y coordinate of the item label (default: center of the button)
	 * @see lge.views.View#y*/
	public var labelY:Number;	
	/**
	 * The X distance between the items (default: 0)
	 */
	public var distanceX:Number = 0;
	/**
	 * The Y distance between the items (default: 0)
	 */
	public var distanceY:Number = 0;
	/**
	 * The scroll speed of the list. Closer to 1 is faster. Range: 0 - 1 (default: 0.6)
	 */
	public var scrollSpeed:Number = 0.6;
	/**
	 * The X-axis margin around the masker (default: 0)
	 */
	public var maskerMarginX:Number = 0;
	/**
	 * The Y-axis margin around the masker (default: 0)
	 */
	public var maskerMarginY:Number = 0;
	/**
	 * Whether to scroll by page (defaut: false)
	 */
	public var scrollByPage:Boolean = false;
	
	/**
	 * Whether to loop back to the first item (last to first) (defaut: false)
	 */
	public var backwardLoop:Boolean = false;
	/**
	 * Whether to loop back to the last item (first to last) (defaut: false)
	 */
	public var forwardLoop:Boolean =  false;	
	
	private var pack:MovieClip;
	private var scrollIdx:Number = 0;
	private var selectedIdx:Number;
	private var focusedIdx:Number;
	private var masker:MovieClip;
	private var permit:Number = 30;	
	private var lastFocusedIdx:Number;
	
	
	private function populateElements():Void {		
		
		rectifyColumnAndRowCount();
		
		rectifyPreviewCount();
		
		pack = ClipUtil.createEmptyHolder(clip, "pack");		
				
		initializeView();				
	}	
	
	private function initializeView():Void {
		var kLen:Number = getCountPerPage() + previewCount;		
		
		for (var i:Number = 0; i < kLen; i++) {
			
			drawItem(i);
		}
		
	}
	
	private function drawItem($idx:Number):Void {
		
		if (getIsIndexValid($idx)) {			
			
			var kBtn:Button = createButton($idx);	
			
			kBtn.addEventReceiver(this);
			
			addChildView(kBtn);		
			
			kBtn.setPosition(getItemX($idx), getItemY($idx));			
			
			if (masker == null) {
				createMasker();
			}			
		}
	}
	
	
	
	
	
	private function createButton($idx:Number):Button {
		var kBtn:Button = new Button();
		populateButtonAttributes(kBtn, $idx);		
		return kBtn;
	}
	
	private function populateButtonAttributes($btn:Button, $idx:Number):Void {		
		$btn.index = $idx;
		$btn.label = labelArray[$idx];
		
		$btn.background = itemBackground;
		$btn.backgroundWidth = itemWidth;
		$btn.backgroundHeight = itemHeight;
		$btn.labelX = labelX;
		$btn.labelY = labelY;
		$btn.normalFontColor = normalFontColor;
		$btn.selectedFontColor = selectedFontColor;
		$btn.focusedFontColor = focusedFontColor;	
		$btn.fontSize = fontSize;
	}
	
	
	private function createMasker():Void {		
		if (itemWidth != null && itemHeight != null) {
			
			masker = ClipUtil.createEmptyHolder(clip, "masker", -maskerMarginX, -maskerMarginY);
			
			var kWid:Number = calculateMaskerWidth() + (maskerMarginX * 2);
			
			var kHei:Number = calculateMaskerHeight() + (maskerMarginY * 2);			
			
			DrawUtil.drawRect(masker, kWid, kHei, 1, 0, 0);
			
			pack.setMask(masker);
			
		}
			
	}	
	
	
	private function updateAfterScroll():Void {
		
		//--스크롤러에서 보여지는 범위는 scrollIdx ~(scrollIdx+getCountPerPage()-1)
		var kStart:Number = getDrawableStartIndex();	
		var kEnd:Number = getDrawableEndIndex(kStart);		
		var kLen:Number = getTotalCount();		
		for (var i:Number = 0; i < kLen; i++) {
			if (i >= kStart && i <= kEnd) {				
				if (childViewLst[i] == null) {
					drawItem(i);
				}
			}else {
				deleteChildViewAt(i);
			}
		}		
	}
	
	/**
	 * After creating a list view, items can be added to labelArray.
	 * 
	 * @param	$array (Array)
	 */
	public function addLabelArray($array:Array):Void {
		if (labelArray == null) {
			labelArray = new Array();
		}
		labelArray = labelArray.concat($array);
		
		updateAfterScroll();
	}
	
	/**
	 * Scrolls the list box to the spedific index.
	 * (the scroll index is the index of the top or left item of the visible area)
	 * 
	 * @param	$scrollIdx (Number) The index of the item to scroll
	 */
	public function setScrollIndex($scrollIdx:Number):Void {
		if ($scrollIdx >= 0 && $scrollIdx <= getLastScrollIndex()) {
			doScroll($scrollIdx);
		}
	}
	
	
	/**
	 * Prepares to take the focus.
	 */
	public function takeFocus():Void {
		if (getIsIndexValid(focusedIdx)) {
			moveFocusAt(focusedIdx);
		} else {
			moveFocusAt(0);
		}
	}
	/**
	 * Gives up the focus. If an item is focused, it returns to the normal state.
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
		
		if (!isNaN($idx)) {
			$idx = getValidIndex($idx);
			
			lastFocusedIdx = focusedIdx;
		
			normalAt(focusedIdx);
			
			focusedIdx = $idx;		
			//--- focusAt()은 스크롤을 마친 이후에 호출
			var kScrollIdx:Number = getScrollIdxWithItemIdx(focusedIdx, scrollIdx);
			
			var kCanScroll:Boolean = getCanScroll(kScrollIdx);
			
			if (kCanScroll) {
				
				doScroll(kScrollIdx);
				
			}else {		
				
				onEndScroll();
				
			}
		}			
	}
	
	
	
	private function doScroll($scrollIdx:Number):Void {			
		scrollIdx = $scrollIdx;		
		var kMover:Mover = new Mover();
		kMover.addEventReceiver(this);
		if (getIsHorizontal()) {
			var kTargetX:Number = getTargetX(scrollIdx);
			kMover.move(pack, kTargetX, null, scrollSpeed, permit);
		}else {
			var kTargetY:Number = getTargetY(scrollIdx);
			kMover.move(pack, null, kTargetY, scrollSpeed, permit);
		}
	}
	
	private function onEndScroll():Void {	
		
		updateAfterScroll();
		
		focusAt(focusedIdx);	
		
	}
	
	private function focusAt($idx:Number):Void {
		
		var kBtn:Button = Button(getChildViewAt($idx));
		
		kBtn.focus();
		
		var kClip:MovieClip = kBtn.getClip();
		kClip.swapDepths(kClip._parent.getNextHighestDepth());	
		
		triggerEvent(LGEvent.FOCUS_CHANGED, this);		
	}
	
	private function normalAt($idx:Number):Void {
		var kBtn:Button = Button(getChildViewAt($idx));
		kBtn.normal();
	}
	
	private function selectAt($idx:Number):Void {
		selectedIdx = $idx;
		var kBtn:Button = Button(getChildViewAt($idx));
		kBtn.select();
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
	/**
	 * Moves the focus to the previous page.
	 */
	public function moveFocusPrevPage():Void {
		var kIdx:Number = focusedIdx - getCountPerPage();
		moveFocusAt(kIdx);
	}
	/**
	 * Moves the focus to the next page.
	 */
	public function moveFocusNextPage():Void {
		var kIdx:Number = focusedIdx + getCountPerPage();
		moveFocusAt(kIdx);
	}
	
	
	private function rectifyColumnAndRowCount():Void {
		if (getIsHorizontal()) {
			rowCount = 1;
			columnCount = NumberUtil.getNumber(columnCount, 3);
		}else {
			columnCount = 1;
			rowCount = NumberUtil.getNumber(rowCount, 3);
		}
	}
	
	private function rectifyPreviewCount():Void {
		if (previewCount == null) {
			if (getIsHorizontal()) {
				previewCount = columnCount;				
			}else {
				previewCount = rowCount;		
			}
		}
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		
		var kID:String = $evt.id;	
		
		if (kID == LGEvent.END_MOVE) {
			
			//--mover에서 pack의 이동을 끝낸 후 호출 			
			onEndScroll();
			
		}else {
			
			var kBtn:Button = Button($evt.data);
			
			if (kBtn.getClip()._parent == pack) {//버튼안에 버튼이 들어갈 수 있기에, 버튼의 상위 클립이 pack인지 검사
			
				var kIdx:Number = kBtn.getIndex();
				
				if (kID == LGEvent.ROLL_OVER) {	
					
					moveFocusAt(kIdx);	
					super.onEventReceived($evt);
					
				}else if (kID == LGEvent.PRESS) {
					
					selectAt(kIdx);
					triggerEvent(LGEvent.SELECT_LIST_ITEM, this);
					
				}else {
					
					super.onEventReceived($evt);
					
				}
			}
			
		}	
		
	}
	/**
	 * This method is provided for developers convenience.<br>
	 * When a key event occurs, passing the key's code value  
	 * allows the list box to perform its basic functions.<br>
	 * For example, for the list box scrolling up and down, the up/down key moves the focus up or down.
	 * 
	 * @param	$code (Number) The code value of the pressed key
	 */
	public function doSomeWithKey($code:Number):Void {
		if ($code == KeyCoder.ENTER) {
			
			selectAt(focusedIdx);
			triggerEvent(LGEvent.SELECT_LIST_ITEM, this);
			
		}else if (getIsHorizontal()) {
			
			if ($code == KeyCoder.RIGHT) {
				moveFocusNext();
			} else if ($code == KeyCoder.LEFT) {
				moveFocusPrev();
			}
		}else {
			if ($code == KeyCoder.DOWN) {			
				moveFocusNext();
			} else if ($code == KeyCoder.UP) {
				moveFocusPrev();
			}	
		}		
	}	
	
	// 지정한 아이템 하나를 삭제한다.
	private function eradicateItemAt($idx:Number):Void {
		if ($idx < 0 || $idx >= getTotalCount()) return;
		
		normalAt(focusedIdx);
		// 포커스보다 이전 아이템이 지워지면 이를 반영
		var kFIdx:Number = focusedIdx;
		if (kFIdx > $idx) {
			kFIdx = kFIdx - 1;
		}
		if (lastFocusedIdx > $idx) {
			lastFocusedIdx = lastFocusedIdx - 1;
		}
		// moveFocusAt()에서 이를 갱신하므로...
		focusedIdx = lastFocusedIdx;		
		
		//--데이타 배열을 다시 설정한다.
		labelArray.splice($idx, 1);			
		//--view를 없앤다.
		deleteChildViewAt($idx);		
		childViewLst.splice($idx, 1);
		
		//-- 포지션을 업데이트한다.
		updatePositions($idx);
		
		moveFocusAt(kFIdx);
	}
	
	// 아이템을 지정 위치에 추가한다.
	private function insertItemAt($idx:Number, $label:String):Void {
		if ($idx < 0 || $idx >= getTotalCount()) return;
		
		normalAt(focusedIdx);
		// 포커스보다 이전 아이템이 추가되면 이를 반영
		var kFIdx:Number = focusedIdx;
		if (kFIdx > $idx) 	kFIdx = kFIdx + 1;
		
		if (lastFocusedIdx > $idx) 	lastFocusedIdx = lastFocusedIdx + 1;
		
		// moveFocusAt()에서 이를 갱신하므로...
		focusedIdx = lastFocusedIdx;
		
		ArrayUtil.insertItemAt(labelArray, $idx, $label);
		ArrayUtil.insertItemAt(childViewLst, $idx, null);
		
		updatePositions($idx);
		
		moveFocusAt(kFIdx);
	}
	// 아이템의 위치를 변경한다.
	private function changePosition($fromIdx:Number, $toIdx:Number):Void {
		
		if ($fromIdx < 0 || $fromIdx >= getTotalCount()) return;
		
		if ($toIdx < 0 || $toIdx >= getTotalCount()) return;
		
		normalAt(focusedIdx);
		
		ArrayUtil.changePosition(labelArray, $fromIdx, $toIdx);
		ArrayUtil.changePosition(childViewLst, $fromIdx, $toIdx);
		
		var kStartIdx:Number = Math.min($fromIdx, $toIdx);
		
		updatePositions(kStartIdx);
		
		moveFocusAt(focusedIdx);
	}
	
	
	private function updatePositions($startIdx:Number):Void {
		var kLen:Number = getTotalCount();
		
		var kEnd:Number = getDrawableEndIndex($startIdx);			
		
		var kBtn:View;
		
		for (var i:Number = 0; i < kLen; i++) {
			if (i >= $startIdx && i <= kEnd) {
				kBtn = childViewLst[i];
				
				kBtn.index = i;
				
				if (kBtn == null) {
					
					drawItem(i);
					
				}else {
					
					kBtn.setPosition(getItemX(i), getItemY(i));
					
				}	
			}else {
				if (kBtn != null) {
					deleteChildViewAt(i);
				}
			}			
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * Returns the maximum scroll index.
	 * @return (Number)
	 */	 
	public function getLastScrollIndex():Number {
		return getTotalCount() - getCountPerPage(); 
	}
	 
	/**
	 * Returns the current scroll index.
	 * @return (Number)
	 */
	public function getScrollIndex():Number {
		return scrollIdx;
	}
	
	private function getCountPerPage():Number {	
		if (getIsHorizontal()) {
			return columnCount;
		}
		return rowCount;		
	}
	
	private function getIsHorizontal():Boolean {
		return (orientation == HORIZONTAL);
	}
	
	private function getIsIndexValid($idx:Number):Boolean {
		return ($idx>=0 && $idx<getTotalCount());
	}
	
	/**
	 * Returns the scroll index required to display the specified item from the current scroll position.
	 * 
	 * @param	$idx (Number) The index of the item
	 * @return (Number)
	 */
	public function getScrollIndexWithItemIndex($idx:Number):Number {
		return getScrollIdxWithItemIdx($idx, scrollIdx);
	}
	
	private function getScrollIdxWithItemIdx($idx:Number, $scrollIdx:Number):Number {
		
		
		//--스크롤러에서 보여지는 범위는 scrollIdx ~(scrollIdx+getCountPerPage()-1)
		
		var kCntPerPage:Number = getCountPerPage();
		
		if ($idx >= $scrollIdx && $idx < ($scrollIdx + getCountPerPage())) {	
			//--현재 범위내에서 보여지는 경우 현재의 scrollIdx
			return $scrollIdx;
			
		} else if ($idx < $scrollIdx) {
			
			if (scrollByPage) {				
				return Math.floor($idx / kCntPerPage)*kCntPerPage;				
			}else {
				return $idx;
			}	
			
		} else {
			
			if (scrollByPage) {				
				return Math.floor($idx / kCntPerPage)*kCntPerPage;				
			}else {
				return $idx-(getCountPerPage()-1);
			}
			
		}
	}
	
	
	
	private function getItemX($idx:Number):Number {
		//--만약 width, height가 null이라면 원래 크기를 사용하기 위해
		if (itemWidth == null) {
			var kBtn:Button = Button(getChildViewAt($idx));
			//itemWidth = Math.round(kBtn.getClip()._width);
			itemWidth = kBtn.getChildViewAt(Button.BG_INDEX).width;
		}		
				
		if (getIsHorizontal()) {
			return (itemWidth + distanceX) * $idx;			
		}
		return 0;
	}
	
	private function getItemY($idx:Number):Number {
		if (itemHeight == null) {
			var kBtn:Button = Button(getChildViewAt($idx));
			//itemHeight = Math.round(kBtn.getClip()._height);
			itemHeight = kBtn.getChildViewAt(Button.BG_INDEX).height;
		}
		
		if (getIsHorizontal()) {
			return 0;			
		}
		return (itemHeight+distanceY)*$idx;
	}
	
	private function getTargetX($scrollIdx:Number):Number {		
		if (getIsHorizontal()) {
			return -$scrollIdx * (itemWidth + distanceX);			
		}
		return 0;
	}	
	
	private function getTargetY($scrollIdx:Number):Number {		
		if (getIsHorizontal()) {
			return 0;
		}
		return -$scrollIdx * (itemHeight + distanceY);		
	}
	/**
	 * Returns the index of the focused item.
	 * 
	 * @return (Number)
	 */
	public function getFocusedIndex():Number {
		return focusedIdx;
	}
	/**
	 * Returns the index of the selected item.
	 * 
	 * @return (Number)
	 */
	public function getSelectedIndex():Number {
		return selectedIdx;
	}
	/**
	 * Returns the item of the previously selected item.
	 * 
	 * @return (Number)
	 */
	public function getLastFocusedIndex():Number {
		return lastFocusedIdx;
	}
	/**
	 * Returns the number of items in the list view.
	 * 
	 * @return (Number)
	 */
	public function getTotalCount():Number {
		return labelArray.length;
		
	}	
	
	private function getCanScroll($scrollIdx:Number):Boolean {		
		if ($scrollIdx == scrollIdx) {
			return false;
		} 
		return true;
	}
	
	private function calculateMaskerWidth():Number {
		if (getIsHorizontal()) {
			return ((itemWidth + distanceX) * getCountPerPage());					
				
		}
		return itemWidth;			
	}
	
	private function calculateMaskerHeight():Number {
		if (getIsHorizontal()) {
			return itemHeight;					
				
		}
		return ((itemHeight + distanceY) * getCountPerPage());			
	}
	
	private function getDrawableStartIndex():Number {
		if (isNaN(scrollIdx) || isNaN(previewCount)) {
			return 0;
		}
		return scrollIdx - previewCount;		
	}
	
	private function getDrawableEndIndex($startIdx:Number):Number {	
		
		return $startIdx + getCountPerPage() + previewCount*2-1;
	}
	
	private function getContainterClip():MovieClip {			
		return pack;		
	}
	
	private function getDrawnWidth():Number {
		return masker._width;
	}
	
	private function getDrawnHeight():Number {
		return masker._height;
	}
	
	private function getValidIndex($idx:Number):Number {
		var kLastIdx:Number = getTotalCount() - 1;		
		var kCurPageIdx:Number = getPageIndexWithItemIndex(focusedIdx);
		
		if ($idx < 0) {
			if (forwardLoop && kCurPageIdx == 0) {				
				return kLastIdx;
			}
			return 0
		}else if ($idx > kLastIdx) {
			var kLastPageIdx:Number = getPageIndexWithItemIndex(kLastIdx);
			if (backwardLoop && kCurPageIdx == kLastPageIdx) {				
				return 0;
			}
			return kLastIdx;
		}
		return $idx;
	}
	
	private function getPageIndexWithItemIndex($itemIdx:Number):Number {
		var kCntPerPage:Number = getCountPerPage();
		
		if (kCntPerPage == 0) return 0;
		
		return Math.floor($itemIdx / kCntPerPage);
	}
	
	
}