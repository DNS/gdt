/**
 * Channel attribute
 */
class lge.apis.ChAttrib
{
	/** Includes the blocked channel property */
	public static var INCLUDE_BLOCK:Number	= 0x00000100;
	/** Excludes the blocked channel property */
	public static var EXCLUDE_BLOCK:Number	= 0x00000200;
	/** Includes skipped and hidden channel properties */
	public static var INCLUDE_SKIPHIDDEN:Number	= 0x00000400;
	/** Excludes skipped and hidden channel properties */
	public static var EXCLUDE_SKIPHIDDEN:Number	= 0x00000800;
	/** Includes the scrambled channel property */
	public static var INCLUDE_SCRAMBLE:Number	= 0x00004000;
	/** Excludes the scrambled channel property */
	public static var EXCLUDE_SCRAMBLE:Number	= 0x00008000;
	/** Includes the hidden channel property */
	public static var INCLUDE_INVISIBLE:Number	= 0x00010000;
	/** Excludes the hidden channel property */
	public static var EXCLUDE_INVISIBLE:Number	= 0x00020000;
	/** Includes the inactive channel property */
	public static var INCLUDE_INACTIVENumber	= 0x00040000;
	/** Excludes the inactive channel property */
	public static var EXCLUDE_INACTIVE:Number	= 0x00080000;
	/** TV property */
	public static var TV_ONLY:Number	= 0x01000000;
	/** Radio property */
	public static var RADIO_ONLY:Number	= 0x02000000;
	/** The property of the main channel */
	public static var MAIN_CH:Number	= 0x10000000;
	/** The property of the sub channel */
	public static var SUB_CH:Number	= 0x20000000;
	/** The property of the unused channel */
	public static var UNUSED_CH:Number	= 0x40000000;
}