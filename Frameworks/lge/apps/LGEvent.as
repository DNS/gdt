import lge.apps.LGObject;
/**
 * A class that is passed as a parameter when handling events of FFC2.0.
 * It has the IDs of all events that occur in the View class as intrinsic constants.
 * 
 * For LGCustomEventManager, it is forwarded using the onEventReceived(evt:LGEvent):Void method of the event listener object. 
 * For LGExtendedEventManager, it is forwarded using the onExtendedEventReceived(evt:LGEvent):Void method of the event listener object.
 */
class lge.apps.LGEvent extends LGObject{	
	
	public var id:String;
	public var data:Object;		
	
	/**
	 * A constructor. It receives the event IDs and data to be forwarded as a parameter.
	 * 
	 * @param	$id (String) The ID of the event. It is defined by the user to identify the events.
	 * @param	$data (Object) The data to be forwarded. Since the parameter is the object type, various types of data can be forwarded.
	 */
	function LGEvent($id:String, $data:Object) 	{		
		id = $id;
		data = $data;			
	}
	
	//======================================================================== Definition of the event constants 
	/** Event fired when the Exit button is selected 	*/
	public static var SELECT_EXIT:String = "onSelectExit";
	/** Event fired when the Back button is selected 	*/
	public static var SELECT_BACK:String = "onSelectBack";
	
	/** Event fired when the Cancel button is selected 	*/
	public static var SELECT_CANCEL:String = "onSelectCancel";	
	
	/** Event fired when the mouse is rolled over 
	 * @see lge.views.Button*/
	public static var ROLL_OVER:String = "onRollOver";
	/** Event fired when the mouse is rolled out 
	 * @see lge.views.Button*/
	public static var ROLL_OUT:String = "onRollOut";
	/** Event fired when the mouse is released 
	 * @see lge.views.Button*/
	public static var RELEASE:String = "onRelease";
	/** Event fired when the mouse is pressed
	 * @see lge.views.Button*/
	public static var PRESS:String = "onPress";
	/** Event fired when the button is selected
	 * @see lge.views.Button*/
	public static var SELECT_BUTTON:String = "onSelectButton";
	/** Event fired when the button status is normal
	 * @see lge.views.Button*/
	public static var NORMAL_BUTTON:String = "onNormalButton";
	/** Event fired when the button is focused on
	 * @see lge.views.Button*/
	public static var FOCUS_BUTTON:String = "onFocusButton";
	/** Event fired when the key input is detected
	 * @see lge.utils.KeyEventAdapter*/
	public static var KEY_PRESSED:String = "onKeyPressed";
	/** Event fired when the movement of the movieclip ends 
	 * @see lge.utils.Mover*/
	public static var END_MOVE:String = "onEndMove";
	
	/**
	 * Event fired when loading the external file (image/swf) succeeds
	 * @see lge.views.ImageView
	 */
	public static var LOAD_SUCCEED:String = "onLoadSucceed";
	/**
	 * Event fired when loading the external file (image/swf) fails
	 * @see lge.views.ImageView
	 */
	public static var LOAD_ERROR:String = "onLoadError";
	
	/**
	 * Event fired when the text in the text filed changes
	 * @see lge.gadgets.KeyboardGadget
	 */
	public static var TEXT_CHANGED:String = "onTextChanged";
	/**
	 * Event fired when the focus of the KeyboardGadget tries to move outside the right border
	 * @see lge.gadgets.KeyboardGadget
	 */
	public static var TRY_TO_MOVE_BEYOND_RIGHT:String = "onTryToMoveBeyoundRightBorder";
	/**
	 * Event fired when the focus of the KeyboardGadget tries to move outside the left border
	 * @see lge.gadgets.KeyboardGadget
	 */
	public static var TRY_TO_MOVE_BEYOND_LEFT:String = "onTryToMoveBeyoundLeftBorder";
	/**
	 * Event fired when the focus of the KeyboardGadget tries to move outside the top border
	 * @see lge.gadgets.KeyboardGadget
	 */
	public static var TRY_TO_MOVE_BEYOND_TOP:String = "onTryToMoveBeyoundTopBorder";
	/**
	 * Event fired when the focus of the KeyboardGadget tries to move outside the bottom border
	 * @see lge.gadgets.KeyboardGadget
	 */
	public static var TRY_TO_MOVE_BEYOND_BOTTOM:String = "onTryToMoveBeyoundBottomBorder";
	
