

import lge.apis.PathFinder;
import lge.gadgets.Gadget;
import lge.apps.LGEvent;

/**
 * Provides a video player with graphic user interface, which can be used in a TV application using the video stream. It also provides functions to control the video such as play, pause, stop and skip, as well as user interface to control these functions in the user environment with the keyboard or mouse.

To use this media player, use the MediaPlayerGadget object of the lge.gadgets package.

 * {@code
 * // Set the size of the stage to 960 * 540.
 * // Prepare the video named "test.avi" in the same folder as the SWF file.
 * // Prepare the MovieClip button with the instance name btn_play and btn_screen in the stage.
 * // Insert the following code in the first frame of the stage.
 * 
 * import lge.gadgets.MediaPlayerGadget;
import lge.apps.LGEvent;

var smallX = 59;
var smallY = 100; 
var smallWidth = 570;
var smallHeight = 318;

var gadget:MediaPlayerGadget = new MediaPlayerGadget();
gadget.addEventReceiver(this);

var holder:MovieClip = this.createEmptyMovieClip("holder",1);
gadget.open(holder, smallX, smallY, smallWidth, smallHeight);
gadget.setVideoURL("test.avi",20);

function onEventReceived($evt:LGEvent):Void{
	var kID:String = $evt.id;
	trace(kID);
	
}

Key.addListener(this);
this.onKeyDown = function():Void{
	var kCode:Number = Key.getCode();
	gadget.doSomeWithKey(kCode);
}

// Upon starting the test movie, nothing appears on the PC screen.
// Upload the published SWF file to the LG Emulator or TV set to test.


 * }
 * 
 * <br><br>
 * 
 * Events fired:
 * 
 * <ul> onVideoPlay
 * 	<li>LGEvent value: VIDEO_PLAY</li>
 * 	<li>Event fired when the video of MediaPlayerGadget starts playing</li>
 * </ul>
 * <ul> onVideoStop
 * 	<li>LGEvent value: VIDEO_STOP</li>
 * 	<li>Event fired when the video of MediaPlayerGadget stops</li>
 * </ul>
 * <ul> onVideoPause
 * 	<li>LGEvent value: VIDEO_PAUSE</li>
 * 	<li>Event fired when the video of MediaPlayerGadget pauses</li>
 * </ul>
 * <ul> onVideoResume
 * 	<li>LGEvent value: VIDEO_RESUME</li>
 * 	<li>Event fired when the video of MediaPlayerGadget pauses and restarts</li>
 * </ul>
 * <ul> onVideoScreenFull
 * 	<li>LGEvent value: VIDEO_SCREEN_FULL</li>
 * 	<li>MediaPlayerGadget이 전체 화면으로 전환되면 발생</li>
 * </ul>
 * <ul> onVideoScreenSmall
 * 	<li>LGEvent value: VIDEO_SCREEN_SMALL</li>
 * 	<li>MediaPlayerGadget이 작은 화면으로 전환되면 발생</li>
 * </ul>
 * <ul> onVideoUIHide
 * 	<li>LGEvent value: VIDEO_UI_HIDE</li>
 * 	<li>MediaPlayerGadget이 UI가 사라질 때 발생 (풀스크린 상태일 때만 작동)</li>
 * </ul>
 * <ul> onVideoUIShow
 * 	<li>LGEvent value: VIDEO_UI_SHOW</li>
 * 	<li>MediaPlayerGadget이 UI가 나타날 때 발생 (풀스크린 상태일 때만 작동)</li>
 * </ul>
 */
class lge.gadgets.MediaPlayerGadget extends Gadget {			
	
	private var smallScreenX:Number;
	private var smallScreenY:Number;
	private var smallScreenWidth:Number;
	private var smallScreenHeight:Number;
	private var videoURL:String;
	private var videoDuration:Number;
	private var screenMode:String = "small";
	private var fullScreenUIOffsetX:Number;
	private var fullScreenUIOffsetY:Number;
	
	/**
	 * Loads the MediaPlayer gadget in $holder passed as a parameter.
(In addition to $holder, other parameters indicate the coordinates and picture size of the video when it is reduced. The full screen uses the entire stage and no separate setting is required.)

	 * 
	 * @param	$holder (MovieClip) The MovieClip to load the gadget
	 * @param	$smallX (Number) The X coordinate when the picture size of the video is reduced
	 * @param	$smallY (Number) The Y coordinate when the picture size of the video is reduced
	 * @param	$smallWidth (Number) The width when the picture size of the video is reduced
	 * @param	$smallHeight (Number) The height when the picture size of the video is reduced
	 * @param	$fullScreenUIOffsetX (Number) 전체화면일 때 UI의 X 위치 offset
	 * @param	$fullScreenUIOffsetY (Number) 전체화면일 때 UI의 Y 위치 offset
	 * @param	$mode (String) 초기 스크린 모드 지정 (full|small, default=small)
	 */
	public function open($holder:MovieClip, $smallX:Number, $smallY:Number, $smallWidth:Number, $smallHeight:Number, $fullScreenUIOffsetX:Number, $fullScreenUIOffsetY:Number, $mode:String):Void {
		
		smallScreenX = $smallX;
		smallScreenY = $smallY;
		smallScreenWidth = $smallWidth;
		smallScreenHeight = $smallHeight;
		fullScreenUIOffsetX = $fullScreenUIOffsetX != null ? $fullScreenUIOffsetX : 0;
		fullScreenUIOffsetY = $fullScreenUIOffsetY != null ? $fullScreenUIOffsetY : 0;
		screenMode = $mode;
		if (screenMode != "full") {
			screenMode = "small";
		}
		
		var kPath:String = getGadgetPath();				
		
		super.open($holder, kPath);
	}	
	
	
	private function initAppAfterLoad($app:Object):Void {		
	
		app.smallScreenX = smallScreenX;
		app.smallScreenY = smallScreenY; 
		app.smallScreenWidth = smallScreenWidth;
		app.smallScreenHeight = smallScreenHeight;
		app.videoURL = videoURL;
		app.videoDuration = videoDuration;
		app.fullScreenUIOffsetX = fullScreenUIOffsetX;
		app.fullScreenUIOffsetY = fullScreenUIOffsetY;
		
		app.init(screenMode);			
	}
	
