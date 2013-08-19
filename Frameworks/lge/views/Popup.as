
import lge.views.ImageView;
import lge.views.TextView;
import lge.views.View;
import lge.apps.LGEvent;
import lge.utils.ClipUtil;
import lge.utils.OneTimer;
/**
 * Creates a popup with an image and provides the method and event to control it. <br>
 * When a popup is created, "mblockr" is also created to block mouse events in areas other than the popup window.<br>
 * If the duration ({@link #duration}) is set, the popup is closed after a specified period of time.
 * 
 * {@code
 *
 * // Create a MovieClip to be used as the popup's background and set the "Identifier" field to "lnk_bg" in the "Linkage Properties" window.
 * // Prepare "img_0.jpg" to be used as an icon in the swf directory.
 * // The popup is closed automatically after 3 seconds.
 * 
import lge.views.View;
import lge.views.Popup;
import lge.apps.LGEvent;

var ppp:Popup = new Popup();
ppp.x = ppp.y = 50;
ppp.background = "lnk_bg";

ppp.icon = "img_0.jpg";
ppp.iconX = 10;
ppp.iconY = 10;
ppp.iconWidth = 30;
ppp.iconHeight = 30;

ppp.title = "This is Title Text";
ppp.titleFontSize = 24;
ppp.titleColor = 0xFF6666;
ppp.titleX = 40;
ppp.titleY = 10;

ppp.message = "Hello my lady. It's world cup season. Please Enjoy. Hello my lady. It's world cup season. Please Enjoy.";
ppp.messageFontSize = 20;
ppp.messageX = 10;
ppp.messageY = 50;

ppp.duration = 3;	// Closes the popup automatically after 3 seconds.

ppp.draw(this);
 * }
 * <br><br>
 * 
 *  Events fired:
 * <ul> onTimePassed
 * 	<li>LGEvent value: TIME_PASSED</li>
 * 	<li>Event fired when the popup is closed automatically after a specified period of time</li>
 * </ul>
 */
class lge.views.Popup extends View {
	
	public function dealloc():Void {
		timer.dealloc();
		timer = null;
		
		mBlocker.removeMovieClip();
		mBlocker = null;
		
		super.dealloc();
	}
	
	/** Closes the popup automatically after a specified period of time. (in seconds)
	 * @see lge.utils.OneTimer*/
	public var duration:Number;
	
	/** The identifier of the background or external URL 
	 * @see lge.views.ImageView#image*/
	public var background:String;
	/** The width of the background 
	 * @see lge.views.View#width*/
	public var backgroundWidth:Number;
	/** The height of the background 
	 * @see lge.views.View#height*/
	public var backgroundHeight:Number;
	
	/** The identifier or external URL of the icon 
	 * @see lge.views.ImageView#image*/
	public var icon:String;
	/** The width of the icon 
	 * @see lge.views.View#width*/
	public var iconWidth:Number;
	/** The height of the icon 
	 * @see lge.views.View#height*/
	public var iconHeight:Number;
	/** The X coordinate of the icon 
	 * @see lge.views.View#x*/
	public var iconX;
	/** The Y coordinate of the icon 
	 * @see lge.views.View#y*/
	public var iconY;
	
	
	/** The title
	 * @see lge.views.TextView#label
	 */
	public var title:String;
	/**
	 * The alignment of the title text (left/center/right)<br>
	 * 
	 */
	public var titleAlign:String = "center";
	/** The X coordinate of the title
	 * @see lge.views.View#x*/
	public var titleX:Number;
	/** The Y coordinate of the title
	 * @see lge.views.View#y*/
	public var titleY:Number;
	/** The width of the title
	 * @see lge.views.View#width*/
	public var titleWidth:Number;
	/** The font size of the title (default: 14)
	 * @see lge.views.TextView#fontSize*/
	public var titleFontSize:Number = 14;
	/** The color of the title (default: 0x000000)
	 * @see lge.views.TextView#fontColor */
	public var titleColor:Number = 0x000000;
	
	/** The message
	 * @see lge.views.TextView#label
	 */
	public var message:String;
	/**
	 * The alignment of the message text (left/center/right)<br>
	 * 
	 */
	public var messageAlign:String = "center";
	
	/** The X coordinate of the message
	 * @see lge.views.View#x*/
	public var messageX:Number;
	/** The Y coordinate of the message
	 * @see lge.views.View#y*/
	public var messageY:Number;
	/** The width of the message
	 * @see lge.views.View#width*/
	public var messageWidth:Number;
	/** The font size of the message (default: 12)
	 * @see lge.views.TextView#fontSize*/
	public var messageFontSize:Number = 12;
	/** The color of the message (default: 0x000000)
	 * @see lge.views.TextView#fontColor */
	public var messageColor:Number = 0x000000;
	
