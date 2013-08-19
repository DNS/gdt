
import lge.apps.LGCustomEventManager;
import lge.apps.LGEvent;
import lge.apps.LGObject;
import lge.utils.ClipUtil;
import lge.utils.KeyEventAdapter;

/** 
 * 
 * A gadget is a pre-built Flash file (SWF) that can be used for common purposes, 
 * such as keyboard or pop-up.
 * A gadget package is a group of classes that helps to control such Flash files.
 * 
 * The top class of all gadgets.
 * It opens the user interface required for the gadget and provides the method and event to control it.
 * 
 * <br><br>
 * 
 * Events fired:
 * 
 * <ul> onGadgetLoaded
 * 	<li>LGEvent value: GADGET_LOADED</li>
 * 	<li>Called when the gadget is loaded.</li>
 * </ul>
 * 	
 * <ul>	onKeyPressed
 *  <li>LGEvent value: KEY_PRESSED</li>
 *  <li>Called when a key is pressed after executing attachKeyHandler().</li>
 * </ul>
 *    
 * 
 */

 

class lge.gadgets.Gadget extends LGObject {
	
	public function dealloc():Void {		
		
		app.dealloc();	
		
		detachKeyHandler();
		
		clip.removeMovieClip();
		clip = null;
		
		super.dealloc();
	}		
	
	private var clip:MovieClip;
	private var loader:MovieClipLoader;
	private var app:Object;	
	
	private var keyEvtAdapter:KeyEventAdapter;	
	
	private var eventer:LGCustomEventManager;
	
	private static var cnt:Number = 0;
	
	private var path:String;
	
	function Gadget() {
		eventer = new LGCustomEventManager();
	}
	
	//-- 하위 클래스는 public이지만 Gadget에서는 private으로 드러나지 않는다.
	//-(하위 클래스에서 상속하여 사용)
	private function open($holder:MovieClip, $path:String):Void {			
		clip = $holder;
		
		path = $path;
		
		if ($holder == null) {
			clip = ClipUtil.createEmptyHolder(_root, "gadgetHolder_"+cnt++);
		}					
		
		if (loader == null) {			
			loader = new MovieClipLoader();
			loader.addListener(this);			
		}
		
		loader.loadClip($path, clip);
		
	}
	
	/**
	 * Closes the gadget.
	 */
	public function close():Void {
		app.removeEventReceiver(this);
		
		if (clip != null) {			
			loader.unloadClip(clip);
			clip.removeMovieClip();
			clip = null;
			loader = null;
		}
		
		dealloc();
	}
	
	private function onLoadInit($tgt:MovieClip):Void {
		
		clip = $tgt;
		
		app = $tgt.getApp();		
		
		app.addEventReceiver(this);
		
		initAppAfterLoad(app);			
		
		triggerEvent(LGEvent.GADGET_LOADED, this);
	}
	//-- For SDK
	private function onLoadError($tgt:MovieClip):Void {
		var kSplitLst:Array  = path.split(":");		
		
		var kRoot:String = kSplitLst[0].toLowerCase();		
		
		switch(kRoot) {
			case "c":
				kSplitLst[0] = "d";
			break;
			
			case "d":
				kSplitLst[0] = "e";
			break;
			
			case "e":
				kSplitLst[0] = "f";
			break;
			
			case "f":
				kSplitLst[0] = "g";
			break;
			
			case "g":
				kSplitLst[0] = "h";
			break;	
			
			default:
				triggerEvent(LGEvent.GADGET_LOADING_ERROR, this);
				return;
			break;
			
		}
		var kPath:String = kSplitLst.join(":");
		openAfterChangeRoot(clip, kPath);		
	}
	//-- For SDK
	private function openAfterChangeRoot($holder:MovieClip, $path:String):Void {			
		clip = $holder;
		
		path = $path;		
		
		loader.loadClip($path, clip);
		
	}
	