	/**
	 * Event fired when the checker's state changes
	 * @see lge.views.Checker
	 */
	public static var CHECK_STATE_CHANGED:String = "onCheckStateChanged";
	
	
	/**
	 * Event fired when the time specified in OneTimer has elapsed
	 * @see lge.utils.OneTimer
	 */
	public static var TIME_PASSED:String = "onTimePassed";
	
	/**
	 * 창이나 Application이 닫힐때 발생하는 이벤트
	 */
	public static var CLOSED:String = "CLOSED";
	
	/**
	 * Event triggered when an item in the list view is selected
	 * @see lge.views.ListView
	 */	
	public static var SELECT_LIST_ITEM:String = "onSelectListItem";
	/**
	 * Event fired when the focus of the list view changes
	 * @see lge.views.ListView
	 */
	public static var FOCUS_CHANGED:String = "onFocusChanged";
	
	/**
	 * Event fired when creating a view object succeeds. Note that this event does not check whether an external file is loaded.
	 * @see lge.views.View
	 */
	public static var DRAW_COMPLETED:String = "onDrawCompleted";
	/**
	 * Event fired when a child view is added to the View object
	 * @see lge.views.View
	 */
	public static var CHILD_VIEW_ADDED:String = "onChildViewAdded";
	
	/**
	 * The onPress mouse event fired in the scroller's rail 
	 * @see lge.views.Scroller
	 */
	public static var PRESS_RAIL:String = "onPressRail";
	/**
	 * The onRelease mouse event fired in the scroller's rail 
	 * @see lge.views.Scroller
	 */
	public static var RELEASE_RAIL:String = "onReleaseRail";
	/**
	 * The onRollOver mouse event fired in the scroller's rail 
	 * @see lge.views.Scroller
	 */
	public static var ROLL_OVER_RAIL:String = "onRollOverRail";
	/**
	 * The onRollOut mouse event fired in the scroller's rail 
	 * @see lge.views.Scroller
	 */
	public static var ROLL_OUT_RAIL:String = "onRollOutRail";
	/**
	 * Event fired when the scroller's train moves
	 * @see lge.views.Scroller 
	 */
	public static var SCROLLER_TRAIN_MOVED:String = "onScrollerTrainMoved";
	/**
	 * Event fired when the scroller's train is dragged
	 * @see lge.views.Scroller 
	 */
	public static var TRAIN_DRAG_ENDED:String = "onTrainDragEnded";
	/** 
	 * Event fired when loading the gadget succeeds.
	 * @see lge.gadgets.Gadget
	 */
	public static var GADGET_LOADED:String = "onGadgetLoaded";	
	
	/** 
	 * Event fired when loading the gadget fails.
	 * @see lge.gadgets.Gadget
	 */
	public static var GADGET_LOADING_ERROR :String = "onGadgetLoadingError";	
	
	/**
	 * Event fired when the video of MediaPlayerGadget starts playing
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_PLAY:String = "onVideoPlay";
	/**
	 * Event fired when the video of MediaPlayerGadget stops
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_STOP:String = "onVideoStop";
	/**
	 * Event fired when the video of MediaPlayerGadget pauses
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_PAUSE:String = "onVideoPause";	
	
	/**
	 * Event fired when the video of MediaPlayerGadget pauses and restarts
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_RESUME:String = "onVideoResume";
	
	/**
	 * MediaPlayerGadget이 전체 화면으로 전환되면 발생
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_SCREEN_FULL:String = "onVideoScreenFull";
	
	/**
	 * MediaPlayerGadget이 작은 화면으로 전환되면 발생
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_SCREEN_SMALL:String = "onVideoScreenSmall";
	/**
	 * MediaPlayerGadget이 UI가 사라질 때 발생 (풀스크린 상태일 때만 작동)
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_UI_HIDE:String = "onVideoUIHide";
	/**
	 * MediaPlayerGadget이 UI가 나타날 때 발생 (풀스크린 상태일 때만 작동)
	 * @see lge.gadgets.MediaPlayerGadget 
	 */
	public static var VIDEO_UI_SHOW:String = "onVideoUIShow";
	
