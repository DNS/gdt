import lge.utils.XmlToObject;
import flash.external.ExternalInterface;

/**************************************************************************************
* This module supports both streaming and downloaded media and offers related 
* functionalities including playback, pause, resume, and stop. 
* Also, it supports the seek functionality for the downloaded media
**************************************************************************************/
class lge.apis.Media{
	/**
	 * Starts a channel and prepares the channel to play with the given transfer type, format type, and codec type.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 * @param mediaTransportType [in] Transport type of media file.(lge.apis.MediaTransportType)
	 * @param mediaFormatType	[in] A media file format (lge.apis.MediaFormatType)
	 *
	 * @return Returns ReturnCode = OK if playback is ready; ReturnCode = INVALID_PARAMS if the parameter is not valid; otherwise ERROR.
	 */
	public function openChannel(ch:Number, mediaTransportType:Number, mediaFormatType:Number):Number {
		ExternalInterface.call("__FOA__Media__openChannel", ch, mediaTransportType, mediaFormatType);		
		return _root.EI_retCode;
	}

	/**
	 * Ends the channel.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return Returns ReturnCode = OK if the channel is successfully ended; ReturnCode = INVALID_PARAMS if the parameter is not valid; otherwise ERROR.
	 */
	public function closeChannel(ch:Number):Number {
		ExternalInterface.call("__FOA__Media__closeChannel", ch);		
		return _root.EI_retCode;
	}
	
	/**
	 * This function plays the clip. When the mediaFormatType that you set when you open a channel is Video or Image, display position is playOption. 
	 * (If it is NULL, full screen display is set.)
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 * @param filename [in] An address for File path, URL, etc
	 * @param repeatNumber [in]	Repeated play numbers. 0 = repeat endlessly
	 * @param playOption [in] Starting time, Cache use or not, Display position. All properties are optional. Only the necessary property is added and delivered.<br>
	 *							playOption.x: Number 	- x position<br>
	 *							playOption.y: Number 	- y position<br>
	 *							playOption.width: Number	- width<br>
	 *							playOption.height: Number	- height<br>
	 *
	 * @return Returns ReturnCode = OK if the clip is successfully played; otherwise ERROR.
	 */
	public function playClipFile(ch:Number, filename:String, repeatNumber:Number, playOption:Object): Number {
		ExternalInterface.call("__FOA__Media__playClipFile", ch, filename, repeatNumber, playOption.x,playOption.y,playOption.width,playOption.height,playOption.startPositionMs,playOption.bCacheOff);		
		return _root.EI_retCode;
	}

	/**
	 * Pauses the clip, which is being played.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return	Returns ReturnCode = OK if the clip is successfully paused; otherwise ERROR.
	 */
	public function pauseClip(ch:Number): Number {
		ExternalInterface.call("__FOA__Media__pauseClip", ch);		
		return _root.EI_retCode;
	}

	/**
	 * Resumes the paused clip.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return	Returns ReturnCode = OK if the clip is successfully resumed; otherwise ERROR.
	 */
	public function resumeClip(ch:Number): Number {
		ExternalInterface.call("__FOA__Media__resumeClip", ch);		
		return _root.EI_retCode;
	}

	/**
	 * Seeks the clip; changes the starting point of the clip which is being played to another point.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 * @param playPositionMs [in] A starting point to play (in milliseconds)
	 *
	 * @return Returns ReturnCode = OK if the clip is successfully sought; ReturnCode = INVALID_PARAMS if the parameter is not valid; otherwise ERROR.
	 */
	public function seekClip(ch:Number, playPositionMs:Number): Number {
		ExternalInterface.call("__FOA__Media__seekClip", ch, playPositionMs);		
		return _root.EI_retCode;
	}

	/**
	 * Stops the clip, which is being played or paused.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return	Returns ReturnCode = OK if the clip is successfully stopped; otherwise ERROR.
	 */
	public function stopClip(ch:Number): Number {
		ExternalInterface.call("__FOA__Media__stopClip", ch);		
		return _root.EI_retCode;
	}
	
