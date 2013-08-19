import lge.apis.PathFinder;
import lge.apps.LGEvent;
import lge.gadgets.Gadget;

/** 
  * A pre-built Flash (gadget) class to use the banner advertisement API provided by LG.
  * 
 */

class lge.gadgets.BannerAdGadget extends Gadget {		

	public var x:Number = 0;
	public var y:Number = 0;
	public var width:Number = 0;
	public var height:Number = 0;
	
	function BannerAdGadget() {
		super();
	}
	
	/**
	 * Opens the ad gadget.
	 * 
	 * @param	holder (MovieClip) An empty movie clip to open the ad gadget.
	 */
	public function open(holder:MovieClip):Void {
			
		var kPath:String = getGadgetPath();
		
		trace("[BannerAdGadget] gadget path : "+kPath);
		
		super.open(holder, kPath);
	}
	
	/**
	 * Closes the ad gadget. 
	 */
	public function close():Void { 
		trace("[BannerAdGadget] close.");
		
		app.stopAd();
		app.dealloc();		
		super.close();
	}

	/**
	 * Displays the banner ad on screen. 
	 * 
	 * @param	bannerType	[in] A banner ad type.
	 */
	public function displayBanner(bannerType:String):Void {
		trace("[BannerAdGadget] displayBanner x:"+app.banner_x+" y:"+app.banner_y+" width:"+app.banner_width+" height:"+app.banner_height+" isFullScreen:"+app.banner_isFullScreen);
		
		app.displayBanner(bannerType);
		
		x = app.banner_x;
		y = app.banner_y;
		width = app.banner_width;
		height = app.banner_height;
	}
	
	/**
	 * Determines whether the ad is displayed in full screen. 
	 * 
	 * @return	bFullScreen	- Whether the ad is displayed in full screen
	 */
	public function isFullScreen():Boolean {
		return app.banner_isFullScreen;
	}
	
	/**
	 * Displays the banner ad on full screen.
	 */
	public function openFullScreenPopup():Void {
		trace("[BannerAdGadget] openFullScreenPopup");
		app.openFullScreenPopup();
	}
	
	/**
	 * Handles the focus on the banner ad.
	 * 
	 * @param	bVisible	[in] Whether the focus is available or not (true: focus, false: no focus).
	 */
	public function highlightFrame(bVisible:Boolean):Void {
		trace("[BannerAdGadget] highlightFrame");
		
		app.highlightFrame(bVisible);
	}
		
	private function onEventReceived($evt:LGEvent):Void {		
		trace("[BannerAdGadget] onEventReceived, id : " + $evt.id + "  data : " + $evt.data);
		
		var kID:String = $evt.id;		
		triggerEvent(kID, this);		
	}
	
	private function getGadgetPath():String{
		var kCommonPath:String =  PathFinder.getCommonPath();
		
		var gadgetFullPath:String = kCommonPath+"ADGadget/bannerAdGadget.swf";		
		trace("[BannerAdGadget] getGadgetPath :" + gadgetFullPath);
		
		return gadgetFullPath;
	}	
	
	private function onLoadInit($tgt:MovieClip):Void {
		trace("[BannerAdGadget] onLoadInit" );
		super.onLoadInit($tgt);
		
		triggerEvent(LGEvent.AD_LOADED, this);
	}
}