	private function initAppAfterLoad($app:Object):Void {
		//--triggerEvent(LGEvent.GADGET_LOADED, this) 호출하기 전에 호출  
	}
	
	private function triggerEvent($id:String, $data:Object):Void {
		eventer.triggerEvent($id, $data);
	}
	/**
	 * Adds an event listener to handle
	 * the events fired by the gadget.
	 * 
	 * @param	$receiver (Object) The object to be added as an event listener 
	 */
	public function addEventReceiver($receiver:Object):Void {
		eventer.addEventReceiver($receiver);	
	}	
	
	/**
	 * Removes the added event listener.
	 * 
	 * @param	$receiver (Object) The added event listener 
	 */
	public function removeEventReceiver($receiver:Object):Void {
		eventer.removeEventReceiver($receiver);			
	}
	
	private function onEventReceived($evt:LGEvent):Void {
		var kId:String = $evt.id;		
		if (kId == LGEvent.KEY_PRESSED) {			
			doSomeWithKey($evt.data.code);
		}
		//--받은 이벤트를 다시 송출한다.		
		triggerEvent(kId, $evt.data);		
	}
	/**
	 * Allows the gadget to perform its basic functions when it is called with the code of the pressed key.
	 * 
	 * @param	$code (Number) The code value of the key 
	 */
	public function doSomeWithKey($code:Number):Void {
		app.doSomeWithKey($code);		
	}
	
	/**
	 * Implements the key event handler to handle the key event.
	 */
	public function attachKeyHandler():Void {
		
		//app.takeFocus();
		
		if (keyEvtAdapter == null) {			
			keyEvtAdapter = new KeyEventAdapter();
			keyEvtAdapter.addEventReceiver(this);
		}
		
	}		
	
	/**
	 * Initializes and prepares to take the key focus.
	 */
	public function takeFocus():Void {		
		app.takeFocus();
	}
	
	/**
	 * Detaches the key event handler attached.
	 */
	public function detachKeyHandler():Void {
		
		//app.giveUpFocus();
		
		if (keyEvtAdapter != null) {			
			keyEvtAdapter.dealloc();
			keyEvtAdapter = null;
		}
		
	}
	
	
	/**
	 * Sets the visibility of the gadget.
	 * 
	 * @param	$visible (Boolean) Whether the gadget is visible according to the parameter passed
	 */
	public function setVisible($visible:Boolean):Void {
		clip._visible = $visible;		
	}
	
	/**
	 * Returns the visibility of the gadget as a boolean.
	 * 
	 * @return (Boolean) The current visibility of the gadget
	 */
	public function getVisible():Boolean {
		return clip._visible;
	}	
	
	/**
	 * Sets the coordinates of the gadget.
	 * 
	 * @param	$x (Number) The X coordinate of the gadget
	 * @param	$y (Number) The Y coordinate of the gadget
	 */
	public function setPosition($x:Number, $y:Number):Void {
		if (app.setPosition != null) {
			app.setPosition($x, $y);
		}else {
			clip._x = $x;
			clip._y = $y;
		}
		
	}
	
	/**
	 * Saves the coordinates of the gadget in an object and returns the object.
	 * 
	 * @return (Object) The object with the X and Y properties (the coordinate of the gadget)
	 */
	public function getPosition():Object {
		return { x:clip._x, y:clip._y };
	}
	/**
	 * Returns the width of the gadget.
	 * 
	 * @return (Number) The width of the gadget (in pixels)
	 */
	public function getWidth():Number {
		if (app.width != null) {
			return app.width;
		}
		return clip._width;
	}
	
	/**
	 * Returns the height of the gadget.
	 * 
	 * @return (Number) The height of the gadget 
	 */
	public function getHeight():Number {
		if (app.height != null) {
			return app.height;
		}
		return clip._height;
	}
	
	
	
	public function getApp():Object {
		return app;
	}
	
	
	
}