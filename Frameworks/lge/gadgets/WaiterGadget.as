

//import lge.apps.LGEvent;
import lge.apis.PathFinder;
import lge.gadgets.Gadget;
import lge.utils.ClipUtil;

/**
 * Creates a waiter provided by the device by default. A mouse block is automatically created and positioned to the center of the stage unless defined otherwise.
 * 
 * {@code
 * // Insert the following code in the first frame of the stage.
 * // The waiter is then displayed on the center of the screen.
 * // Click the mouse to close the waiter.
 * 
 * import lge.gadgets.WaiterGadget;

var holder:MovieClip = this.createEmptyMovieClip("holder",1);

var waiter:WaiterGadget = new WaiterGadget();
waiter.open(holder);

this.onMouseDown = function(){
	waiter.close();
}
 * }
 */
class lge.gadgets.WaiterGadget extends Gadget {	
	
	public function dealloc():Void {
		
		mBlocker.removeMovieClip();
		mBlocker = null;
		
		topHolder.removeMovieClip();
		topHolder = null;
		
		super.dealloc();
	}
	
	private var mBlocker:MovieClip;
	private var topHolder:MovieClip;	
	private var x:Number;
	private var y:Number;
	
	/**
	 * Opens the waiter.
	 * @param	$holder (MovieClip) The MovieClip to load the waiter. If not set, it is set to _root.
	 * @param	$x (Number) The X coordinate of the waiter. If not set, it is set to the center of the stage width.
	 * @param	$y (Number) The Y coordinate of the waiter. If not set, it is set to the center of the stage height.
	 */
	
	public function open($holder:MovieClip, $x:Number, $y:Number):Void {	
		
		topHolder = ($holder == null)?_root:$holder;
		x = ($x == null)?(Stage.width / 2):$x;
		y = ($y == null)?(Stage.height / 2):$y;
		
		mBlocker = ClipUtil.createEmptyHolder(topHolder, "mBlocker");		
		ClipUtil.createMouseBlocker(mBlocker, null, null, 0);	
		
		var kWaiterHolder:MovieClip = ClipUtil.createEmptyHolder(topHolder, "waiterHolder", x, y);		
		
		super.open(kWaiterHolder, getGadgetPath());			
		
	}		
	
	
	
	private function getGadgetPath():String {		
		return PathFinder.getCommonPath()+"WaiterGadget/WaiterGadget_big.swf";
	}
	
	
	
	
}