	/**
	 * Gets the media play information, such as playback state and playback time of the media. 
	 * Playback state includes play, stop, and pause, and the playback time is returned in milliseconds.
	 * 
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return	retObject.retCode:Number	- Returns ReturnCode = OK if successful; ReturnCode = INVALID_PARAMS if the parameter is not valid; otherwise ERROR.<br>
	 *			retObject.playState: Number		- Media	play state (lge.apis.MediaPlayState)<br>
	 *			retObject.elapsedMS: Number		- Elapsed time in millisecond<br>
	 *			retObject.durationMS: Number	- Total	duration in	millisecond<br>
	 *			retObject.bufBeginSec: Number	- The beginning of the buffered stream.(Valid only for MediaTransportType.DLNA,MediaTransportType.YOUTUBE,MediaTransportType.YAHOO)<br>
	 *			retObject.bufEndSec: Number		- The end of the buffered stream.(Valid only for MediaTransportType.DLNA,MediaTransportType.YOUTUBE,MediaTransportType.YAHOO)<br>
	 *			retObject.bufRemainSec:	Number	- The rest of the buffered stream.(Valid only for MediaTransportType.DLNA,MediaTransportType.YOUTUBE,MediaTransportType.YAHOO)<br>
	 *			retObject.instantBps: Number	- Current streaming speed (Valid only for MediaTransportType.DLNA,MediaTransportType.YOUTUBE,MediaTransportType.YAHOO)<br>
	 *			retObject.totalBps:	Number		- The total streaming speed (Valid only for MediaTransportType.DLNA,MediaTransportType.YOUTUBE,MediaTransportType.YAHOO)<br>
	 *			retObject.lastCBMsg: Number		- The latest callback message
	 */
	public function getPlayInfo(ch:Number):Object {
		ExternalInterface.call("__FOA__Media__getPlayInfo", ch);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Gets the media information, which is being played.
	 *
	 * @param ch [in] A channel number (lge.apis.MediaChannel)
	 *
	 * @return	retObject.retCode:Number	- ReturnCode = OK if audio/video is successfully blocked; ReturnCode = INVALID_PARAMS if the parameter is not valid; otherwise ERROR.<br>
	 *			retObject.title: String				- Title	of source<br>
	 *			retObject.date:	Date				- Creation date	of source<br>
	 *			retObject.dataSize:	Number			- Total	length of source<br>
	 *			retObject.format: Number			- Media	format (container type)	of source (lge.apis.MediaFormatType)<br>
	 *			retObject.codec: Number				- Media	Codec of source (The O-Ringed value for lge.apis.MediaCodecAudio and lge.apis.MediaCodecVideo and lge.apis.MediaCodecImage).<br>
	 *			retObject.width: Number				- Width	of source. (Not	valid when audio only)<br>
	 *			retObject.height: Number			- Height of	source.	(Not valid when	audio only)<br>
	 *			retObject.durationMS: Number		- Total	duration in	millisecond<br>
	 *			retObject.targetBitrateBps:	Number	- Needed average bitrate in	bps	(bits per second)<br>
	 *			retObject.bIsValidDuration:	Boolean	- Whether or not durationMS is valid (FALSE if no duration exists. For example, live.)<br>
	 *			retObject.bIsSeekable: Boolean		- Whether seekClip is available (TRUE) or not<br>
	 *			retObject.bIsScannable:	Boolean		- Whether setPlaySpeed is available (TRUE) or not<br>
	 */
	public function getSourceInfo(ch:Number):Object {
		ExternalInterface.call("__FOA__Media__getSourceInfo", ch);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Gets the absolute path of current running file.
	 *	 
	 * @return	retObject.retCode:Number	    - ReturnCode = OK if absolute path is successfully obtained; otherwise ERROR.<br>
	 *			retObject.basePath:String		    - Absolute path of current running file.<br>
	 */
	public function getPlayClipFileBasePath():Object {
		ExternalInterface.call("__FOA__Media__getPlayClipFileBasePath");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
}