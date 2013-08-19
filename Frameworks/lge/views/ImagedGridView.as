

import lge.apps.LGEvent;
import lge.utils.ArrayUtil;
import lge.utils.ClipUtil;
import lge.views.ImagedButton;
import lge.views.GridView;
import lge.views.View;
/**
 * Creates a grid view with the image or SWF file in
 * the item and provides the method and event to control it.
 * 
 * {@code
 * // Create a MovieClip to be used as the item's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
 * // Create a MovieClip to be used as the image and set the "Identifier" field to "lnk_icon" in the "Linkage Properties" window.
 * 
import lge.views.ImagedGridView;
import lge.views.View;
import lge.apps.LGEvent;

var lv:ImagedGridView = new ImagedGridView();
{
	lv.addEventReceiver(this);
	lv.x = 20;
	lv.y = 20;
	
	lv.imageWidth = 20;
	lv.imageHeight = 20;
	lv.imageX = 10;
	lv.imageY = 40;

	lv.itemBackground = "lnk_bg_btn";

	lv.labelArray = getLabelArray();

	lv.orientation = View.VERTICAL;
	lv.columnCount = 2;
	lv.rowCount = 5;
	lv.itemWidth = 130;
	lv.itemHeight = 100;

	lv.normalFontColor = 0x000000;
	lv.focusedFontColor = 0xFFFFFF;
	lv.selectedFontColor = 0xFFFFFF;
	lv.fontSize = 20;
	lv.imageArray = getImgArray();

	lv.draw(this);

	lv.takeFocus();
};

Key.addListener(this);
this.onKeyDown = function():Void  {
	var kCode:Number = Key.getCode();
	lv.doSomeWithKey(kCode);
};

function onEventReceived($evt:LGEvent) {
	trace($evt.id);
}

// An array of images for test
function getImgArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {		
		kLst.push("lnk_icon");
	}
	return kLst;
}
// An array of labels for test
function getLabelArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {
		kLst.push("label "+i);
	}
	kLst.push("Last");
	return kLst;
}
 * }
 */
class lge.views.ImagedGridView extends GridView {	
	
	public function dealloc():Void {
		deleteMoveQueEvtHolder();
		queueLst = null;
		imageArray = null;		
		super.dealloc();
	}	
	
	private function deleteMoveQueEvtHolder():Void {
		delete moveQueEvtHolder.onEnterFrame;
		moveQueEvtHolder.removeMovieClip();
		moveQueEvtHolder = null;
		moveQueueLst = null;
	}
	
	/** An array containing the identifier or external URL of the image
	 * @see lge.views.ImageView#image*/
	public var imageArray:Array;
	/** The X coordinate of the image 
	 * @see lge.views.View#x*/
	public var imageX:Number;
	/** The Y coordinate of the image
	 * @see lge.views.View#y*/
	public var imageY:Number;
	/** The width of the image 
	 * @see lge.views.View#width*/
	public var imageWidth:Number;
	/** The image'a height 
	 * @see lge.views.View#height*/
	public var imageHeight:Number;
	/** Whether to keep the aspect ratio of the image (default: false) 
	 * @see lge.views.ImageView#maintainAspectRatio*/
	public var imageMaintainAspectRatio:Boolean;		
	
	
	
	/**
	 * When you draw items, it decides whether to draw all at one or one-by-one.
	 */
	public var drawingOneByOne:Boolean = false;
	
	private var queueLst:Array;
	
	private var canDrawWhenOneByOne:Boolean;	
	
	private var moveQueueLst:Array;
	
	private var moveQueEvtHolder:MovieClip;
	
	
	private function createButton($idx:Number):ImagedButton {
		
		var kBtn:ImagedButton = new ImagedButton();
		
		populateButtonAttributes(kBtn, $idx);	
		
		return kBtn;
		
	}
	
