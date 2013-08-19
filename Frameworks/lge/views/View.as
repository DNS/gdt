
import lge.apps.LGCustomEventManager;
import lge.apps.LGObject;
import lge.utils.ArrayUtil;
import lge.utils.ClipUtil;
import lge.utils.NumberUtil;
import lge.apps.LGEvent;

/**
 * The top class of the FFC2.0 view object. 
 * It creates a View object, adds a child view, and handles events using the composite object, LGCustomEventManager.
 * 
 * {@code
 * // Creates a new View object and specifies the MovieClip to be used as a container.
 * // A hierarchy can be built by creating and adding child view objects.
 * 
 * import lge.views.View;
 * 
 * var container:View = new View();
 * View.setPreBuiltContainer(this);
 * 
 * }
 * <br><br>
 * 
 *  Events fired:
 * <ul> onChildViewAdded
 * 	<li>LGEvent value: CHILD_VIEW_ADDED</li>
 * 	<li>Event fired when a child view is added to the View object</li>
 * </ul>
 * <ul> onDrawCompleted
 * 	<li>LGEvent value: DRAW_COMPLETED</li>
 * 	<li>Event fired when creating a view object succeeds. Note that this event does not check whether an external file is loaded.</li>
 * </ul>
 */
class lge.views.View extends LGObject {
	
	public function dealloc():Void {	
		_global.ExtendedEvents.LGAPPEvent.removeListener(this);
		
		eventer.dealloc();
		eventer = null;
		
		deleteAllChildView();				
		clip.removeMovieClip();
		clip = null;
		
		parentView = null;
		
		super.dealloc();
	}
	
	
	private var clip:MovieClip;		
	private var childViewLst:Array;	
	private static var VIEW_COUNT:Number = 0;
	
	/**
	 * A constant for the horizontal direction of the view
	 */
	public static var HORIZONTAL:String = "horizontal";
	/**
	 * A constant for the vertical direction of the view
	 */
	public static var VERTICAL:String = "vertical";
	
	/**
	 * The unique index of the view. Sibling views of the same parent view have their own unique index. <br>
	 * If a duplicate index value is set, the old view object with the duplicate index is removed.
	 */
	public var index:Number;	
	/**
	 * The width of the view. The value is saved once the property is set, but it is reflected to the graph after performing {@link #draw()} {@link #addChildView()} or when the loading is completed (if loading an external file).
	 */
	public var width:Number;
	/**
	 * The height of the view. The value is saved once the property is set, but it is reflected to the graph after performing {@link #draw()} {@link #addChildView()} or when the loading is completed (if loading an external file).
	 */
	public var height:Number;
	/**
	 * The X coordinate of the view. The value is saved once the property is set, but it is reflected to the graph after performing {@link #draw()} {@link #addChildView()} or when the loading is completed (if loading an external file).
	 */
	public var x:Number = 0;
	/**
	 * The Y coordinate of the view. The value is saved once the property is set, but it is reflected to the graph after performing {@link #draw()} {@link #addChildView()} or when the loading is completed (if loading an external file).
	 */
	public var y:Number = 0;
	
	private var parentView:View;	
	private static var VIEWCNT:Number = 0;	
	private var eventer:LGCustomEventManager;
	//-- 로드되는 view(ImageView중에서)의 로드 완료 여부 
	private var loadingDone:Boolean = true;
	
	function  View() {
		eventer = new LGCustomEventManager();
		_global.ExtendedEvents.LGAPPEvent.addListener(this);
	}
	
	private function onEvent($cmd:String, $data:String):Void {	
		
	}
	
	/**
	 * Sets an existing MovieClip as the container for the View object.
	 * 
	 * @param	$container (MovieClip) An existing MovieClip
	 */
	public function setPreBuiltContainer($container:MovieClip):Void {
		clip = $container;	
	}
	
