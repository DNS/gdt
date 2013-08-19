
import lge.apps.LGCustomEventManager;
import lge.utils.NumberUtil;
import lge.apps.LGEvent;

/**
 * Provides the method and event to load an external Flash image or SWF file.
 * 
 * 
 * {@code
 * // Prepare "img_0.jpg" to be loaded in the swf directory.
 * 
 * import lge.utils.ImageLoader;
import lge.apps.LGEvent;

var loader:ImageLoader = new ImageLoader();
loader.addEventReceiver(this);

var url:String = "img_0.jpg";
var holder:MovieClip = this.createEmptyMovieClip("image_holder", 0);
holder._x = 100;
holder._y = 100;

loader.loadImage(url, holder, 200, 200, false)

function onEventReceived($evt:LGEvent):Void {
	if($evt.id == LGEvent.LOAD_SUCCEED){
		trace($evt.data.getImageClip()); // Returns the loaded MovieClip.
	}
}
 * }
 * <br><br>
 * 
 * Events fired:
 * <ul> onLoadSucceed
 * 	<li>LGEvent value: LOAD_SUCCEED</li>
 * 	<li>Event fired when loading the external file (image/swf) succeeds</li>
 * </ul>
 * <ul> onLoadError
 * 	<li>LGEvent value: LOAD_ERROR</li>
 * 	<li>Event fired when loading the external file (image/swf) fails</li>
 * </ul>
 */
class lge.utils.ImageLoader extends LGCustomEventManager {
	
	public function dealloc():Void {	
		clip = null;
		super.dealloc();
	}	
	
	private var width:Number;
	private var height:Number;
	private var maintainAspectRatio:Boolean;
	private var clip:MovieClip;	
	private var permitExtend:Boolean;
	
	/**
	 * Loads the image (or swf) file and then fires the corresponding event.
	 * 
	 * @param	$url (String) The directory of the image or swf file
	 * @param	$holder (MovieClip) The MovieClip to draw the loaded image into
	 * @param	$width (Number) The width of the image when loaded (default: the original width) 
	 * @param	$height (Number) The height of the image when loaded (default: the original height)
	 * @param	$maintainAspectRatio (Boolean) Whether to maintain the original aspect ratio of the image when resizing it 
	 */
	public function loadImage($url:String, $holder:MovieClip, $width:Number, $height:Number, $maintainAspectRatio:Boolean, $permitExtend:Boolean):Void {		
		clip = $holder;
		width = $width;
		height = $height;
		maintainAspectRatio = $maintainAspectRatio;
		permitExtend = $permitExtend;
		
		var kLoader:MovieClipLoader = new MovieClipLoader();
		kLoader.addListener(this);
		kLoader.loadClip($url, $holder);
	}
	
	private function onLoadInit($tgt:MovieClip):Void {
		if (width != null && height != null) {
			if (maintainAspectRatio) {
				
				var kScale:Number = NumberUtil.getScaleToFit($tgt._width, $tgt._height, width, height, permitExtend);
				$tgt._xscale = $tgt._yscale = kScale;
				
			}else {
				
				$tgt._width = width;
				$tgt._height = height;
				
			}
		}
		
		triggerEvent(LGEvent.LOAD_SUCCEED, this);		
	}
	
	private function onLoadError($tgt:MovieClip):Void {
		triggerEvent(LGEvent.LOAD_ERROR, this);
	}
	
	/**
	 * Returns the MovieClip containing the loaded image.
	 * 
	 * @return (MovieClip) The MovieClip containing the loaded image
	 */
	public function getImageClip():MovieClip {
		return clip;
	}
	
	
}