
/**
 * Helps handle an array which is an intrinsic class
 * of the Flash Player.
 */
class lge.utils.ArrayUtil {
	
	/**
	 * If the data type of an item in the array is Object, the values stored in the given objects are converted and returned as an array.
	 * 
	 * @param	$arr (Array) An array storing the data 
	 * @param	$attr (String) The property of an item in the array 
	 * @return (Array) Returns an array storing the specific property of an item stored in the array.
	 * 
	 * {@code	
	 * 
	 * var arr:Array = new Array();
	 * arr.push({index:0});
	 * arr.push({index:1});
	 * arr.push({index:2});
	 * arr.push({index:3});
	 * 
	 * var indexArr:Array = ArrayUtil.getValueArrayWithAttr(arr,"index");
	 * //-- The indexArray is as follows: [0,1,2,3]
	 * 
	 * }
	 */
	public static function getValueArrayWithAttr($arr:Array, $attr:String):Array {		
		var kLst:Array = new Array();
		var kLen:Number = $arr.length;
		var kOne:Object;
		for (var i:Number = 0; i < kLen; i++) {			
			kOne = $arr[i];
			kLst.push(kOne[$attr]);
		}
		return kLst;
	}

	/**
	 * In an array storing object type data,
	 * if the value of the specific property of an item is identical to the given value, the item is deleted from the array.
	 * 
	 * @param	$arr (Array) An array storing the data
	 * @param	$attr (String) The property of an item in the array
	 * @param	$value (Object) The value of the specific property of an item If the value of the specific property of an item in the array is identical to this value, the item is deleted.
	 * 
	 * {@code	
	 * 
	 * var arr:Array = new Array();
	 * arr.push({index:0});
	 * arr.push({index:1});
	 * arr.push({index:2}); //-- Item to be deleted 
	 * arr.push({index:3});
	 * 
	 * ArrayUtil.deleteOneWithAttr(arr, "index", 2);
	 * 
	 * }
	 */
	public static function deleteOneWithAttr($arr:Array, $attr:String, $value:Object):Void {		
		var kAt:Number = getAtWithAttr($arr, $attr, $value);		
		if (kAt != null) {			
			$arr.splice(kAt, 1);			
		}
	}	
	
	/**
	 * If the value of an item in the array is identical to the specific value, the item is deleted from the array.
	 * 
	 * @param	$arr (Array) The array to be checked
	 * @param	$value (Object) The specific value If the value of an item in the array is identical to this value, the item is deleted.
	 * 
	 * {@code	
	 * 
	 * var arr:Array = [10,11,21,31,14]; 
	 * 
	 * ArrayUtil.deleteOne(arr, 21);
	 * //-- The arr is as follows: [10,11,31,14]
	 * 
	 * }
	 */
	public static function deleteOne($arr:Array, $value:Object):Void {
		var kAt:Number = getAt($arr, $value);		
		if (kAt != null && kAt != -1) {			
			$arr.splice(kAt, 1);			
		}
	}	
	
	/**
	 * Returns the position of the specific value in the array. If the value does not exist in the array, the default value passed as a parameter will be sent.
	 * 
	 * @param	$arr (Array) The array to be checked
	 * @param	$one (Object) The value to be compared 
	 * @param	$default (Number) If no item in the array has the corresponding value, it returns this value.
	 * @return (Number) The (zero-based) position of an item in the array which value corresponds to $one
	 * 
	 * {@code	
	 * 
	 * var arr:Array = [10,11,21,31,14]; 
	 * 
	 * var kAt:Number = ArrayUtil.getAt(arr, 21);
	 * //-- 2 is assigned to kAt. 
	 * kAt = ArrayUtil.getAt(arr,50,-1);
	 * //-- -1 is saved to kAt. 
	 * 
	 * }
	 */
	public static function getAt($arr:Array, $one:Object, $default:Number):Number {		
		for (var i:Number = 0; i<$arr.length; i++) {
			if ($arr[i] == $one) {
				return i;
			}
		}
		return $default;
	}
	
	/**
	 * Among the object type items in the array, if the value of the specific property matches the specific value, the position of the corresponding item is returned.
	 * 
	 * @param	$arr (Array) The array to be checked
	 * @param	$attr (String) The property of an item 
	 * @param	$value (Object) The value of the property to be compared
	 * @param	$default (Number) The value to be returned if no item in the array satisfies the condition 
	 * @return	(Number) The (zero-based) position of an item in the array which value corresponds to the given item's $attr property
	 * 
	 * {@code	
	 * 
	 * var arr:Array = new Array();
	 * arr.push({name:"snsd"});
	 * arr.push({name:"after school"});
	 * arr.push({name:"t-ara"}); //-- Items to be deleted 
	 * arr.push({name:"2ne1"});
	 * 
	 * var kAt:Number = ArrayUtil.getAtWithAttr(arr, "name", "after school");
	 * //-- The value of kAt is 1.
	 * }
	 */
	public static function getAtWithAttr($arr:Array, $attr:String, $value:Object, $default:Number):Number {
		var kItem:Object;
		for (var i:Number = 0; i < $arr.length; i++) {			
			kItem = $arr[i];
			if (kItem[$attr] == $value) {				
				return i;
			}
		}
		return $default;
	}
	
	/**
	 * Among the object type items in the array, if the value of the specific property matches the specific value, the corresponding item is returned.
	 * 
	 * @param	$arr (Array) The array to be checked
	 * @param	$attr (String) The property of an item
	 * @param	$value (Object) The value of the property to be compared
	 * @return (Object) If the $attr property of an item in the array matches the $value value, the corresponding item is returned.
	 * {@code	
	 * 
	 * var arr:Array = new Array();
	 * arr.push({name:"snsd",index:0});
	 * arr.push({name:"after school",index:1});
	 * arr.push({name:"t-ara", index:2}); //-- Items to be deleted 
	 * arr.push({name:"2ne1", index:3});
	 * 
	 * var kOne:Object = ArrayUtil.getOneWithAttr(arr, "name", "t-ara");
	 * trace(kOne.index)//-- Outputs 2.
	 * }
	 */

	public static function getOneWithAttr($arr:Array, $attr:String, $value:Object):Object {
		
		var kAt:Number = getAtWithAttr($arr, $attr, $value);
		if (kAt != null) {
			return $arr[kAt];
		}
		return null;
	}
	
	/**
		 * Insert an item into the array
		 * @param	$arr (Array) The array
		 * @param	$idx (Number) The inndex
		 * @param	$item (Object) The item
		 */
	public static function insertItemAt($arr:Array, $idx:Number, $item:Object):Void {
		$arr.splice($idx, 0, $item);
	}
	
	/**
		 * Change the item index
		 * @param	$arr (Array) The array to be changed
		 * @param	$fromIdx (Number) The index from which the item to be moved
		 * @param	$toIdx (Number) The index to which the item to be moved
		 */
	public static function changePosition($arr:Array, $fromIdx:Number, $toIdx:Number):Void {
		var kItem:Object = $arr[$fromIdx];
		$arr.splice($fromIdx, 1);
		insertItemAt($arr, $toIdx, kItem);
	}
	
	
}