	/**
	 * Adds a child view object. If a duplicate index value is set, the old object with the duplicate index is removed.
	 * 
	 * @param	$view (View) A child view to be added to the current View object
	 */
	public function addChildView($childView:View):Void {
		
		if ($childView != null) {
			
			if (childViewLst == null) {
				childViewLst = new Array();
			}
			
			var kIdx:Number = NumberUtil.getNumber($childView.getIndex(), getNextHighestChildIndex());		
			
			deleteChildViewAt(kIdx);
			
			$childView.index = kIdx;
			
			$childView.parentView = this;
			
			childViewLst[kIdx] = $childView;			
			
			$childView.draw(getContainterClip());
			
			onChildViewAdded(kIdx);
		}		
	}
	
	
	
	private function onChildViewAdded($idx:Number):Void {
		
		triggerEvent(LGEvent.CHILD_VIEW_ADDED, getChildViewAt($idx));
		
	}	
	
	
	/**
	 * Draws itself (view) into the container MovieClip.
	 * 
	 * @param	$parent (MovieClip) The container MovieClip to contain the View object 
	 * (Each View object has a MovieClip containing its view. This MovieClip is drawn into the parent view's MovieClip.
	 * Therefore, to create a container MovieClip, the View object must know its parent MovieClip.)
	 */
	public function draw($parent:MovieClip):Void {
		
		if (clip == null) {	
			
			clip =  ClipUtil.createEmptyHolder($parent, getClipName());
			
		}
		
		createView();			
	}
	
	
	private function createView():Void {
		
		populateElements();
		
		onDrawCompleted();	
		
	}
	
	private function populateElements():Void {		
	}
	
	
	private function onDrawCompleted():Void {			
		
		setPosition(x, y);			
		
		refreshSize();
		
		triggerEvent(LGEvent.DRAW_COMPLETED, this);
	}
	
	private function triggerEvent($id:String, $data:Object):Void {
		eventer.triggerEvent($id, $data);
	}
	/**
	 * Adds the object received as a parameter as an event listener.
	 * 
	 * @param	$receiver (Object) The object to be added as an event listener. The onEventReceived() method must be implemented.
	 */
	public function addEventReceiver($receiver:Object):Void {
		eventer.addEventReceiver($receiver);
	}
	/**
	 * Removes the added event listener.
	 * 
	 * @param	$receiver (Object) The added event listener
	 */
	public function removeEventReceiver($receiver:Object):Void {
		eventer.removeEventReceiver($receiver);			
	}
	/**
	 * Deletes the child view with the index received as a parameter.
	 * 
	 * @param	$idx (Number) The index of the child view to be deleted
	 */
	public function deleteChildViewAt($idx:Number):Void {
		var kView:View = childViewLst[$idx];
		if (kView != null) {
			kView.dealloc();
			childViewLst[$idx] = null;			
		}		
	}
	/**
	 * Among the added child views, if there is a View object identical to the View received as a parameter, 
	 * the corresponding View is deleted.
	 * 
	 * @param	$view (View) The View object to be deleted 
	 */
	public function deleteChildView($view:View):Void {
		var kAt:Number = ArrayUtil.getAt(childViewLst, $view);
		deleteChildViewAt(kAt);
	}
	
	private function deleteAllChildView():Void {		
		var kLen:Number = childViewLst.length;
		for (var i:Number = 0; i < kLen; i++) {
			deleteChildViewAt(i);
		}
		childViewLst = null;
	}
	
	
	private function onEventReceived($evt:LGEvent):Void {	
		
		triggerEvent($evt.id, $evt.data);
		
	}
	/**
	 * Sets the position of the View object.
	 * 
	 * @param	$x (Number)
	 * @param	$y (Number)
	 */
	public function setPosition($x:Number, $y: Number):Void {
		if ($x != null) {
			x = clip._x = Math.round($x);
		}
		if ($y!= null) {
			y = clip._y = Math.round($y);
		}				
	}
	
