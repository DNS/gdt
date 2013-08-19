/**
 * Network status
 */
class lge.apis.NetworkStatus
{
	/** Ethernet cable is disconnected */
	public static var LINK_DISCONNECTED:Number = 0;
	/**Ethernet cable is connected */
	public static var LINK_CONNECTED:Number = 1;
	/** Ethernet cable is connected, but a ping on the given address failed. */
	public static var DISCONNECTED:Number = 2;
	/**Ethernet cable is connected and the Internet is working. Or a ping on the given address is successful.*/
	public static var CONNECTED:Number = 3;
	/**Trying to connect the network.*/
	public static var TRY_TO_CONNECT:Number = 4;
}