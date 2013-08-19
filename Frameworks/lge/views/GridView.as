

import lge.views.Button;
import lge.views.ListView;
import lge.utils.NumberUtil;
import lge.apps.LGEvent;
import lge.utils.KeyCoder;

/**
 * Creates a grid view and provides the method and event to control it.
 * 
 * {@code
 * 
// Create a MovieClip to be used as the item's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.

import lge.views.GridView;

var lv:GridView = new GridView();
lv.addEventReceiver(this);
lv.x = 20;
lv.y = 20;

lv.itemBackground = "lnk_bg_btn";

lv.labelArray = getLabelArray();
lv.columnCount = 4;
lv.rowCount = 4;

lv.labelX = 10;
lv.labelY = 10;	
lv.distanceX = 2;
lv.distanceY = 2;

lv.scrollByPage = true;

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

function getLabelArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {
		kLst.push("label "+i);
	}
	kLst.push("Last");
	return kLst;
}
 * 
 * }
 */
class lge.views.GridView extends ListView {
	
	
	//--처음 한번만 호출 된다.-----
	private function initializeView():Void {
		var kIdx:Number;
		var kTotal:Number = getTotalCount();
		
		if (getIsHorizontal()) {			
			var kEndCol:Number = Math.floor(kTotal / rowCount);
			var kCol:Number;		
			
			//-- col loop
			for (var i:Number = 0; i < columnCount + previewCount; i++) {
				
				kCol = scrollIdx + i;
				if (kCol >= 0 && kCol <= kEndCol) {
					
					//-- row loop
					for (var j:Number = 0; j < rowCount; j++) {
						
						kIdx = getIdxWithColAndRow(kCol, j);
						if (kIdx < kTotal) {
							if (childViewLst[kIdx] == null) {
								drawItem(kIdx);								
							}					
						}else {
							return;
						}
					}
				}			
			}	
		}else {
			var kEndRow:Number = Math.floor(kTotal / columnCount);
			var kRow:Number;				
			//-- row loop
			for (var i:Number = 0; i < rowCount + previewCount; i++) {				
				kRow = scrollIdx + i;
				if (kRow >= 0 && kRow <= kEndRow) {
					//-- col loop
					for (var j:Number = 0; j < columnCount; j++) {
						kIdx = getIdxWithColAndRow(j,kRow);
						if (kIdx < kTotal) {
							if (childViewLst[kIdx] == null) {
								drawItem(kIdx);
							}					
						}else {
							return;
						}
					}
				}			
			}
		}
		
	}
	
	/**
	 * This method is provided for developers convenience.<br>
	 * When a key event occurs, passing the key's code value  
	 * allows the list box to perform its basic functions.<br>
	 * For example, for the grid view scrolling up and down, the up/down key moves the focus to the previous or next line
	 * and the left/right key moves the focus to the previous or next item.
	 * 
	 * @param	$code (Number) The code value of the pressed key
	 */
	public function doSomeWithKey($code:Number):Void {
		if ($code == KeyCoder.ENTER) {
			triggerEvent(LGEvent.SELECT_LIST_ITEM, this);
		}else if ($code == KeyCoder.RIGHT) {
			moveFocusRight();
		} else if ($code == KeyCoder.LEFT) {
			moveFocusLeft();
		}else if ($code == KeyCoder.DOWN) {			
			moveFocusDown();
		} else if ($code == KeyCoder.UP) {
			moveFocusUp();
		}		
	}
	
	/**
	 * Moves the focus to the left.
	 * <br> For the grid view scrolling up and down, the previous item
	 * <br> For the grid view scrolling left and right, the previous line 
	 */
	public function moveFocusLeft():Void {
		if (getIsHorizontal()) {
			moveFocusAt(focusedIdx - rowCount);			
		}else {
			moveFocusAt(focusedIdx - 1);			
		}		
	}
	/**
	 * Moves the focus to the right.
	 * <br> For the grid view scrolling up and down, the next item
	 * <br> For the grid view scrolling left and right, the next line 
	 */
	public function moveFocusRight():Void {
		if (getIsHorizontal()) {
			moveFocusAt(focusedIdx + rowCount);			
		}else {
			moveFocusAt(focusedIdx + 1);			
		}		
	}
	/**
	 * Moves the focus up.
	 * <br> For the grid view scrolling up and down, the previous line 
	 * <br> For the grid view scrolling left and right, the previous item  
	 */
	public function moveFocusUp():Void {
		if (getIsHorizontal()) {
			moveFocusAt(focusedIdx - 1);			
		}else {
			moveFocusAt(focusedIdx - columnCount);			
		}		
	}
	/**
	 * Moves the focus down.
	 * <br> For the grid view scrolling up and down, the next line 
	 * <br> For the grid view scrolling left and right, the next item 
	 */
	public function moveFocusDown():Void {
		if (getIsHorizontal()) {
			moveFocusAt(focusedIdx + 1);			
		}else {
			moveFocusAt(focusedIdx + columnCount);			
		}		
	}
		
