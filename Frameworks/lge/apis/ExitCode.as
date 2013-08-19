/**
 * Exit code
 */
class lge.apis.ExitCode
{
	/**When closed, restore to default TV state	*/
	public static var BAD_CRASH:Number = -1;
	/** Basic close*/
	public static var NORMAL:Number = 0;
	/** When closed, go back to Application Browser */
	public static var BACK_TO_BROWSER:Number = 1;
	/** RESERVED1 */
	public static var RESERVED1:Number = 2;
	/** RESERVED2 */
	public static var RESERVED2:Number = 3;
	/** RESERVED3 */
	public static var RESERVED3:Number = 4;
	/** RESERVED4 */
	public static var RESERVED4:Number= 5;
	/** Only for PremiumCP(cinemanow, plex... ). Do not using other application. */
	public static var BACK_TO_SETUP:Number = 6;
	/** When closed, go back to DashBoard*/
	public static var BACK_TO_DASHBOARD = 7;	
	/** RESERVED6 */
	public static var RESERVED6 = 8;
	/** RESERVED7 */
	public static var RESERVED7 = 9;
	/** RESERVED8 */
	public static var RESERVED8 = 10;
	/** When closed, go back to network setting. */
	public static var BACK_TO_NETWORKSETTING = 11;
	/** RESERVED9 */
	public static var RESERVED9 = 21;
}