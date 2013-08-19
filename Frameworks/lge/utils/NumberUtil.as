/**
 * Helps handle a number which is an intrinsic class
 * of the Flash Player.
 */
class lge.utils.NumberUtil {
	/**
	 * Reads a specific value within the minimum and maximum range and returns a valid number.
	 * If the value is smaller than the minimum, it returns either the minimum or the maximum value depending on the $isLooping parameter.
	 * If the value is larger than the maximum value, it returns either the minimum or the maximum value.
	 * 
	 * @param	$num (Number) The target number
	 * @param	$min (Number) The minimum value
	 * @param	$max (Number) The maximum value
	 * @param	$isLooping (Boolean) Whether to use the minimum and the maximum values repetitively. For example, if it is true, the value smaller than the minimum 
	 * is set to the maximum, and if it is false, the value is set to the minimum. Likewise, if it is true, the value larger than the maximum is set to the minimum.
	 * @return (Number) The valid number within the range
	 */
	public static function getNumberInScope($num:Number, $min:Number, $max:Number, $isLooping:Boolean):Number {
		
		if (isNaN($num)) {
			return $min;
		}	
		
		if ($num < $min) {
			if ($isLooping) {
				return $max;
			}
			return $min;
		}else if ($num > $max) {
			if ($isLooping) {
				return $min;
			}
			return $max;
		}		
		return $num;
	}
	/**
	 * Checks whether the data is a number and if so,
	 * converts it to an integer value.
	 * 
	 * @param	$data (Object) The target data
	 * @param	$default (Number) The value to be returned if $data is null or there is no number
	 * @return (Number) The value of $data converted into an integer 
	 */
	public static function getIntNumber($data:Object, $default:Number):Number {
		if (isNaN($data)) {
			return Math.round($default);
		}
		return Math.round(Number($data));
	}
		
	/**
	 * Checks whether the data is a number and if so,
	 * converts it to a number value.
	 * 
	 * @param	$data (Object) The data to check
	 * @param	$default (Number) The value to be returned if $data is null or there is no number
	 * @return (Number) The value of $data converted into a number
	 */
	public static function getNumber($data:Object, $default:Number):Number {
		if (isNaN($data)) {
			return $default;
		}
		return Number($data);
	}	
	
	/**
	 * Returns the distance between two points calculated with their X coordinates and Y coordinates.
	 * 
	 * @param	$disX (Number) Distance between the X coordinates of the two points
	 * @param	$disY (Number) Distance between the Y coordinates of the two points
	 * @return (Number) The distance between the two points
	 */
	public static function getDistanceWithXYDistance($disX:Number, $disY:Number):Number {
		$disX = getNumber($disX, 0);
		$disY = getNumber($disY, 0);
		return int(Math.sqrt($disX * $disX + $disY * $disY));
	}
	/**
	 * Returns the distance between two points calculated with their coordinates.
	 * 
	 * @param	$x1 (Number) The X coordinate of the first point
	 * @param	$y1 (Number) The Y coordinate of the first point
	 * @param	$x2 (Number) The X coordinate of the second point
	 * @param	$y2 (Number) The Y coordinate of the second point
	 * @return (Number) The distance between the two points 
	 */
	public static function getDistanceWithPoints($x1:Number, $y1:Number, $x2:Number, $y2:Number):Number {
		var kDisX:Number = $x1 - $x2;
		var kDisY:Number = $y1 - $y2;
		return getDistanceWithXYDistance(kDisX, kDisY);
	}
	
	/**
	 * Calculates the aspect ratio of an image to fit
	 * the specified range without ratio distortion,  
	 * relative to its original size ratio (100).
	 * For example, to resize a 100x200 MovieClip to fit the 100X100 background,
	 * the ratio must be decreased to 50% (50x100) so that the MovieClip is displayed in the background without distortion.
	 * Whether to allow a ratio over 100% (extend) can be also set.
	 * 
	 * @param	$wid (Number) The original width of the image or MovieClip
	 * @param	$hei (Number) The original height of the image or MovieClip
	 * @param	$baseWid (Number) The new width of the image or MovieClip 
	 * @param	$baseHei (Number) The new height of the image or MovieClip 
	 * @param	$canExtend (Boolean) Whether to allow a ratio over 100%, 
	 * i.e. whether to extend the image or MovieClip. If it is set to false, the maximum value is set to 100.
	 * @return  (Number) The ratio to fit the specific area 
	 */
	public static function getScaleToFit($wid:Number, $hei:Number, $baseWid:Number, $baseHei:Number, $canExtend:Boolean):Number {
		
		var kScale:Number = 100;
		var kXRatio:Number = $wid/$baseWid;
		var kYRatio:Number = $hei/$baseHei;
		
		if ($canExtend) {
			
			kScale = 100/Math.max(kXRatio, kYRatio);
			
		}else {
			if (kXRatio > 1 || kYRatio > 1) {
				kScale = 100/Math.max(kXRatio, kYRatio);				
			}
		}		
		return kScale;
	}
}



