/**
 * Aspect ratio
 */
class lge.apis.AspectRatio
{
	/** For 16X9 monitor : full screen<br>
	 *  For 4X3 monitor : Letter box */
	public static var ARC16X9:Number = 0;

	/** Just Scan turns off cropping (re-blanking) and shows the complete video. */
	public static var JUSTSCAN:Number = 1;

	/** The Set By Program displays the original aspect ratio (e.g. 4X3 signal into a 4X3 display;16X9 signal into 16X9).*/
	public static var SET_BY_PROGRAM:Number = 2;

    /** For 16X9 monitor : 4X3 with black bars on both sides (pillar box)
	 * For 4X3 monitor : full screen */
	public static var ARC4X3:Number = 3;

	/** Always displays in full screen mode regardless of monitor and source types */
	public static var FULL:Number = 4;

    /** For 16X9 monitor : zooms vertically<br>
	 *  For 4X3 monitor : Ignored */
	public static var ZOOM:Number = 5;	
	/** Maximum aspect ratio number	*/
	public static var NUMBER:Number = 6;
}