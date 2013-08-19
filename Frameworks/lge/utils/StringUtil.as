
import lge.utils.TextFieldUtil;
/**
 * Helps handle a string which is an intrinsic class of the Flash Player
 * and a primitive type.
 */
class lge.utils.StringUtil {
	
	public static var FORMAT_DATE_MDY:String = "mdy";
	public static var FORMAT_DATE_DOTTED_YMD:String = "y.m.d";
	public static var FORMAT_DAY_UUU:String = "UUU";
	public static var FORMAT_DAY_K:String = "k";
	public static var FORMAT_DAY_ULL:String = "ull";
	
	/**
	 * Returns the string with an ellipsis if the text entered in the field exceeds the allowable range.
	 * Since this operation consumes considerable system resources, the check point can be specified.
	 * For example, if the maximum allowed number of characters is 10 for the field, the check can be performed from the 11th character.
	 * 
	 * @param	$fld (TextField) The field to be checked (The length of the text is determined with this field format.)
	 * @param	$wid (Number) The allowable range 
	 * @param	$str (String) The text to be checked
	 * @param	$terse (String) The string to be used as an ellipsis (default is "...")
	 * @param	$start (Number) A starting point to be checked
	 * @return (String) The string with an ellipsis after the check
	 */
	public static function getTerseStringByWidth($fld:TextField, $wid:Number, $str:String, $terse:String, $start:Number):String {		
		var kTerse:String  = getString($terse, "...");
		var kStart:Number = ($start == null)?15:$start;		
		var kStr:String;
		var kWid:Number;
		//-----------------
		kWid = TextFieldUtil.getFldWid($fld, $str);
		if (kWid <= $wid) return $str;
		//-------------------
		var kLen:Number = $str.length;
		for (var i:Number = kStart; i < kLen; i++) {
			kStr = $str.substr(0, i) + kTerse;		
			
			kWid = TextFieldUtil.getFldWid($fld, kStr);	
			
			if (kWid >= $wid) return kStr;
		}		
		return $str;
		
	}
	
	/**
	 * Returns the string with an ellipsis if the string exceeds the maximum number of characters allowed.
	 * 
	 * @param	$str (String) The text to be checked
	 * @param	$max (Number) The maximum number of characters allowed
	 * @param	$terseStr (String) The string to be used as an ellipsis (default is "...")
	 * @return (String) The string with an ellipsis after the check
	 */
	public static function getTerseStringByLength($str:String, $max:Number, $terseStr:String):String {
		
		if ($str == null) {
			return "";
		}
		
		if ($str.length<=$max) {
			return $str;
		} else {
			var kStr:String = $str.substring(0, $max - 2);
			var kTerseStr:String = getString($terseStr, "..");			
			return kStr + kTerseStr;
		}
	}
	
	/**
	 * Returns the year, month and day in a specific format.
	 * Available formats are: "mdy" (FORMAT_DATE_MDY, Jan 1,2002) and "y.m.d" (FORMAT_DATE_DOTTED_YMD, 2002.01.01).
	 * 
	 * @param	$y (Number) Year
	 * @param	$m (Number) Month
	 * @param	$d (Number) Day
	 * @param	$format (String) The format to be used 
	 * @return (String) The converted year, month and day 
	 */
	public static function getFormattedDate($y:Number, $m:Number, $d:Number, $format:String):String {		
		
		var kStr:String = "";
		
		if($format==FORMAT_DATE_MDY){
			var kLst:Array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];			
			kStr += kLst[Number($m) - 1];			
			kStr+=" "+$d + ", " + $y;
		}else{
			//else if ($format == FORMAT_DATE_DOTTED_YMD) {
			kStr = $y + "." + getFormattedDigit($m,"00") + "." + getFormattedDigit($d,"00");
		}
		
		return kStr;
	}
	
	/**
	 * Returns the day of week in a specific format.
	 * Available formats are: "UUU" (FORMAT_DAY_UUU, 'MON'), "k" (FORMAT_DAY_K, '월') and "ull"(FORMAT_DAY_ULL, 'Mon').
	 * @param	$dayIdx (Number) The day of week index. Sunday is 0 and Saturday is 6. 
	 * @param	$format (String) The format to be used 
	 * @return (String) The converted day of week
	 */
	public static function getFormattedDay($dayIdx:Number, $format:String):String {		
		var kStr:String = "";
		var kLst:Array;
		if ($format == FORMAT_DAY_UUU) {
			kLst = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];			
		}else if ($format == FORMAT_DAY_K) {
			kLst = ["일", "월", "화", "수", "목", "금", "토"];			
		}else {
			//FORMAT_DAY_ULL "ull"
			kLst = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];			
		}		
		return kLst[$dayIdx];
	}
	
	
	
	/**
	 * Returns the default value if the data is null; the string if the data contains a string.
	 * Sometimes, it is necessary to read the data from a specific site and display it in the specified text field,
	 * If the data contains a string, it can be displayed directly in the text field;
	 * if the data is null, a custom text (e.g. "No Data") needs to be displayed instead.
	 * This method is useful for such case. (fld.text = StringUtil.getString (serverData,"No Data"))
	 * 
	 * @param	$data (Object) The data to be checked
	 * @param	$default (String) The value to be returned if the data is null
	 * @return (String) 
	 */
	public static function getString($data:Object, $default:String):String {
		if ($data == null) {
			return $default;
		}
		return String($data);
	}
	//to be deprecated
	//public static function getStr($data:Object, $default:String):String {
		//return getString($data,$default);
	//}
	
	
	/**	 
	 * Sometimes, numbers such as 1, 2, 12 need to be formatted and displayed in two digits, such as 01, 02, 12.
	 * This method allows to convert numbers into the desired format.
	 * 
	 * @param	$num (Number) The target number
	 * @param	$format (String) The format to be used To convert a number into a two-digit format, set to "00"; into three-digit format, set to "000". (default is "00")
	 * @return (String) The string formatted 
	 */
	public static function getFormattedDigit($num:Number, $format:String):String {		
		var kNumStr:String = $num.toString();
		
		$format = getString($format, "00");
		
		var kNumStrLen:Number = kNumStr.length;
		var kFormatLen:Number = $format.length;
		if(kNumStrLen>=kFormatLen){
			return kNumStr;
		}
		
		var kDis:Number = kFormatLen-kNumStrLen;
		var kStr:String = "";
		for (var i:Number = 0; i < kDis; i++) {			
			kStr += "0";			
		}
		return kStr+kNumStr;
		
	}
	
	
	
}