	/** A constant that indicates the index of the popup background (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _BG_INDEX:Number ;
	public static function get BG_INDEX():Number { 
		if (_BG_INDEX == null) _BG_INDEX = VIEW_COUNT++;
		return _BG_INDEX;
	}
	/** A constant that indicates the index of the popup icon (ImageView) 
	 * @see lge.views.View#getIndex()*/
	private static var _ICON_INDEX:Number;
	public static function get ICON_INDEX():Number { 
		if (_ICON_INDEX == null) _ICON_INDEX = VIEW_COUNT++;
		return _ICON_INDEX;
	}
	/** A constant that indicates the index of the popup title (TextView) 
	 * @see lge.views.View#getIndex()*/
	private static var _TITLE_INDEX:Number;
	public static function get TITLE_INDEX():Number { 
		if (_TITLE_INDEX == null) _TITLE_INDEX = VIEW_COUNT++;
		return _TITLE_INDEX;
	}
	/** A constant that indicates the index of the popup message (TextView) 
	 * @see lge.views.View#getIndex()*/
	private static var _MESSAGE_INDEX:Number;
	public static function get MESSAGE_INDEX():Number { 
		if (_MESSAGE_INDEX == null) _MESSAGE_INDEX = VIEW_COUNT++;
		return _MESSAGE_INDEX;
	}
	
	public var isModal:Boolean = true;
	
	private var mBlocker:MovieClip;
	private var timer:OneTimer;	
	private var updateTimerOnUserEvent:Boolean = false;
	
	private var MARGIN:Number = 12;
	
	private function onEvent($cmd:String, $data:String):Void {		
		if ($cmd == LGEvent.MOTIONREMOCON_ON) {
			timer.updateTimer();			
		}else if ($cmd == LGEvent.MOTIONREMOCON_OFF) {
			timer.updateTimer();
		}
		super.onEvent($cmd, $data);
	}
	
	private function populateElements():Void {
		if (isModal) {
			//--depth를 맨 밑에 두기 위해 무비클립만 먼저 생성한다.
			mBlocker = ClipUtil.createEmptyHolder(clip, "mBlocker");	
		}		
		
		createBgView();					
		createIconView();			
		createTitleView();		
		createMessageView();		
		
		attachTimer();
	}
	
	public function setPosition($x:Number, $y: Number):Void {
		
		mBlocker.nest.removeMovieClip();
		
		super.setPosition($x, $y);
		if (isModal) {
			var kNest:MovieClip = ClipUtil.createEmptyHolder(mBlocker,"nest");
			ClipUtil.createMouseBlocker(kNest, null, null, 0);
		}					
	}
	
	
	private function createBgView():Void {		
		if (background != null) {
			
			var kView:ImageView = new ImageView();	
			kView.index = BG_INDEX;
			kView.image = background;
			kView.width = backgroundWidth;
			kView.height = backgroundHeight;				
			addChildView(kView);	
		}		
	}	
	
	private function createIconView():Void {
		if (icon != null) {
			var kView:ImageView = new ImageView();	
			kView.index = ICON_INDEX;
			kView.image = icon;
			kView.width = iconWidth;
			kView.height = iconHeight;
			kView.x = iconX;
			kView.y = iconY;			
			
			addChildView(kView);	
		}		
	}	
	
	private function createTitleView():Void {
		if (title.length > 0) {
			var kView:TextView = new TextView();
			kView.index = TITLE_INDEX;		
			
			kView.label = title;
			kView.fontColor = titleColor;
			kView.fontSize = titleFontSize;
			kView.x = titleX;
			kView.y = titleY;
			
			if (titleWidth == null) {				
			
				if (background != null) {
					var kBg:ImageView = ImageView(getChildViewAt(BG_INDEX));
					if (icon == null) {
						titleWidth = kBg.width - MARGIN*3;	
					}else {
						var kIcon:ImageView = ImageView(getChildViewAt(ICON_INDEX));
						titleWidth = kBg.width - kIcon.width - MARGIN*3;	
					}
				}
							
			}
			
			kView.width = titleWidth;
			
			kView.align = titleAlign;
			
			addChildView(kView);	
		}		
	}
	
	private function createMessageView():Void {
		if (message.length > 0) {
			
			var kView:TextView = new TextView();
			kView.index = MESSAGE_INDEX;
			
			kView.label = message;
			kView.fontColor = messageColor;
			kView.fontSize = messageFontSize;
			kView.x = messageX;
			kView.y = messageY;
			
			if (messageWidth == null) {	
				if (background != null) {
					messageWidth = getChildViewAt(BG_INDEX).width - MARGIN*3;	
				}							
			}
			
			kView.width = messageWidth;
			
			kView.align = messageAlign;
			
			addChildView(kView);	
		}		
	}
	
	private function attachTimer():Void {
		if (!isNaN(duration)) {
			timer = new OneTimer();
			timer.addEventReceiver(this);
			timer.start(duration, updateTimerOnUserEvent);
		}				
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		var kID:String = $evt.id;	
		
		if (kID == LGEvent.TIME_PASSED) {					
			triggerEvent(kID, this);			
			dealloc();			
		}else {
			super.onEventReceived($evt);
		}
		
		
	}	
	
	
	private function getDrawnWidth():Number {
		var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));		
		return kBgView.width;
	}
	
	private function getDrawnHeight():Number {
		var kBgView:ImageView = ImageView(getChildViewAt(BG_INDEX));
		return kBgView.height;
	}
	
	
}