	private function populateButtonAttributes($btn:ImagedButton, $idx:Number):Void {
		
		super.populateButtonAttributes($btn, $idx);
		
		$btn.image = imageArray[$idx];
		$btn.imageX = imageX;
		$btn.imageY = imageY;
		$btn.imageWidth = imageWidth;
		$btn.imageHeight = imageHeight;		
		$btn.imageMaintainAspectRatio = imageMaintainAspectRatio;		
	}
	
	
	private function initializeView():Void {
		
		if (drawingOneByOne) {			
			canDrawWhenOneByOne = true;
			queueLst = getQueueLst();	
			
			drawNextItem();
		}else {
			super.initializeView();
		}		
	}
	
	
	private function drawNextItem():Void {
		
		if (queueLst.length > 0 && canDrawWhenOneByOne) {
			
			var kIdx:Number = Number(queueLst.shift());
			
			if (getIsIndexValid(kIdx)) {
				
				canDrawWhenOneByOne = false;
				
				drawItem(kIdx);
				
			}			
			
		}
	}
	
	private function updateAfterScroll():Void {
		
		if (drawingOneByOne) {				
			queueLst = getQueueLst();	
			
			drawNextItem();
		}else {
			super.updateAfterScroll();
		}
		
	}
	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kName:String = $evt.data.getString("name");
		var kID:String = $evt.id;	
		
		if (drawingOneByOne) {						
			
			if (kID == LGEvent.LOAD_ERROR || kID == LGEvent.LOAD_SUCCEED) {
				//-- ImageView가 로드가 끝나면 evt.data에 ImageView가 실려오고, 이름은 "icon"이다.
				if (kName == "icon") {
					
					canDrawWhenOneByOne = true;
					
					drawNextItem();
					
				}else {
					
					super.onEventReceived($evt);	
					
				}
			}else if (kID == LGEvent.END_MOVE) {
				
				canDrawWhenOneByOne = true;
				
				onEndScroll();
				
			}else {
				super.onEventReceived($evt);	
			}
		}else {
			super.onEventReceived($evt);	
		}
			
			
	}
	
	
	
	
	
	
	
	
	private function insertItemAt($idx:Number, $label:String, $image:String):Void {
		ArrayUtil.insertItemAt(imageArray, $idx, $image);
		super.insertItemAt($idx, $label);
	}
	
	
	private function eradicateItemAt($idx:Number):Void {
		imageArray.splice($idx, 1);
		super.eradicateItemAt($idx);
	}
	
	private function changePosition($fromIdx:Number, $toIdx:Number):Void {
		ArrayUtil.changePosition(imageArray, $fromIdx, $toIdx);
		super.changePosition($fromIdx, $toIdx);
	}
	
	
	
	
	private function updatePositions($startIdx:Number):Void {
		if (!drawingOneByOne) {
			super.updatePositions($startIdx);
			return;
		}
		
		//-----------------------------------------
		var kLen:Number = getTotalCount();
		
		var kEnd:Number = getDrawableEndIndex($startIdx);	
		
		moveQueueLst = new Array();
		
		var kBtn:View;
		
		for (var i:Number = 0; i < kLen; i++) {
			if (i >= $startIdx && i <= kEnd) {
				kBtn = childViewLst[i];
				
				kBtn.index = i;
				
				if (kBtn == null) {
					
					drawItem(i);
					
				}else {
					moveQueueLst.push(kBtn);
					//kBtn.setPosition(getItemX(i), getItemY(i));
					
				}	
			}else {
				if (kBtn != null) {
					deleteChildViewAt(i);
				}
			}			
		}
		
		//-------------------------------------------
		
		var kThis:ImagedGridView = this;
		moveQueEvtHolder = ClipUtil.createEmptyHolder(clip, "moveQueEvtHolder");
		moveQueEvtHolder.onEnterFrame = function():Void {
			if (kThis.moveQueueLst.length > 0) {
				var kQueue:Object = kThis.moveQueueLst.shift();
				var kIdx:Number = kQueue.index;
				kQueue.setPosition(kThis.getItemX(kIdx), kThis.getItemY(kIdx));
			}else {
				kThis.deleteMoveQueEvtHolder();				
			}
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	private function getQueueLst():Array {		
		var kLst:Array = new Array();
		//--스크롤러에서 보여지는 범위는 scrollIdx ~(scrollIdx+getCountPerPage()-1)
		var kStart:Number = getDrawableStartIndex();	
		var kEnd:Number = getDrawableEndIndex(kStart);		
		
		var kLen:Number = getTotalCount();		
		for (var i:Number = 0; i < kLen; i++) {
			if (i >= kStart && i <= kEnd) {				
				if (childViewLst[i] == null) {
					kLst.push(i);
				}
			}else {
				deleteChildViewAt(i);
			}
		}	
		
		return kLst;		
	}	
	
	
}