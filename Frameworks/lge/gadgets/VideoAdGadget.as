import lge.apis.PathFinder;
import lge.apps.LGEvent;
import lge.gadgets.Gadget;
import lge.apis.Media;

/** 
  * A pre-built Flash (gadget) class to use the video advertisement API provided by LG.
  * 
 */

class lge.gadgets.VideoAdGadget extends Gadget {		

	function VideoAdGadget() {
		super();
	}
	
	/**
	 * Opens the ad gadget.
	 * 
	 * @param	holder (MovieClip) An empty movie clip to open the ad gadget.
	 */
	public function open(holder:MovieClip):Void { 			
		var kPath:String = getGadgetPath();
		trace("[VideoAdGadget] gadget path : "+kPath);		
		super.open(holder, kPath);
	}
	
	/**
	 * Plays a video ad before the main video starts.
	 * 
	 * @param	media   A media class constructor.
	 * @param	ch  A media channel (see lge.apis.MediaChannel).
	 * @param	x  x.
	 * @param	y  y
	 * @param	width   The width
	 * @param	height  The height
	 * @param	title  The title of the video content.
	 * @param	duration  The duration of the main video in seconds. 
	 */
	public function startPreroll(media:Media, ch:Number,  x:Number, y:Number, width:Number, height:Number, title:String, duration:Number):Void {
		trace("[VideoAdGadget] startPreroll");		
		app.startPreroll(media, ch, x, y, width, height, title, duration);
	}
	
	/**
	 * Plays a video ad after the main video starts. 
	 * 
	 * @param	media   A media class constructor.
	 * @param	ch  A media channel (see lge.apis.MediaChannel).
	 * @param	x  x.
	 * @param	y  y
	 * @param	width   The width
	 * @param	height  The height
	 * @param	title  The title of the video content.
	 * @param	duration  The duration of the main video in seconds. 
	 */
	public function startPostroll(media:Media, ch:Number,  x:Number, y:Number, width:Number, height:Number, title:String, duration:Number):Void {
		trace("[VideoAdGadget] startPostroll");		
		app.startPostroll(media, ch, x, y, width, height, title, duration);
	}
	
	/**
	 * Closes the ad gadget.
	 */
	public function close():Void {
		trace("[VideoAdGadget] close");		
		app.stopAd();
		app.dealloc();
		super.close();
	}

	private function onEventReceived($evt:LGEvent):Void {		
		trace("[VideoAdGadget] onEventReceived, id : " + $evt.id + "  data : " + $evt.data);
		
		var kID:String = $evt.id;		
		triggerEvent(kID, this);		
	}
	
	private function getGadgetPath():String{
		var kCommonPath:String =  PathFinder.getCommonPath();
		
		var gadgetFullPath:String = kCommonPath+"ADGadget/videoAdGadget.swf";		
		trace("[VideoAdGadget] getGadgetPath :" + gadgetFullPath);
				
		return gadgetFullPath;
	}	
	
	private function onLoadInit($tgt:MovieClip):Void {
		trace("[VideoAdGadget] onLoadInit" );
		super.onLoadInit($tgt);
		triggerEvent(LGEvent.AD_LOADED, this);
	}
}