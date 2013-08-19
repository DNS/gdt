
import lge.views.Scroller;
import lge.views.ImageView;
/**
 * Displays a graph indicating the amount of increase, similar to the graph for the buffer of the media player.<br>
 * This graph is called the "loader".<br> 
 * 
 * Displays a graph indicating the current playback position in the media player. This graph is called the "tailer".
 * Similar to the loader, the width of the trailer changes between the maximum and minimum.
 * 
 * Inherits the lge.views.Scroller class and has ImageView to be used as the loader object.<br>
 * The setRubberValue($value) method is used to resize the loader with the Scroller object's setValue() method. 
 * <br><br>
 * If a MovieClip to be used as a progress bar is placed on the stage,
 * the scroller can be set and controlled as a view object.<br>
 * Note that the instance specified as the progress bar's MovieClip must have 
 * the MovieClips named "rail", "train" and "loader".
 * 
 * {@code
 * var scroller:ProgressBar = new ProgressBar();
 * scroller.setPreBuiltContainer(_root.scrollerClip); // The _root.scrollerClip contains the "rail", "train" and "loader" MovieClips. 
 * }
 */

class lge.views.ProgressBar extends Scroller {	
	
	public function dealloc():Void {
		loaderView.dealloc();
		loaderView = null;		
		loaderClip = null;
		
		trailerView.dealloc();
		trailerView = null;		
		trailerClip = null;
		
		super.dealloc();
	}
	
	/** A constant that indicates the index of the loader (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _LOADER_INDEX:Number;	
	public static function get LOADER_INDEX():Number { 
		if (_LOADER_INDEX == null) _LOADER_INDEX = VIEW_COUNT++;
		return _LOADER_INDEX;
	}
	/** The identifier or external URL of the loader 
	 * @see lge.views.ImageView#image*/
	public var loader:String;	
	
	/** A constant that indicates the index of the trailer (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _TRAILER_INDEX:Number;
	public static function get TRAILER_INDEX():Number { 
		if (_TRAILER_INDEX == null) _TRAILER_INDEX = VIEW_COUNT++;
		return _TRAILER_INDEX;
	}
	/** The identifier or external URL of the trailer 
	 * @see lge.views.ImageView#image*/
	public var trailer:String;
	
	private var loaderView:ImageView;	
	private var loaderClip:MovieClip;	
	private var trailerView:ImageView;
	private var trailerClip:MovieClip;
	
	private function populateElements():Void {
		
		super.populateElements();
		
		loaderView = createLoader();	
		
		trailerView = createTrailer();
		
		trainClip.swapDepths(getClip().getNextHighestDepth());
	}
	
	
	private function createLoader():ImageView {
		
		var kClip:MovieClip = getClip();		
		loaderClip = kClip.loader;
		
		if (loaderClip == null && loader == null) {
			return null;
		}
		
		var kView:ImageView = new ImageView();
		kView.index = LOADER_INDEX;	
		
		if (loaderClip != null) {				
			kView.setPreBuiltContainer(loaderClip);				
		}else if (loader != null) {			
			kView.image = loader;				
		}	
		
		kView.x = railClip._x;
		kView.y = railClip._y;	
		
		if (getIsHorizontal()) {
			kView.width = 1;					
			kView.height = railHeight;
		}else {
			kView.width = railWidth;			
			kView.height = 1;
		}							
		
		addChildView(kView);
		
		loaderClip = kView.getClip();
		
		return kView;
	}
	
	private function createTrailer():ImageView {
		
		var kClip:MovieClip = getClip();		
		trailerClip = kClip.trailer;
		
		if (trailerClip == null && trailer == null) {
			return null;
		}
		
		var kView:ImageView = new ImageView();
		kView.index = TRAILER_INDEX;	
		
		if (trailerClip != null) {			
			kView.setPreBuiltContainer(trailerClip);			
		}else if (loader != null) {			
			kView.image = trailer;			
		}
		
		kView.x = railClip._x;
		kView.y = railClip._y;	
		
		if (getIsHorizontal()) {
			kView.width = 1;					
			kView.height = railHeight;
		}else {
			kView.width = railWidth;			
			kView.height = 1;
		}							
		
		addChildView(kView);
		
		trailerClip = kView.getClip();
		
		return kView;
	}
	
	
	/**
	 * Resizes the loader. The value passed as a parameter is the one that the loader displays.
	 * 
	 * @param	$value (Number)
	 */
	public function setLoaderValue($value:Number):Void {						
		if ($value > maxValue) $value = maxValue;
		
		//if ($value <= maxValue) {
		var kGap:Number = getValueGap();			
		
		if (kGap > 0) {				
			
			var kRate:Number = ($value-minValue) / kGap;				
			var kSpan:Number;
			var kDis:Number;			
			if (getIsHorizontal()) {	
				kSpan = railClip._width;
				kDis = Math.round(kSpan * kRate);									
				loaderView.setSize(kDis, null);				
			} else {	
				kSpan = railClip._height;
				kDis = Math.round(kSpan * kRate);
				var kY:Number = railClip._y + kDis;					
				loaderView.setSize(null, kDis);
			}
		}else if (kGap == 0) {
			if (getIsHorizontal()) {												
				loaderView.setSize(0, null);				
			} else {									
				loaderView.setSize(null, 0);
			}
		}
			
		//}		
		
	}
	
	/**
	 * Resizes the trailer. The value passed as a parameter is the one that the trailer displays.
	 * 
	 * @param	$value (Number)
	 */
	public function setTrailerValue($value:Number):Void {						
			
		if ($value <= maxValue) {
			var kGap:Number = getValueGap();			
		
			if (kGap > 0) {				
				var kRate:Number = ($value-minValue) / kGap;				
				var kSpan:Number;
				var kDis:Number;			
				if (getIsHorizontal()) {	
					kSpan = railClip._width;
					kDis = Math.round(kSpan * kRate);										
					trailerView.setSize(kDis, null);					
				} else {	
					kSpan = railClip._height;
					kDis = Math.round(kSpan * kRate);									
					trailerView.setSize(null, kDis);
				}
			}else if (kGap == 0) {
				if (getIsHorizontal()) {														
					trailerView.setSize(0, null);					
				} else {															
					trailerView.setSize(null, 0);
				}
			}
			
			
		}		
		
	}
	
}