	private function onLoadInit($tgt:MovieClip):Void {	
		
		super.onLoadInit($tgt);
		
		setScreenMode(screenMode);
	}
	
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;
		//trace(kID);
		//var kData:Object = $evt.data;
		//switch (kID) {
						
		//}
		triggerEvent(kID, this);		
	}
	/**
	 * Sets the picture size of the video. There are two sizes: "small" and "full". When it is set to "small", the player is displayed in the specified size and position.
When it is set to "full", the player is displayed in the entire screen.

	 * @param	$mode (String) Small screen: "small", full screen: "full"
	 */
	public function setScreenMode($mode:String):Void {		
		if (app == null) return;
		screenMode = $mode;
		app.setScreenMode(screenMode);	
	}
	/**
	 * Stores the url and the duration (optional) of the video to play.
(the url and duration of the video can also be set in the playVideo($url, $duration) method, called to play the video. )

	 * @param	$url (String) The directory of the file
	 * @param	$duration (Number) The duration of the video (in seconds). This value is optional and may be omitted. The duration can be calculated and saved later when the video starts playing.

	 */
	public function setVideoURL($url:String, $duration:Number):Void {
		videoURL = $url;
		videoDuration = $duration;
		if (app != null) {
			app.videoURL = videoURL;
			app.videoDuration = videoDuration;
		}		
	}
	
	/**
	 * Plays the video. (If $url and $duration are not set, the value set in the setVideoURL() method or during the previous playback will be used.) 
	 * @param	$url (String) The directory of the file
	 * @param	$duration (Number) The duration of the video (in seconds). This value is optional and may be omitted. The duration can be calculated and saved later when the video starts playing.
	 */
	public function playVideo($url:String , $duration:Number):Void {
		if ($url != null) videoURL = $url;
		if ($duration != null) videoDuration = $duration;
		
		app.playVideo(videoURL, videoDuration);
	}
	/**
	 * Stops the video being played.
	 */
	public function stopVideo():Void {
		app.stopVideo();		
	}
	/**
	 * Pauses the video being played.
	 */
	public function pauseVideo():Void {
		app.pauseVideo();
	}
	/**
	 * Resumes the paused video from where it stopped.
	 */
	public function resumeVideo():Void {		
		app.resumeVideo();		
	}
	
	/**
	 * Moves the playback head position of the video to the next block. (If the duration is longer than 30 seconds, moves to duration/30 seconds forward; if the duration is less or equal to 30, moves to 1 second forward.)
	 */
	public function skipOneStepNext():Void {
		app.skipOneStepNext();
	}
	/**
	 * Moves the playback head position of the video to the previous block. (If the duration is longer than 30 seconds, moves to duration/30 seconds backward; if the duration is less or equal to 30, moves to 1 second backward.)
	 */
	public function skipOneStepPrev():Void {
		app.skipOneStepPrev();
	}
	/**
	 * Positions the playback head to the time location passed as a parameter.
	 * @param	$time (Number) The time location where the playback head is to be positioned in (in seconds)
	 */
	public function skipTo($time:Number):Void {		
		app.skipTo($time);	
	}
	/**
	 * Controls the video with the hot keys on the remote control, which correspond to the ones for the media player. The keys to control the video on the remote control are:
-	Play key, Pause Key, Stop Key, Skip Next (Right Key), Skip Prev (Left Key)

	 * @param	$code (Number) The code value of the pressed key. The processed key codes are:</br>
Skip Next : KeyCoder.RIGHT, KeyCoder.VOL_UP_FRONT</br>
Skip Right : KeyCoder.LEFT, KeyCoder.VOL_DOWN_FRONT</br>
Play : KeyCoder.PLAY</br>
Pause : KeyCoder.PAUSE</br>
Stop : KeyCoder.STOP</br>


	 */
	public function doSomeWithKey($code:Number):Void {
		app.doSomeWithKey($code);		
	}
	
	/**
	 * Returns the current screen size ("small", "full").
	 * @return (String) Small screen: "small", Full screen: "full"
	 */
	public function getScreenMode():String {		
		return app.getScreenMode();
	}	
	/**
	 * Returns the current playback state ("play", "pause", "stop").
	 * @return (String) "play|pause|stop"
	 */
	public function getPlaybackMode():String {
		return app.getPlaybackMode();
	}
	
	
	private function getGadgetPath():String{
		var kCommonPath:String =  PathFinder.getCommonPath();
				
		return kCommonPath + "MediaPlayerGadget/MediaPlayerGadget.swf";
	}
	
}