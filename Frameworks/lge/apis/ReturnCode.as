/**
 * Return code.
 */
class lge.apis.ReturnCode
{
	/** Successfully executed.	*/
	public static var OK:Number = 0;
	/** The given request is completely processed.*/
	public static var HANDLED:Number = 0;
	/** An error occurred while processing the function.	*/
	public static var ERROR:Number = - 1;
	/** The given request is not processed completely. */
	public static var NOT_HANDLED:Number = - 1;
	/** Other application is using HOA exclusively; failed to execute the function. */
	public static var BLOCKED:Number = - 2;
	/** The function parameter has an invalid value. */
	public static var INVALID_PARAMS:Number = - 3;
	/** The memory is not enough to execute the function. */
	public static var NOT_ENOUGH_MEMORY:Number = - 4;
	/** No response is received within the specified time since the execution request of the function.*/
	public static var TIMEOUT:Number = - 5;
	/** The function is not supported due to the version incompatibility.*/
	public static var NOT_SUPPORTED:Number = - 6;
	/** Failed to execute the function because the buffer is filled up with data.  */
	public static var BUFFER_FULL:Number = - 7;
	/** Failed to execute the function because the host is not connected.	 */
	public static var HOST_NOT_CONNECTED:Number = - 8;
	/** Failed to execute the function because of the version incompatibility between the application and the library. */
	public static var VERSION_MISMATCH:Number = - 9;
	/** The application is already registered into the manager. */
	public static var ALREADY_REGISTERED:Number = - 10;
	/** Last */
	public static var LAST:Number = - 11;
}