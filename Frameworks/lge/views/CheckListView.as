
import lge.apps.LGEvent;
import lge.views.CheckButton;
import lge.views.ListView;
import lge.utils.KeyCoder;

/**
 * Creates a list view with the checker.
 * 
 * {@code
 * // Create a MovieClip to be used as the item's background and set the "Identifier" field to "lnk_bg" in the "Linkage Properties" window.
 *  // Create a MovieClip to be used as the checker's background and set the "Identifier" field to "lnk_box" in the "Linkage Properties" window.
 *  // Create a MovieClip to be used as the checker's marker and set the "Identifier" field to "lnk_marker" in the "Linkage Properties" window.
 
import lge.views.CheckListView;
import lge.apps.LGEvent;
import lge.views.View;

var layout:View = new View();
layout.setPreBuiltContainer(this);
layout.addEventReceiver(this);

var listView:CheckListView = new CheckListView();
{
	listView.addEventReceiver(this);
	listView.x = 150;
	listView.y = 150;

	populateAttributesForListView(listView);
	populateAttributesForCheckListView(listView);

};

layout.addChildView(listView);
listView.takeFocus();

// The default setting of the ListView
function populateAttributesForListView($view:Object):Void {

	$view.labelArray = getLabelArray();
	$view.itemBackground = "lnk_bg_btn";
	$view.orientation = View.VERTICAL;
	$view.columnCount = 4;
	$view.rowCount = 4;
	$view.itemWidth = 150;
	$view.itemHeight = 40;

	$view.normalFontColor = 0xff00ff;
	$view.focusedFontColor = 0xFFFFFF;
	$view.selectedFontColor = 0xFFFFFF;
	$view.fontSize = 20;
	$view.labelX = 54;
	$view.labelY = 4;
	$view.distanceX = 0;
	$view.distanceY = 0;
	$view.scrollSpeed = 0.6;	// 0 ~ 1
}
// The setting for the checker
function populateAttributesForCheckListView($view:Object):Void {
	$view.checkedArray = getCheckedArray();
	//$view.checkerWidth = 30;
	$view.checkerX = 10;
	$view.checkerY = 2;
	$view.checkerBackground = "lnk_box";
	$view.checkerMarker = "lnk_marker";
}
// An array of the checkers for testing 
function getCheckedArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {
		kLst.push(random(2) == 0);
	}
	return kLst;
}
// An array of the labels
function getLabelArray():Array {
	var kLst:Array = new Array();
	for (var i:Number = 0; i<40; i++) {
		kLst.push("label "+i);
	}
	return kLst;
}

Key.addListener(this);
function onKeyDown() {
	listView.doSomeWithKey(Key.getCode());
}
 * }
 */
class lge.views.CheckListView extends ListView {
	
	public function dealloc():Void {
		checkedArray = null;
		super.dealloc();
	}
	/**
	 * An array to specify the checker's initial status 
	 * @see lge.views.Checker#checked 
	 */
	public var checkedArray:Array;
	
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
	
	private function createButton($idx:Number):CheckButton {
		var kBtn:CheckButton = new CheckButton();
		populateButtonAttributes(kBtn, $idx);		
		return kBtn;
	}
	
	private function populateButtonAttributes($btn:CheckButton, $idx:Number):Void {		
		super.populateButtonAttributes($btn, $idx);
		$btn.checkerBackground = checkerBackground;
		$btn.checkerMarker = checkerMarker;
		$btn.checkerX = checkerX;
		$btn.checkerY = checkerY;
		$btn.checkerWidth = checkerWidth;
		$btn.checkerHeight = checkerHeight;	
		$btn.checked = checkedArray[$idx];		
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
			var kBtn:CheckButton = CheckButton(getChildViewAt(focusedIdx));
			kBtn.toggle();
		}
		super.doSomeWithKey($code);
		
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;	
		if (kID == LGEvent.CHECK_STATE_CHANGED) {
			var kBtn:CheckButton = CheckButton($evt.data);
			var kIdx:Number = kBtn.getIndex();
			checkedArray[kIdx] = kBtn.getChecked();
		}else {
			super.onEventReceived($evt);	
		}		
	}
	/**
	 * Returns an array of the checker's statuses in the list.
	 * @return (Array) True when checked; otherwise false
	 */
	public function getCheckedArray():Array {
		return checkedArray;
	}
	
}