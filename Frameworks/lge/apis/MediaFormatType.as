/**
 * File format of media.
 */
class lge.apis.MediaFormatType
{
	/** Raw data encoded in audio/video codec with no file format specified*/
	public static var RAW:Number = 0x00;
	/** wave file format (Audio). */
	public static var WAV:Number = 0x01;
	/** mp3 file format (Audio). */
	public static var MP3:Number = 0x02;
	/** aac file format (Audio). */
	public static var AAC:Number = 0x03;
	/** avi file format (Video). */
	public static var AVI:Number = (0x01 << 8);
	/** mpeg4 file	format (Video).	*/
	public static var MP4:Number = (0x02 << 8);
	/** mpeg1 file	format (Video).	*/
	public static var MPEG1:Number = (0x03 << 8);
	/** mpeg2 file	format (Video).	*/
	public static var MPEG2:Number = (0x04 << 8);
	/** asf file format (Video). */
	public static var ASF:Number = (0x05 << 8);
	/** mkv file format (Video). */
	public static var MKV:Number = (0x06 << 8);
	/** RESERVED */
	public static var RESERVED1:Number = (0x08 << 16);
	/** RESERVED */
	public static var RESERVED2:Number = (0x09 << 16);
	/** RESERVED */
	public static var RESERVED3:Number = (0x0A << 16);
	/** Audio file	format mask	*/
	public static var AUDIO_MASK:Number = 0xFF;
	/** Video file	format mask	*/
	public static var VIDEO_MASK:Number = (0xFF << 8);
	/** RESERVED */
	public static var RESERVED4:Number = (0xFF << 16);
}