	/**
	 * 텍스트 필드내에 글자 길이가 지정되어 있을 경우 글자의 길이가 그 길이를 넘어설때 호출 
	 */
	public static var TEXT_FULL:String = "onTextFull";
	
	//============================================================ extended event 상수
	
	public static var CLOSE_ALL_WINDOW:String = "EVT_CLOSE_ALL_WINDOW";
	public static var CLOSE_ALL_BY_HOME:String = "EVT_CLOSE_ALL_BY_HOME";
	public static var POPUP_ON:String = "EVT_POPUP_ON";
	public static var POPUP_OFF:String = "EVT_POPUP_OFF";
	
	//--Network 이벤트 : LGEvent에서 dispatch된다.
	public static var NETWORK_CONNECTED:String = "EVT_NETWORK_CONNECTED";
	public static var NETWORK_DISCONNECTED:String = "EVT_NETWORK_DISCONNECTED";	
	public static var NETWORK_SLOW:String = "EVT_SLOWNETWORK";
	public static var NETWORK_HTTP_ERROR:String = "EVT_HTTP_ERROR";
	public static var NETWORK_BUFFERING_START:String = "EVT_BUFFERING_START";
	public static var NETWORK_BUFFERING_END:String = "EVT_BUFFERING_END";
	public static var NETWORK_GAME_FINISHED:String = "EVT_GAME_FINISHED";
	
	
	public static var MOTIONREMOCON_ON:String = "EVT_MOTIONREMOCON_ON";
	public static var MOTIONREMOCON_OFF:String = "EVT_MOTIONREMOCON_OFF";
	
	public static var MOTIONREMOCON_CH_UP:String = "EVT_MOTIONREMOCON_CH_UP";
	public static var MOTIONREMOCON_CH_DOWN:String = "EVT_MOTIONREMOCON_CH_DOWN";
	public static var BLUETOOTH_CONNECTED:String = "EVT_BLUETOOTH_CONNECTED";
	public static var BLUETOOTH_DISCONNECTED:String = "EVT_BLUETOOTH_DISCONNECTED";
	public static var SCREENSAVER_CHANGED:String = "EVT_SCREENSAVER_CHANGED";

	public static var LANGUAGE_CHANGED:String = "EVT_LANGUAGE_CHANGED";

	//Media Event
	public static var PLAYBACK_START:String = "EVT_PLAYBACK_START";
	public static var PLAYBACK_END:String = "EVT_PLAYBACK_END";	
	public static var ERR_PLAYING:String = "EVT_ERR_PLAYING";
	public static var ERR_BUFFERFULL:String = "EVT_ERR_BUFFERFULL";
	public static var ERR_BUFFERLOW:String = "EVT_ERR_BUFFERLOW";
	public static var SLOW_NETWORK:String = "EVT_SLOWNETWORK";
	public static var DECODING_FAILED:String = "EVT_AUDIO_DECODING_FAILED";
	public static var RESOURCE_ERROR_NOT_FOUND:String = "EVT_RESOURCE_ERROR_NOT_FOUND";
	
	//AD Event
	public static var AD_FULLSCREEN_OPENED:String = "fullScreenAdOpened";
	public static var AD_FULLSCREEN_CLOSED:String = "fullScreenAdClosed";
	public static var AD_PLAYING:String = "ad_playing";
	public static var AD_COMPLETED:String = "ad_completed";
	public static var AD_ABSENT:String = "ad_absent";
	public static var AD_ERROR:String = "ad_error";
	public static var AD_LOADED:String = "ad_loaded";
	
	public static var AD_BANNER_PLAYING:String = "ad_banner_playing";
	public static var AD_BANNER_COMPLETED:String = "ad_banner_completed";
	public static var AD_BANNER_ABSENT:String = "ad_banner_absent";
	public static var AD_BANNER_ERROR:String = "ad_banner_error";
	public static var AD_BANNER_LOADED:String = "ad_banner_loaded";
	
	public static var AD_VIDEO_PLAYING:String = "ad_video_playing";
	public static var AD_VIDEO_COMPLETED:String = "ad_video_completed";
	public static var AD_VIDEO_ABSENT:String = "ad_video_absent";
	public static var AD_VIDEO_ERROR:String = "ad_video_error";
	public static var AD_VIDEO_LOADED:String = "ad_video_loaded";
}