

import lge.utils.StringUtil;
import lge.utils.NumberUtil;

/**
 * Helps handle a text field which is an intrinsic class
 * of the Flash Player.
 */
class lge.utils.TextFieldUtil {		
	
	/**
	 * Resizes the font to fit the text field if the length of the text exceeds
	 * the maximum size of the text field.
	 * It does not reduce indefinitely; it reduces the font size using
	 * the fonts available.
	 * 
	 * @param	$fld (TextField) The target text field
	 * @param	$txt (String) The input text
	 * @param	$maxWid (Number) The maximum size of the text field
	 * @param	$sizeLst (Array) An array with the fonts available 
	 * @return  (Number) The applied font size
	 */
	public static function putTxtWithMultipleFontSize($fld:TextField, $txt:String, $maxWid:Number, $sizeLst:Array, $multi:Boolean):Number {		
		
		if ($multi == null) $multi = false;		
		$fld.multiline = $multi;
		
		var kFormat:TextFormat = $fld.getTextFormat();
		var kLen:Number = $sizeLst.length;
		var kSize:Number;
		var kWid:Number;
		
		for (var i:Number = 0; i < kLen; i++) {			
			
			kSize = $sizeLst[i];			
			if (kSize != kFormat.size) {
				kFormat.size = kSize;
				$fld.setTextFormat(kFormat);					
			}
			
			//--마지막 사이즈일때는 크기 측정하지 않고 텍스트를 기입한다.
			if (i == (kLen - 1)) {
				$fld.text = $txt;
				$fld.setTextFormat(kFormat);				
				return kSize;
			}else {
				kWid = getTextWid($fld, $txt);	
				
				if (kWid <= $maxWid) {
					$fld.text = $txt;
					$fld.setTextFormat(kFormat);				
					return kSize;
				}
			}			
		}
		
	}
	
	
	//-- issue : 아무런 글자가 필드에 있지 않으면 정상적인 값을 구하지 못한다. 그러므로 비어 있을 경우 빈 공백문자를 하나 넣는다.
	/**
	 * Calculates the width of the text entered in the text field. 
	 * 
	 * @param	$fld (TextField) The target text field
	 * @param	$txt (String) The input text
	 * @return (Number) The width of the text 
	 */
	public static function getTextWid($fld:TextField, $txt:String):Number {
		var kSavedTxt:String = $fld.text;
		if (kSavedTxt == "") $fld.text = " ";		
		
		var kFormat:TextFormat = $fld.getTextFormat();	
		var kObj:Object
		var kTxt:String = "";
		if ($fld.password) {
			for (var i:Number = 0; i < $txt.length; i++) {
				kTxt += "*";
			}
		}else {
			kTxt = $txt;
		}
		kObj =  kFormat.getTextExtent(kTxt);
		
		var kWid:Number = kObj.width;
		
		 if ($fld.multiline) {
			//--단순히 필드의 너비로 계산하면, 마진이나 패딩등 여러가지 변수로 줄바꿈이 일어나는 최대 크기를 알지 못한다. 
			//-- 그래서 줄바꿈이 일어날때 필드의 크기를 구하여 나머지 값으로 캐럿이 나아갈 거리를 구한다.
			var kExtendedObj:Object = kFormat.getTextExtent($txt, $fld._width);
			if (kExtendedObj.height > kObj.height) {
				//-- 줄바꿈이 이루어졌다면.-> 실질적인 필드의 너비 계산 
				//-- mod 값이 0이 나올 경우 줄바꿈은 일어나지 않지만, wid는 0이 나오기에 전체 너비에서 1을 더해 준다.
				kWid = kObj.width % (kExtendedObj.width+1);					
			}			
		}		
		//-- 크기를 잰 후 원복 시킨다.
		if (kSavedTxt == "") {
			$fld.text = kSavedTxt;
		}		
		
		return Math.round(kWid);
	}
	
	/**
	 * Calculates the height of the text entered in the text field.
	 * 
	 * @param	$fld (TextField) The target text field
	 * @param	$txt (String) The input text
	 * @return (Number) The height of the text
	 */
	public static function getTextHei($fld:TextField, $txt:String):Number {
		var kSavedTxt:String = $fld.text;
		if (kSavedTxt == "") $fld.text = " ";
		var kFormat:TextFormat = $fld.getTextFormat();
		
		var kObj:Object;
		if ($fld.multiline) {			
			kObj = kFormat.getTextExtent($txt,$fld._width);
		}else {
			kObj = kFormat.getTextExtent($txt);
		}
		var kHei:Number = kObj.height;
		//-- 크기를 잰 후 원복 시킨다.
		if (kSavedTxt == "") $fld.text = kSavedTxt;		
		return Math.round(kHei);
	}
	