	/**
	 * Adjusts the size of the View to the ratio received as a parameter.
	 * 
	 * @param	$xscale (Number) The ratio of the width (0 - 1)
	 * @param	$yscale (Number) The ratio of the height (0 - 1)
	 */
	public function setScale($xscale:Number, $yscale:Number):Void {
		if ($xscale != null) {
			clip._xscale = int($xscale * 100);
			width = clip._width;
		}
		
		if ($yscale != null) {
			clip._yscale = int($yscale * 100);
			height = clip._height;
			
		}
	}
	/**
	 * Sets the size of the View object (width and height).
	 * 
	 * @param	$width (Number)
	 * @param	$height (Number)
	 * 
	 */	
	
	public function setSize($width:Number, $height:Number):Void {		
		if ($width != null) {
			width = $width;			
		}
		
		if ($height != null) {
			height = $height;			
		}	
		
		//-- 로드되지 않은 이미지에 대해서는 크기가 설정되지 않는다.
		
		//if (clip._width > 0 || clip._height > 0) {	
		if(loadingDone){
			clip._width = width;
			clip._height = height;			
		}
		
		
	}
	/**
	 * Sets the transparency of the View object
	 * 
	 * @param	$alpha (Number)
	 */
	public function setAlpha($alpha:Number):Void {
		clip._alpha = $alpha;
	}
	/**
	 * Sets the visibility of the View object
	 * 
	 * @param	$vis (Boolean)
	 */
	public function setVisible($vis:Boolean):Void {
		clip._visible = $vis;
	}
	
	/**
	 * Returns the child View located in the given index.
	 * 
	 * @param	$idx (Number) The index of the child view
	 * @return (View) The child view
	 */		
	public function getChildViewAt($idx:Number):View {
		return childViewLst[$idx];
	}
	
	/**
	 * Returns the child view added last.
	 * 
	 * @return (View) The child view added last
	 */
	public function getLastChildView():View {
		return childViewLst[childViewLst.length-1];
	}
	
	/**
	 * Returns the MovieClip managed by the View object
	 * 
	 * @return (MovieClip) 
	 */
	public function getClip():MovieClip {		
		return clip;
	}	
	
	/**
	 * Returns the index of the View object
	 * 
	 * @return (Number) The index of the View object
	 */
	public function getIndex():Number {
		return index;
	}	
	
	private function getClipName():String {
		return "holder_" + VIEWCNT++;
	}
	
	private function getContainterClip():MovieClip {			
		return clip;		
	}	
	//--실지로 그려진 width와 height(버튼이나 리스트는 숨겨진 영역이 있을 수 있기때문에 각 view에 따라 override하여 사용한다.)
	private function getDrawnWidth():Number {
		if (clip._width > 0) {
			return clip._width;
		}
		return width;
	}
	
	private function getDrawnHeight():Number {
		if (clip._height > 0) {
			return clip._height;
		}
		return height;
	}
	
	/**
	 * Returns the index of the next highest child view which has not been assigned.
	 * 
	 * @return (Number)
	 */
	public function getNextHighestChildIndex():Number {	
		return VIEW_COUNT++;		
	}	
	
	
	/**
	 * Changes the depth of the View object to the value received as a parameter.
	 * 
	 * @param	$depth (Number)
	 */
	public function changeDepth($depth:Number):Void {
		var kClip:MovieClip = getClip();
		kClip.swapDepths($depth);
	}
	
	/**
	 * Returns the parent view of the current View object. The parent view is specified using addChildView() only.
	 * If the current View object is drawn directly using view.draw(), null is returned.
	 * 
	 * @return (View)
	 */
	
	public function getParentView():View {
		return parentView;
	}	
	
	private function refreshSize():Void {
		width = getDrawnWidth();
		height = getDrawnHeight();
	}
	
	/*
	 * Returns the total number of child views added.
	 * 
	 * @return (Number)
	 */
	
	//public function getTotalChildView():Number {
		//return childViewLst.length;
	//}
}