	/**
	 * Returns the maximum scroll index.
	 * @return (Number)
	 */	 
	public function getLastScrollIndex():Number {
		if (getIsHorizontal()) {
			return Math.ceil((getTotalCount() - getCountPerPage()) / rowCount); 
		}else {
			return Math.ceil((getTotalCount() - getCountPerPage()) / columnCount); 
		}
	}
	
	private function rectifyColumnAndRowCount():Void {		
		columnCount = NumberUtil.getNumber(columnCount, 2);	
		rowCount = NumberUtil.getNumber(rowCount, 2);		
	}
	
			
	private function getScrollIdxWithItemIdx($itemIdx:Number, $scrollIdx:Number):Number {
		
		var kTargetScroll:Number;
		//---item idx가 위치하는 scorll(col)의 값--
		var kItemScroll:Number;
		
		if (getIsHorizontal()) {				
			
			if (scrollByPage) {	
				var kCol:Number = getColIdxWithItemIdx($itemIdx);				
				kTargetScroll = Math.floor(kCol / columnCount) * columnCount;							
			}else {
				kItemScroll = Math.floor($itemIdx / rowCount);	
			
				if (kItemScroll >= $scrollIdx && kItemScroll < ($scrollIdx + columnCount)) {				
					kTargetScroll =  $scrollIdx;					
				}else {		
					if (kItemScroll > $scrollIdx) {
						kTargetScroll =  kItemScroll-(columnCount-1);
					}else {
						kTargetScroll = kItemScroll;
					}				
				}	
			}
		}else {				
			var kRow:Number = getRowIdxWithItemIdx($itemIdx);	
			
			if (scrollByPage) {							
				kTargetScroll = Math.floor(kRow / rowCount) * rowCount;				
			}else {
				kItemScroll = Math.floor($itemIdx / columnCount);			
				if (kItemScroll >= $scrollIdx && kItemScroll < ($scrollIdx + rowCount)) {			
					kTargetScroll =  $scrollIdx;
				}else {				
					if (kItemScroll > $scrollIdx) {
						kTargetScroll =  kItemScroll-(rowCount-1);
					}else {
						kTargetScroll = kItemScroll;
					}
				}
			}
		}
		
		return kTargetScroll;				
	}
	
	
	private function getItemX($idx:Number):Number {
		var kCol:Number = getColIdxWithItemIdx($idx);
		return getItemXWithCol(kCol);
				
	}
	
	private function getItemY($idx:Number):Number {
		var kRow:Number = getRowIdxWithItemIdx($idx);
		return getItemYWithRow(kRow);
	}
	
	
	private function getItemXWithCol($col:Number):Number {	
		//--만약 width, height가 null이라면 원래 크기를 사용하기 위해
		if (itemWidth == null) {
			var kBtn:Button = Button(getLastChildView());
			//itemWidth = Math.round(kBtn.getClip()._width);		// tv에서 pc와 다른 값이 나타나서 교체
			itemWidth = kBtn.getChildViewAt(Button.BG_INDEX).width;
		}
		
		return (itemWidth + distanceX) * $col;		
	}
	
	private function getItemYWithRow($row:Number):Number {
		if (itemHeight == null) {
			var kBtn:Button = Button(getLastChildView());
			//itemHeight = Math.round(kBtn.getClip()._height);		// tv에서 pc와 다른 값이 나타나서 교체
			itemHeight = kBtn.getChildViewAt(Button.BG_INDEX).height;
		}
		
		return (itemHeight + distanceY) * $row;
	}
	
	
	
	private function getIdxWithColAndRow($col:Number, $row:Number):Number {
		if (getIsHorizontal()) {
			return $col * rowCount + $row;
		}else {
			return $row * columnCount + $col;
		}
		
	}
	
	private  function getRowIdxWithItemIdx($idx:Number):Number {		
		if (getIsHorizontal()) {
			return $idx % rowCount;			
		}else {
			return Math.floor($idx/columnCount);
		}		
	}
	
	private  function getColIdxWithItemIdx($idx:Number):Number {
		if (getIsHorizontal()) {
			return Math.floor($idx/rowCount);		
		}else {
			return $idx % columnCount;			
		}		
	}
	
	private function calculateMaskerWidth():Number {		
		return ((itemWidth + distanceX) * columnCount)-distanceX;				
	}
	
	private function calculateMaskerHeight():Number {		
		return ((itemHeight + distanceY) * rowCount)-distanceY;		
	}
	
	private function getDrawableStartIndex():Number {
		if (isNaN(scrollIdx) || isNaN(rowCount) || isNaN(previewCount)) return 0;
		
		if (getIsHorizontal()) {
			return  ((scrollIdx * rowCount) - (previewCount * rowCount));				
		}
		return  ((scrollIdx * columnCount) - (previewCount * columnCount));	
		
	}
	
	private function getDrawableEndIndex($startIdx:Number):Number {
		
		if (getIsHorizontal()) {				
			return ($startIdx + ((columnCount + previewCount*2) * rowCount))-1;			
		}			
		return ($startIdx + ((rowCount + previewCount*2) * columnCount))-1;					
		
	}
	
	private function getCountPerPage():Number {			
		return rowCount * columnCount;		
	}
	
}