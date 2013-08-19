
/**
 * Helps handle a boolean value which is an intrinsic class of the Flash Player
 * and a primitive type.
 */
class lge.utils.BooleanUtil {

	/**
	 * Converts a value to boolean and returns it.
	 * 
	 * @param	$data (Object) The data to be converted
	 * @param	$default (Boolean) The value to be returned if $data is null 
	 * @return (Boolean) The converted boolean value 
	 */
	public static function getBool($data:Object, $default:Boolean):Boolean {
		if ($data == null) {
			return $default;
		} else if ($data == "false") {
			return false;
		} else if ($data == "true") {
			return true;
		}
		return Boolean($data);
	}
	
}