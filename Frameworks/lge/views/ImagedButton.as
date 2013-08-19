

import lge.views.ImageView;
import lge.views.Button;

/**
 * Creates a button with an image and provides the method and event to control it.
 * 
 * {@code
 * // Create a MovieClip to be used as the button's background and set the "Identifier" field to "lnk_bg_btn" in the "Linkage Properties" window.
 * // Prepare "img_0.jpg" to be used as an icon in the swf directory.
 * 
import lge.views.ImageView;
import lge.views.ImagedButton;
import lge.apps.LGEvent;

var view:ImagedButton = new ImagedButton();
view.addEventReceiver(this);

view.x = 150;
view.y = 20;

view.background = "lnk_bg_btn";
view.backgroundWidth = 250;
view.backgroundHeight = 44;

view.image = "img_0.jpg";
view.imageX = 10;
view.imageY = 12;
view.imageWidth = 20;
view.imageHeight = 20;

view.label = "Hello this is text view";
view.fontSize = 18;
view.labelX = 40;
view.labelY = 10;

view.draw(this);


function onEventReceived($evt:LGEvent):Void{
	trace($evt.id);
}
		
 * }
 */
class lge.views.ImagedButton extends Button {			
	
	/** The identifier or external URL of the icon 
	 * @see lge.views.ImageView#image*/
	public var image:String;
	/** The X coordinate of the icon 
	 * @see lge.views.View#x*/
	public var imageX:Number;
	/** The Y coordinate of the icon
	 * @see lge.views.View#y*/
	public var imageY:Number;
	/** The width of the icon 
	 * @see lge.views.View#width*/
	public var imageWidth:Number;
	/** The height icon 
	 * @see lge.views.View#height*/
	public var imageHeight:Number;
	/** Whether to keep the aspect ratio of the icon (default: false) 
	 * @see lge.views.ImageView#maintainAspectRatio*/
	public var imageMaintainAspectRatio:Boolean;		
	
	/** A constant that indicates the index of the icon It is set to {@link lge.views.View #getNextHighestChildIndex()} when ImagedButton is created.
	 * @see lge.views.View#getIndex()*/
	private static var _IMAGE_INDEX:Number;
	public static function get IMAGE_INDEX():Number { 
		if (_IMAGE_INDEX == null) _IMAGE_INDEX = VIEW_COUNT++;
		return _IMAGE_INDEX;
	}
		
	
	private function populateElements():Void {	
		
		super.populateElements();
		
		createImageView();	
		
	}	
	
	
	private function createImageView():Void {
		if (image == null) return;			
		//=======================//			
		var kView:ImageView = new ImageView();
		kView.addEventReceiver(this);	
		
		kView.putString("name", "icon");
		
		kView.image = image;
		kView.width = imageWidth;
		kView.height = imageHeight;
		kView.x = imageX;
		kView.y = imageY;
		kView.index = IMAGE_INDEX;
		kView.maintainAspectRatio = imageMaintainAspectRatio;			
		
		addChildView(kView);			
				
	}
	
	
	
	
}