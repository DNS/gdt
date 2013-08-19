
/**
 * The top class of the FFC2.0 classes. 
 * Although it is not a dynamic class, it provides the method and event to read and store various types of data.
 * 
 * {@code
 * //The following creates an LGObject object and reads/stores the data.
 * 
 * var lgo:LGObject = new LGObject();
 * lgo.putString("name", "John"); // Stores the value "John" in the "name" string property.
 * var myName:String = lgo.getString("name");
 * trace("My name is "+myName) 
 * //"My name is John" is outputted.
 * }
 */

class lge.apps.LGObject {
	
	/**
	 * Nullifies the reference for reference type of variables declared within the object.	
	 */
	public function dealloc():Void {	
		bundle = null;
	}
	
	private var className:String = "LGObject";		
	
	private var bundle:Object;
	
	/**
	 * Stores the specified string in the property with the name passed as a parameter.
	 * 
	 * @param	$prop (String) The name of the property in which to store a string 
	 * @param	$data (String) The string to be stored 
	 */
	public function putString($prop:String, $data:String):Void {	
		var kBundle:Object = getBundle();
		kBundle[$prop] = $data;
		
	}	
	
	/**
	 * Returns the string stored in the property with the name passed as a parameter. 
	 * 
	 * @param	$prop (String) The name of the property where the string is stored 
	 * @return 	(String) The string stored 
	 */
	public function getString($prop:String):String {
		return bundle[$prop];
	}	
	
	/**
	 * Stores the specified number in the property with the name passed as a parameter.
	 * 
	 * @param	$prop (String) The name of the property in which to store a number
	 * @param	$data (Number) The number to be stored
	 */
	public function putNumber($prop:String, $data:Number):Void {	
		var kBundle:Object = getBundle();
		kBundle[$prop] = $data;
	}	
	
	/**
	 * Returns the number stored in the property with the name passed as a parameter.
	 * 
	 * @param	$prop (String) The name of the property where the number is stored 
	 * @return	(Number) The number stored 
	 */
	public function getNumber($prop:String):Number {
		return bundle[$prop];
	}
	
	/**
	 * Stores the specified array in the property with the name passed as a parameter.
	 * 
	 * @param	$prop (String) The name of the property in which to store an array 
	 * @param	$data (Array) The array to be stored 
	 */
	public function putArray($prop:String, $data:Array):Void {	
		var kBundle:Object = getBundle();
		kBundle[$prop] = $data;
	}	
	
	/**
	 * Returns the array stored in the property with the name passed as a parameter.
	 * 
	 * @param	$prop (String) The name of the property where the array is stored 
	 * @return	(Array) The array stored 
	 */
	public function getArray($prop:String):Array {
		return bundle[$prop];
	}	
	
	/**
	 * Returns the name of the specified class. 
	 * This class name is not created automatically.
	 * If the className variable in the variable declaration is defined, the class name is returned.
	 * 
	 * @return	(String) The name of the class 
	 */
	public function getClassName():String {
		return className;
	}	
	
	/**
	 * Defines the className property. 
	 * 
	 * @param	$name (String)
	 */
	public function setClassName($name:String):Void {
		className = $name;
	}
	
	private function getBundle():Object {
		if (bundle == null) {
			bundle = new Object();
		}
		return bundle;
	}
	
}