	/**
	 * Calculates the width of the text field according to the text entered to the text field. 
	 * 
	 * @param	$fld (TextField) The target text field
	 * @param	$txt (String) The input text
	 * @return (Number) The width of the text field 
	 */
	public static function getFldWid($fld:TextField, $txt:String):Number {
		var kSavedTxt:String = $fld.text;
		if (kSavedTxt == "") $fld.text = " ";
		var kFormat:TextFormat = $fld.getTextFormat();
		var kObj:Object = kFormat.getTextExtent($txt);
		var kWid:Number = kObj.textFieldWidth;
		//-- 크기를 잰 후 원복 시킨다.
		if (kSavedTxt == "") $fld.text = kSavedTxt;
		return Math.round(kWid);
	}
	/**
	 * Calculates the height of the text field according to the text entered to the text field. 
	 * 
	 * @param	$fld (TextField) The target text field
	 * @param	$txt (String) The input text
	 * @return (Number) The height of the text field 
	 */
	public static function getFldHei($fld:TextField, $txt:String):Number {
		var kSavedTxt:String = $fld.text;
		if (kSavedTxt == "") $fld.text = " ";
		var kFormat:TextFormat = $fld.getTextFormat();
		var kObj:Object = kFormat.getTextExtent($txt);
		var kHei:Number = kObj.textFieldHeight;
		//-- 크기를 잰 후 원복 시킨다.
		if (kSavedTxt == "") $fld.text = kSavedTxt;
		return Math.round(kHei);
	}	
	
	/**
	 * Applies the specified color to the text field.
	 * 
	 * @param	$fld (TextField) 
	 * @param	$color (Number)
	 */
	public static function attachColorToFld($fld:TextField, $color:Number):Void {
		if ($fld != null && $color != null) {
			$fld.textColor = $color;
		}
	}
	
	//--to be deprecated
	//public static function createFld($holder:MovieClip, $name:String, $x:Number, $y:Number, $color:Number, $size:Number):TextField {
		//return createTextField($holder, $name, $x, $y, $color, $size);
	//}
	/**
	 * Creates a text field within the specific MovieClip, then returns the text field.
	 * 
	 * @param	$holder (MovieClip)
	 * @param	$name (String)
	 * @param	$wordWrap (Boolean)
	 * @param	$color (Number)
	 * @param	$size (Number)
	 * @param	$align (String)
	 * @return (TextField)
	 */
	public static function createTextField($holder:MovieClip, $name:String, $wordWrap:Boolean, $color:Number, $size:Number, $align:String):TextField {	
				
		$holder.createTextField($name, $holder.getNextHighestDepth(), 0, 0, 1, 1);		
		var kFld:TextField = $holder[$name];
		
		kFld.selectable = false;
		kFld.autoSize = true;		
		kFld.multiline = true;		
		
		kFld.wordWrap = $wordWrap;		

		attachColorToFld(kFld,$color);

		attachBasicFormatsToFld(kFld, $size, $align);
		
		return kFld;
	}
	
	//--여러 속성 적용--
	private static function attachBasicFormatsToFld($fld:TextField, $size:Number, $align:String):Void {
		var kFormat:TextFormat = new TextFormat();
		kFormat.font = "LG Display_Eng_Kor";
		kFormat.size = NumberUtil.getNumber($size, 24);
		kFormat.align = StringUtil.getString($align, "left");			
		$fld.setNewTextFormat(kFormat);
	}
	
	/**
	 * Applies the specified property to the text field's TextFormat.
	 * In addition to applying the property to the text field, the property can be applied to the specific area of the text
	 * by specifying the start and end points.
	 * 
	 * @param	$fld (TextField)
	 * @param	$attr (String)
	 * @param	$value (Object)
	 * @param	$start (Number)
	 * @param	$end (Number)
	 */
	public static function attachFormatToFld($fld:TextField, $attr:String, $value:Object, $start:Number, $end:Number):Void {		
		//var kFormat:TextFormat = new TextFormat();
		var kFormat:TextFormat = $fld.getNewTextFormat();
		kFormat[$attr] = $value;	
		if ($start != null && $end != null) {
			$fld.setTextFormat($start, $end, kFormat);			
		}else if ($start != null) {
			$fld.setTextFormat($start, kFormat);			
		}else {
			$fld.setTextFormat(kFormat);			
		}		
	}
}