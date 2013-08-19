

import lge.apps.LGEvent;
//import lge.utils.OneTimer;
import lge.views.View;
import lge.utils.ClipUtil;
import lge.utils.DrawUtil;
import lge.utils.NumberUtil;

/**
 * Loads an image file (JPG, GIF, PNG) or SWF file,
 * shows the file with the symbol in the library, and provides the method and event to control it.
 * 
 * {@code
 *
 * // Prepares the "img_0.jpg" file to load in the same folder as the SWF file.
 * 
import lge.views.ImageView;
import lge.views.View;
import lge.apps.LGEvent;

var view:ImageView = new ImageView();
view.addEventReceiver(this);

view.width = 240;
view.height = 100;
view.index = 0;
view.image = "img_0.jpg";

view.draw(this);

function onEventReceived($evt:LGEvent):Void {
	var kID:String = $evt.id;
	var view:View = View( $evt.data);
	
	// The size of an external image to be loaded cannot be checked in advance. Center align the image after loading.
	if (kID == LGEvent.LOAD_SUCCEED) {
		var tx:Number = (Stage.width-view.width) >> 1; 
		var ty:Number = (Stage.height-view.height) >> 1;
		view.setPosition(tx,ty);
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

class lge.views.ImageView extends View {	
	
	/**
	 * The identifier or external URL of the image to be displayed
	 */
	public var image:String;
	/**
	 * Whether to keep the image's original aspect ratio (default: false)
	 */
	public var maintainAspectRatio:Boolean = false;
	/**
	 * Whether to create an X box if the image creation fails (default: false)
	 */
	public var showingXBox:Boolean = false;	
	
	/**
	 * How many times try to load the external image when loding is failed.
	 */
	public var totalLoadingTryTime:Number = 2;
	
	private var loadingTryTime:Number;
	
	
	//private var tolerance:Number = 10;
	
	//private var oneTimer:OneTimer;
	
	private function createView():Void {
		
		
		populateElements();
		
		onDrawCompleted();	
		
		if (loadingDone) {			
			triggerEvent(LGEvent.LOAD_SUCCEED, this);
		}
	}
	
	
	
	private function populateElements():Void {	
		
		if (image != null) {			
			
			var kLowerPath:String = image.toLowerCase();
			
			if (kLowerPath.indexOf(".jpg") > -1 || kLowerPath.indexOf(".swf") > -1 || kLowerPath.indexOf(".png") > -1|| kLowerPath.indexOf(".gif") > -1) {	
				
				loadExternalImage();									
				
			}else {	
				loadingDone = true;
				
				//-- Linkage
				//-- clip이 만들어졌다고 해도 attach 될 경우에는 다시 parent에 해당 clip을 만든다.
				var kParent:MovieClip = clip._parent;
				clip.removeMovieClip();
				clip = ClipUtil.attachHolder(kParent, image, getClipName());
				
				resizeClip();	
				
			}		
		}	
		
	}	
	
	private function loadExternalImage():Void {
		if (loadingTryTime == null) {
			loadingTryTime = 1;
		}else {
			loadingTryTime++;
		}		
		
		loadingDone = false;				
				
		var kLoader:MovieClipLoader = new MovieClipLoader();
		
		kLoader.addListener(this);
		
		kLoader.loadClip(image, clip);
	}
	
	//private function onEventReceived($evt:LGEvent):Void {
		//var kID:String = $evt.id;
		//var kName:String = $evt.data.getString("name");
		//if (kID == LGEvent.TIME_PASSED && kName == "timer_load") {
			//onLoadError();
		//}else {
			//super.onEventReceived($evt);
		//}
	//}
	
	
	private function onLoadInit($tgt:MovieClip):Void {			
		
		loadingDone = true;
		
		resizeClip();
		
		triggerEvent(LGEvent.LOAD_SUCCEED, this);
		
		//deleteAllLoadingEvents();
		
	}
	
	
	private function onLoadError($tgt:MovieClip):Void {	
		if (loadingTryTime >= totalLoadingTryTime) {
			loadingDone = true;
			
			resizeClip();
			
			triggerEvent(LGEvent.LOAD_ERROR, this);
			
			//deleteAllLoadingEvents();	
		}else {
			loadExternalImage();
		}
		
		
	}
	
	//private function deleteAllLoadingEvents():Void {
		//oneTimer.removeEventReceiver(this);
		//oneTimer.dealloc();
		//oneTimer = null;
		//onEventReceived = null;
		//onLoadError = null;
		//onLoadInit = null;
	//}
	
	private function resizeClip():Void {
		
		var kFail:Boolean = (clip._width == null || clip._width == 0);
		
		if (showingXBox && kFail) {
						
			DrawUtil.createXBox(clip, NumberUtil.getNumber(width, 20), NumberUtil.getNumber(height, 20));
						
		}else {
			var kWid:Number;
			var kHei:Number;
			if (maintainAspectRatio) {
				if (width != null && height != null) {				
					var kScale:Number = NumberUtil.getScaleToFit(clip._width, clip._height, width, height,true);				
					
					kWid = int(clip._width * kScale / 100);
					kHei = int(clip._height * kScale / 100);					
					
					setSize(kWid,kHei);
				}else {
					setSize(clip._width, clip._height);
				}
			}else {
				kWid = NumberUtil.getNumber(width, clip._width);
				kHei = NumberUtil.getNumber(height, clip._height);	
				
				var kPieceLst:Array = getPieceLst();
				
				if (kPieceLst.length == 3) {
					ClipUtil.resize3PiecedRect(kPieceLst, kWid);
					setSize(null, kHei);
				}else {
					setSize(kWid, kHei);
				}		
				
			}
		}		
	}
	
	
	
	
	
	private function getPieceLst():Array {
		var kLst:Array = new Array();
		var kTmpLst:Array = [clip.left, clip.center, clip.right];		
		
		for (var i:Number = 0; i < 3; i++) {
			
			if (kTmpLst[i] == null) {
				return null;
			}else{
				kLst.push(kTmpLst[i]);
			}			
		}		
		
		return kLst;
	}
	
	
	
}