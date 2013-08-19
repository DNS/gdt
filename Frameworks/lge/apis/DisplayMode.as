/**
 * Display mode
 */
class lge.apis.DisplayMode
{
	/** No UI exists	*/
	public static var NONE:Number = 0;
	
	/** UI elements overlap with the image on the TV screen.	*/
	public static var UIWITHTV:Number = 1;
	
	/** UI elements are displayed in full screen mode covering the image on the TV screen (UI transition is slow,but it enables a quick start when playing a media file.)*/
	public static var FULLUI:Number = 2;
	
	/**When playing a video in full screen mode */
	public static var FULLVIDEO:Number = 3;
	
	/** When playing an image in full screen mode */
	public static var FULLIMAGE:Number = 4;
	
	/** UI elements are displayed in full screen mode covering the image on the TV screen (UI transition is fast,but it prevents a quick start when playinga media file.)*/
	public static var FULLUIFAST:Number = 5;
	
	/** RESERVED */
	public static var RESERVED1:Number = 6;
	
	/** RESERVED */
	public static var RESERVED2:Number = 7;
	
	/** RESERVED */
	public static var RESERVED3:Number = 8;
	
	/** RESERVED */
	public static var RESERVED4:Number = 9;
	
	/** RESERVED */
	public static var RESERVED5:Number = 10;
	
	/** RESERVED */
	public static var RESERVED6:Number = 11;
	
	/** RESERVED */
	public static var RESERVED7:Number = 12;
	
	/** RESERVED */
	public static var RESERVED8:Number = 13;
	
	/** Maximum display mode number	*/
	public static var NUM:Number = 14;
}