

import lge.utils.StringUtil;
import lge.views.View;
import lge.utils.TextFieldUtil;
/**
 * Creates a text view to display the specified text and provides the method and event to control it.<br>
 * - The label's color, size, word wrap, and array can be specified.<br>
 * - If the width and the terse properties are set, an ellipsis is displayed when the text exceeds the given width.<br>
 * - If the singleLine property is set to true, the text is displayed in a single line.
 * <br><br>
 * The combination of text field formats<br>
 * 
 * 1. If the width is null,<br>
 * - singeLine=true and align="left", regardless of the attributes' values.
 * <br><br>
 * 2. If the width is specified,<br>
 * - the text exceeding the width is truncated to the given width when singleLine=true and terse=null,<br>
 * - the text exceeding the width is truncated with an ellipsis to the given width when singleLine=true and terse is defined.<br>
 * <br>
 * - terse is always set to null and the text exceeding the width is wrapped to the next line when singleLine=false regardless.
 * 
 * {@code
 * 
 * // Creates a text view and checks the events fired.
 * 
import lge.views.TextView;
import lge.apps.LGEvent;

var view:TextView = new TextView();
view.addEventReceiver(this);

view.x = 20;
view.y = 20;
view.fontSize = 20;
view.width = 200;
view.wordWrap = true;
view.singleLine = true; // The text is displayed in a single line.
view.label = "Hello this is text view";

view.draw(this);

function onEventReceived ($evt:LGEvent):Void {
	trace($evt.id)
}
 * }
*/
class lge.views.TextView extends View {	
	
	public function dealloc():Void {
		stopScroll();
		super.dealloc();
	}
	
	/**
	 * The text to be displayed
	 */
	public var label:String;
	/**
	 * The font color (default: 0x000000)
	 */
	public var fontColor:Number = 0x000000;
	/**
	 * The font size (default: 20)
	 */
	public var fontSize:Number = 20;
	
	/**
	 * The alignment of the text field. It is same as the align attribute of the TextFormat class in Flash.<br>
	 * "left"--The text is left-aligned.<br>
	 * "center"--The text is center-aligned.<br>
	 * "right"--The text is right-aligned.<br> 	
	 */
	public var align:String;	
	/**
	 * An ellipsis to be displayed if the text exceeds the width.<br>
	 * This property is disabled if the width is not specified.
	 */
	public var terse:String;
	/**
	 * Whether to display the text in a single line (default: false)
	 */
	public var singleLine:Boolean = false;	
	/**
	 * Word wrap (default: false);
	 */
	//public var wordWrap:Boolean = false;	
	
	
	private var scrollSpeed:Number = 3;	
	private var optimizedLabel:String;	
	private var isScrolling:Boolean = false;
	
	
	private function populateElements():Void {
		
		if (label != null) {
			label = String (label);
		}		
		
		rectifyProperties();				
		
		if (label.length != null) {					
			setLabel(label);						
		}	
	}
	
	private function rectifyProperties():Void {
		//--width가 null이라면 글자가 한줄로 처음부터 끝까지 나오도록 속성 설정
		if (width == null) {
			//wordWrap = false;
			singleLine = true;	
			terse = null;
			align = "left";
		}else if (!singleLine) {
			terse = null;			
		}
		
	}
	/**
	 * Sets the text to be displayed in the text view.
	 * If both the width and terse properties are specified, the text exceeding the width is truncated with an ellipsis to the given width.
	 * 
	 * @param	$label (String) The text to be displayed in the text view 
	 * @param	$isHtml (Boolean) Whether the html property of the text field is true or false (default: false)
	 */
	
	public function setLabel($label:String, $isHtml:Boolean):Void {				
		
		if ($label != null) 	label = String ($label);
		if ($isHtml == null) $isHtml = false;
		
		var kFld:TextField = getTextField();
		kFld.html = $isHtml;
		
		if (terse != null && width != null) {
			optimizedLabel = StringUtil.getTerseStringByWidth(kFld, width, label, terse, 2);
			if ($isHtml) {
				kFld.htmlText = optimizedLabel;
			}else {
				kFld.text = optimizedLabel;
			}
			
		}else {
			optimizedLabel = label;
			if ($isHtml) {
				kFld.htmlText = optimizedLabel;
			}else {
				kFld.text = optimizedLabel;
			}
			
			
			if (!isNaN(width)) {	
				
				kFld._width = width;
				
				if (singleLine) {
					
					kFld.autoSize = false;
					
				}				
			}
		}	
		
		if (isScrolling) {
			startScroll();
		}
	}
	
	/**
	 * By default, the text view uses TextField,
	 * the intrinsic class of Flash. Returns this TextField object.
	 * 
	 * @return (TextView)
	 */
	public function getTextField():TextField {
		var kFld:TextField = clip.fld;
		if (kFld == null) {			
			
			kFld = TextFieldUtil.createTextField(clip, "fld", !singleLine, fontColor, fontSize, align);
			kFld.selectable = false;
			
		}
		
		return kFld;
	}
	
	/**
	 * Sets the text color.
	 * 
	 * @param	$color (Number)
	 */
	public function setFontColor($color:Number):Void {
		fontColor = $color;
		TextFieldUtil.attachColorToFld(getTextField(),$color);
	}
	
	/**
	 * Scrolls the text in the text field horizontally.<br>
	 * This is useful when a large portion of the text is out of the text field range.<br>
	 * If the text field is allowed to be scrolled all the time, it may impact the performance. It is recommended to use this function only in specific situations, 
	 * for example, when the text field takes a focus.
	 * 
	 * @param	$speed (Number) The scroll speed (default: 4)
	 */
	public function startScroll($speed:Number):Void {
		
		isScrolling = true;
		clip.fld.autoSize = false;		
		clip.fld.wordWrap = false;
		
		scrollSpeed = ($speed == null)?scrollSpeed:$speed;
		
		clip.fld.text = getExtendedLable();
		
		var kThis:TextView = this;		
		
		clip.onEnterFrame = function():Void {
			kThis.onFrameForScroll();
		}
	}
	
	/**
	 * Stops the text being scrolled.
	 */
	public function stopScroll():Void {
		isScrolling = false;
		clip.onEnterFrame = null;			
		clip.fld.text = optimizedLabel;
		clip.fld.hscroll = 0;
	}
	
	
	
	private function onFrameForScroll():Void {
		if (clip.fld.hscroll < clip.fld.maxhscroll) {
			
			clip.fld.hscroll += scrollSpeed;
		}else {
			clip.fld.hscroll = 0;
		}
		
	}
	
	
	
	private function getExtendedLable():String {
		var kFld:TextField = getTextField();
		var kTxt:String = "";		
		kFld.text = "";
		while (kFld.maxhscroll < 1) {
			kTxt += " ";
			kFld.text = kTxt;
		}
		return kTxt + label + kTxt;		
	}
	
	/**
	 * Returns whether the text is being scrolled horizontally.
	 * 
	 * @return (Boolean)
	 */
	public function getIsScrolling():Boolean {
		return isScrolling;
	}
}