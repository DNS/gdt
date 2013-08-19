import lge.utils.XmlToObject;
import flash.external.ExternalInterface;

/**************************************************************************************
* Uses the functionalities of a legacy application in the system and is used to implement TV 
* middleware. This module provides APIs to support general TV functionalities including 
* channel switching, volume adjusting, and program information import.
**************************************************************************************/
class lge.apis.Control{
	/**
	 * Adjusts the TV volume. Both relative (+1, -1...) and absolute (0 - 100) values can be used to adjust the volume.
	 *
	 * @param	bShowVolumebar	[in] TRUE if the DTV UI volume bar is displayed for the changed volume; otherwise FALSE.
	 * @param	appType			[in] lge.apis.AppType. Adjusts the volume of the TV if AppType.HOST; the volume of the add-on application if AppType.ADDON; the total volume if AppType.ALL.
	 * @param	bRelative		[in] TRUE if volumeIn is a relative value; FALSE if it is an absolute value.
	 * @param	volumeIn		[in] Value to adjust the volume by. TRUE if bRelative is a relative value; FALSE if is an absolute value. The volume can be adjusted within the range of 0 - 100.
	 *
	 * @return	Returns ReturnCode = OK if the volume is adjusted; otherwise ERROR.
	 */
	public function setVolume(bShowVolumebar:Boolean, appType:Number, bRelative:Boolean, volumeIn:Number):Number {
		trace("[Control.as] bShowVolumebar:"+bShowVolumebar+" appTypeL"+appType+" bRelative:"+bRelative+" volumeIn:"+volumeIn);
		ExternalInterface.call("__FOA__Control__setVolume", bShowVolumebar, appType, bRelative, volumeIn);		
		return _root.EI_retCode;
	}
	
	/**
	 * Get Volume.
	 *	Gets the current TV volume.
	 *	Both relative (+1, -1...) and absolute (0 - 100) values can be used to adjust the volume.
	 *
	 * @param	appType			[in] lge.apis.AppType. Adjusts the volume of the TV if AppType.HOST; the volume of the add-on application if AppType.ADDON; the total volume if AppType.ALL.
	 *
	 * @return	retObject.retCode:Number	- Returns ReturnCode = OK if the volume is adjusted; otherwise ERROR.<br>
	 *			retObject.volumeOut: Number - Gets the current volume (absolute value).
	 */
	public function getVolume(appType:Number):Object {
		ExternalInterface.call("__FOA__Control__getVolume", appType);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/** Mutes the TV volume.
	 *
	 * @param	bShowVolumebar	[in] TRUE if the DTV UI volume bar is displayed for the changed mute status; otherwise FALSE.
	 * @param	bMute 		[in] Mutes the current volume if TRUE; changes back to the original volume if FALSE.
	 *
	 * @return  Returns ReturnCode.OK. if the volume is muted; otherwise ERROR.
	 */
	public function setMute(bShowVolumebar:Boolean, bMute:Boolean):Number {
		ExternalInterface.call("__FOA__Control__setMute", bShowVolumebar, bMute);		
		return _root.EI_retCode;
	}

	/** Gets the mute status of the TV.
	 *
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the mute status is successfully obtained; otherwise ERROR.<br>
	 *			retObject.bMute: Boolean	- Gets the mute status.
	 */
	public function getMute():Object {
		ExternalInterface.call("__FOA__Control__getMute");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	/**
	 * Blocks
	 * the video and/or audio from playing on the TV or from the speaker.
	 *
	 * @param	bBlockAudio		[in] TRUE to block the audio; otherwise FALSE.
	 * @param	bBlockVideo		[in] TRUE to block the audio; otherwise FALSE.
	 *
	 * @return	Returns ReturnCode.OK. if the audio/video is successfully blocked; otherwise ERROR.
	 */
	public function setAVBlock(bBlockAudio:Boolean, bBlockVideo:Boolean):Number {
		ExternalInterface.call("__FOA__Control__setAVBlock", bBlockAudio, bBlockVideo);		
		return _root.EI_retCode;
	}
	
	/**
	 * Gets the current the audio/video blocking status.
	 *	Gets whether or not the video is being displayed on the screen; or whether or not the audio is being generated from the speaker.
	 *
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the audio/video blocking status is successfully obtained; otherwise ERROR.<br>
	 *			retObject.bBlockAudio: Boolean - TRUE if the audio is being blocked; otherwise FALSE.<br>
	 *			retObject.bBlockVideo: Boolean - TRUE if the video is being blocked; otherwise FALSE.<br>
	 */
	public function getAVBlock():Object {
		ExternalInterface.call("__FOA__Control__getAVBlock");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Resets the audio/video blocking.
	 * That is, it resets the audio/video blocking to the default setting used before the add-on application runs.
	 *
	 * @return	Returns ReturnCode.OK. if it is reset successfully; otherwise ERROR.
	 */
	public function resetAVBlock():Number {
		ExternalInterface.call("__FOA__Control__resetAVBlock");		
		return _root.EI_retCode;
	}
	
	/**
	 * Sets the display resolution.
	 *
	 * @param	 height		   [in] height<br>
	 *           width         [in] width<br>
	 *           osdType	   [in] OSD type. (class lge.apis.OSDType)
	 *
	 * @return	Returns ReturnCode = OK if setting display resolution is successful; otherwise ERROR.
	 */
	public function setDisplayResolution(height:Number, width:Number, osdType:Number):Number {
		ExternalInterface.call("__FOA__Control__setDisplayResolution",height, width, osdType);		
		return _root.EI_retCode;
	}

	/**
	 * Gets the display resolution. Note that the display resolution refers to the video plane resolution which is different to the UI plane resolution.
	 *
	 * @return  retObject.retCode:Number -Returns ReturnCode = OK if the display resolution is successfully obtained; otherwise ERROR.<br>
	 *			retObject.width: Number - The width of the display.<br>
	 * 			retObject.height: Number -The height of the display.<br>
	 */
	public function getDisplayResolution():Object {
		ExternalInterface.call("__FOA__Control__getDisplayResolution");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Sets the display mode. Image quality is determined by the display mode.
	 *
	 * @param	displayMode	[in] The way add-on application is displayed on the screen (lge.apis.DisplayMode)
	 *
	 * @return	Returns ReturnCode = OK if the display mode is successfully changed; otherwise ERROR.
	 */
	public function setDisplayMode(displayMode:Number):Number {
		ExternalInterface.call("__FOA__Control__setDisplayMode", displayMode);		
		return _root.EI_retCode;
	}
	
	/**
	 * Gets the display mode.
	 *	
	 * @return	retObject.retCode:Number - OK if the display mode is successfully getted; otherwise ERROR.<br>
	 * 			retObject.displayMode:Numbe - Current Addon App on a screen. (lge.apis.DisplayMode)
	 */
	public function getDisplayMode():Object {
		ExternalInterface.call("__FOA__Control__getDisplayMode");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	/**	 
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the locale information is successfully obtained; otherwise ERROR.<br>
	 *			retObject.country: String - The specified country. It is set when "localeType == COUNTRY".<br>
	 *			retObject.language:	String - The specified language. It is set when "localeType == LANGUAGE".<br>
	 *			retObject.group: Number	- The specified group (lge.apis.LocaleGroup). It is set when "localeType ==GROUP".
	 */
	public function getLocaleInfo():Object {
		ExternalInterface.call("__FOA__Control__getLocaleInfo");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * This function gets the TV system information such as the model name and hardware/software versions.
	 *
	 * @return	retObject.retCode:Number	- OK if the information is successfully obtained; otherwise ERROR.<br>
	 *			retObject.projectName: String	- Project Name<br>
	 *			retObject.modelName: String		- Model	Name<br>
	 *			retObject.hwVer: String			- Hardware Version<br>
	 *			retObject.swVer: String			- Software Version<br>
	 *			retObject.ESN: String			- ESN<br>
	 *			retObject.toolTypeName:	String	- Tool type	name<br>
	 *			retObject.serialNumber:	String	- Serial Number
	 */
	public function getSystemInfo():Object {
		ExternalInterface.call("__FOA__Control__getSystemInfo");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}	
	
	/**
	 * This function gets the event information list (EPG information) of a specific channel. 
	 * It returns the number of information and the array related with them.
	 *
	 * @param	channel			[in] Channel to get event information Value. <br>
	 *								channel.SourceType:Number	- Broadcasting Source Type (lge.apis.TVSourceType)<br>
	 *								channel.MajorNum:Number	- Major Number<br>
	 *								channel.MinorNum:Number	- Minor Number (In case of DVB, it is not used.)<br>
	 *								channel.PhysicalNum:Number	- Physical Number<br>
	 *
	 * @param	startTime		[in] Start time/period to get the event information.<br>
	 *								startTime.year:Number	- Year (1970~65535)<br>
	 *								startTime.month:Number	- Month (1~12)<br>
	 *								startTime.day:Number	- Day (1~31)<br>
	 *								startTime.hour:Number	- Hour (0~23)<br>
	 *								startTime.minute:Number	- Minute (0~59)<br>
	 *								startTime.second:Number	- Second (0~59)
	 * @param	endTime			[in] End time/period to get the event information Property to set in object is same as startTime.
	 *
	 * @return  retObject.retCode:Number	- OK if the channel list is obtained successfully; otherwise, ERROR.<br>
	 *			retObject.eventInfoNum:Number	- Number of event information<br>
	 *			retObject.eventInfoArr:Array	-Event information array (to the amount of eventInfoNum)<br>
	 *			retObject.eventInfoArr[].name:String		- Event title.<br>
	 *			retObject.eventInfoArr[].startTime:Object	- Starting time. Object property is same as the input startTime.<br>
	 *			retObject.eventInfoArr[].endTime:Object		- End time. Object property is same as the input endTime.<br>
	 *			retObject.eventInfoArr[].duration:Number	- Event period.<br>
	 *			retObject.eventInfoArr[].desc:String		- Event description.<br>
	 *			retObject.eventInfoArr[].extDesc:String		- Event extended description For name, desc and extDesc, null can be returned.
	 */
	public function getEventInfoList(channel:Object, startTime:Object, endTime:Object): Object {
		ExternalInterface.call("__FOA__Control__getEventInfoList", 
		channel.SourceType, channel.MajorNum, channel.MinorNum, channel.PhysicalNum, 
		startTime.year, startTime.month, startTime.day, startTime.hour, startTime.minute, startTime.second, 
		endTime.year, endTime.month, endTime.day, endTime.hour, endTime.minute, endTime.second);
		
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Sets the display area of the video. It uses the getDisplayResolution() function to get the resolution and
	 * sets the display area and size within the corresponding resolution. Note that the display resolution refers
	 * to the video plane resolution which is different to the UI plane resolution. Set inX, inY, inWidth, and inHeight 
	 * to "0" to set the whole input video area as a display area; set dispX, dispY, dispWidth, and dispHeight to "0" to display the video in full screen mode.
	 *
	 * @param	inX			[in] The X coordinate of the area in which the input video is displayed
	 * @param	inY			[in] The Y coordinate of the area in which the input video is displayed
	 * @param	inWidth		[in] The width of the area in which the input video is displayed
	 * @param	inHeight	[in] The height of the area in which the input video is displayed
	 * @param	dispX		[in] The X coordinate of the area to be displayed on the screen
	 * @param	dispY		[in] The Y coordinate of the area to be displayed on the screen
	 * @param	dispWidth	[in] The width of the area to be displayed on the screen
	 * @param	dispHeight	[in] The height of the area to be displayed on the screen
	 *
	 * @return  Returns ReturnCode = OK if the display area is set successfully; otherwise ERROR.
	 */
	public function setDisplayArea(inX:Number, inY:Number, inWidth:Number, inHeight:Number, dispX:Number, dispY:Number, dispWidth:Number, dispHeight:Number):Number {
		ExternalInterface.call("__FOA__Control__setDisplayArea", inX, inY, inWidth, inHeight, dispX, dispY, dispWidth, dispHeight);		
		return _root.EI_retCode;
	}

	/**
	 * Gets the area in which the video is displayed.
	 *
	 * @return  retObject.retCode:Number	- Returns ReturnCode = OK if the display area is set successfully; otherwise ERROR.<br>
	 *			retObject.inX: Number - The X coordinate of the area in which the input video is displayed<br>
	 * 			retObject.inY: Number - The Y coordinate of the area in which the input video is displayed<br>
	 * 			retObject.inWidth: Number - The width of the area in which the input video is displayed<br>
	 * 			retObject.inHeight: Number - The height of the area in which the input video is displayed<br>
	 * 			retObject.dispX: Number - The X coordinate of the area to be displayed on the screen<br>
	 * 			retObject.dispY: Number - The Y coordinate of the area to be displayed on the screen<br>
	 * 			retObject.dispWidth: Number - The width of the area to be displayed on the screen<br>
	 * 			retObject.dispHeight: Number - The height of the area to be displayed on the screen<br>
	 */
	public function getDisplayArea():Object {
		ExternalInterface.call("__FOA__Control__getDisplayArea");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Resets the display area. That is, it resets the display area to the default setting used before 
	 * the add-on application runs. Note that the display area refers to the video plane and does not apply to the UI plane.
	 *
	 * @return  Returns ReturnCode = OK if it is reset successfully; otherwise ERROR.
	 */
	public function resetDisplayArea():Number {
		ExternalInterface.call("__FOA__Control__resetDisplayArea");		
		return _root.EI_retCode;
	}
	
	
	
	/**
	 * Sets the aspect ratio. Note that the aspect ratio applies only to the video plane, not to the UI plane.
	 *
	 * @param	ratio		[in] The aspect ratio to apply (lge.apis.AspectRatio)
	 *
	 * @return  Returns ReturnCode = OK if the aspect ratio is applied successfully; otherwise ERROR.
	 */
	public function setAspectRatio(ratio: Number):Number {
		ExternalInterface.call("__FOA__Control__setAspectRatio", ratio);		
		return _root.EI_retCode;
	}
	
	/**
	 * Gets the current aspect ratio.
	 *
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the aspect ratio is successfully obtained; otherwise ERROR.<br>
	 *			retObject.ratio: Number - The current aspect ratio (lge.apis.AspectRatio)
	 */
	public function getAspectRatio():Object {
		ExternalInterface.call("__FOA__Control__getAspectRatio");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Resets the display area to the default setting used before the add-on application runs. 
	 * Note that the aspect ratio applies only to the video plane, not to the UI plane.
	 *
	 * @return  Returns ReturnCode = OK if it is reset successfully; otherwise ERROR.
	 */
	public function resetAspectRatio():Number {
		ExternalInterface.call("__FOA__Control__resetAspectRatio");		
		return _root.EI_retCode;
	}
	
	
	/**
	 * Increases the current channel number by one.
	 *
	 * @param	bShowBanner	[in] TRUE if the DTV UI banner is displayed for the changed channel; otherwise FALSE.
	 *
	 * @return	Returns ReturnCode = OK if the channel is changed; otherwise ERROR.
	 */
	public function channelUp(bShowBanner:Boolean):Number {
		ExternalInterface.call("__FOA__Control__channelUp", bShowBanner);		
		return _root.EI_retCode;
	}

	/**
	 * Decreases the current channel number by one.
	 *
	 * @param	bShowBanner	[in] TRUE if the DTV UI banner is displayed for the changed channel; otherwise FALSE.
	 *
	 * @return	Returns ReturnCode.OK. if the channel is changed; otherwise ERROR.
	 */
	public function channelDown(bShowBanner:Boolean):Number {
		ExternalInterface.call("__FOA__Control__channelDown", bShowBanner);		
		return _root.EI_retCode;
	}

	/**
	 *	Changes the given channel number.
	 *
	 * @param	bShowBanner		[in] TRUE if the DTV UI banner is displayed for the changed channel; otherwise FALSE.
	 * @param	channel			[in] channel object.<br>
	 *								channel.SourceType:Number	- Broadcasting Source Type (lge.apis.TVSourceType)<br>
	 *								channel.MajorNum:Number	- Major Number<br>
	 *								channel.MinorNum:Number	- Minor Number (Not used in case of DVB)<br>
	 *								channel.PhysicalNum:Number	- Physical Number<br>
	 *
	 * @return  Returns ReturnCode = OK if the channel is changed; otherwise ERROR.
	 */
	public function setChannel(bShowBanner:Boolean, channel:Object): Number {
		ExternalInterface.call("__FOA__Control__setChannel", bShowBanner, channel.SourceType,channel.MajorNum,channel.MinorNum,channel.PhysicalNum);		
		return _root.EI_retCode;
	}
	
	
	/**
	 *	Gets the current channel.
	 *
	 * @return  retObject.retCode:Number	- Returns ReturnCode = OK if the current channel is successfully obtained; otherwise ERROR.<br>
	 *			retObject.SourceType:Number	- Broadcasting Source Type (lge.apis.TVSourceType)<br>
	 *			retObject.Name:String		- Channel Name<br>
	 *			retObject.MajorNum:Number	- Major Number <br>
	 *			retObject.MinorNum:Number	- Minor Number (Not used in case of DVB)<br>
	 *			retObject.PhysicalNum:Number	- Physical Number<br>
	 */
	public function getChannel(): Object {
		ExternalInterface.call("__FOA__Control__getChannel");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Gets the channel list.
	 *
	 * @param	attribute	[in] Gets the related attribute for the channel. It gets the Favorite List, Audio channel/Video channel. 
	 * 							 lge.apis.ChMap and lge.apis.ChAttrib value can be used with an “OR” operation.
	 *
	 * @return  retObject.retCode:Number	- ReturnCode.OK : When channel list is successfully obtained. Otherwise, errors.<br>
	 *			retObject.channelNum:Number - The number of Channel<br>
	 *			retObject.channelArr:Array - Channel array (amount of channelNum)<br>
	 *			retObject.channelArr[].SourceType:Number	- Broadcasting Source Type (lge.apis.TVSourceType)<br>
	 *			retObject.channelArr[].Name:String	- Channel Name<br>
	 *			retObject.channelArr[].MajorNum:Number	- Major Number <br>
	 *			retObject.channelArr[].MinorNum:Number	- Minor Number (Not used in case of DVB)<br>
	 *			retObject.channelArr[].PhysicalNum:Number	- Physical Number<br>
	 */
	public function getChannelList(attribute:Number):Object {
		ExternalInterface.call("__FOA__Control__getChannelList", attribute);
		
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	/**
	 * Gets the country information from the TV setting.<br>
	 * The country code complies with the ISO-3166 Alpha-3 standard.
	 * It returns a string that represents the three-letter code (alpha-3) of ISO 3166-1.<br>
	 * For example,<br>
	 *	 ISO 3166-1	code				The country code to be returned<br>
	 *		KOR							"KOR"<br>
	 *	 
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the locale information is successfully obtained; otherwise ERROR.<br>
	 *			retObject.country: String - The specified country. It is set when "localeType == COUNTRY".<br>
	 */
	public function getCountry(): Object {
		ExternalInterface.call("__FOA__Control__getCountry");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	/**
	 * Gets the language information from the TV setting.<br>
	 * The language code complies with the ISO 639-2 standard.
	 * It returns a string that represents the three-letter code (alpha-3) of ISO 639.<br>
	 * For example,<br>
	 *	 ISO 639-2 code				The language code to be returned<br>
	 *		kor							"kor"<br>
	 *	 
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the locale information is successfully obtained; otherwise ERROR.<br>
	 *			retObject.language:	String - The specified language. It is set when "localeType == LANGUAGE".<br>
	 */
	public function getMenuLanguage():Object {
		ExternalInterface.call("__FOA__Control__getMenuLanguage");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Gets the country group information from the TV setting.<br>
	 * Gets the group information from the TV settings and returns it in number. Group is defined as lge.apis.LocaleGroup.
	 *	 
	 * @return  retObject.retCode:Number	- Returns ReturnCode.OK. if the locale information is successfully obtained; otherwise ERROR.<br>
	 *			retObject.group: Number	- The specified group (lge.apis.LocaleGroup). It is set when "localeType ==GROUP".
	 */
	public function getRegion():Object {
		ExternalInterface.call("__FOA__Control__getRegion");
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Gets the TV features.
	 *
	 * @param supportType  [in]	Identifies the supported features. (class lge.apis.SupportType)
	 *
	 * @return	retObject.retCode:Number	- Returns ReturnCode = OK if the supported feature is identified; otherwise ERROR.<br>
	 *			retObject.bSupport: Boolean	- TRUE if the feature is supported; otherwise FALSE or the supported type
	 */
	public function getCapability(supportType:Number):Object {
		ExternalInterface.call("__FOA__Control__getCapability", supportType);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	
	
	
	/**
	 * Gets the storage size.
	 *
	 * @param	absPath	[in] Absolute path of storage that user want to get the size.
	 *
	 * @return	retObject.retCode:Number	- Return ReturnCode = OK if the storage size is successfully obtained; otherwise ERROR.<br>	
	 *			    retObject.availableStorageSize:Number	- The storage available size.<br>
	 *         retObject.totalStorageSize:Number	- The storage total size.
	 */
	public function getStorageSize(absPath:String): Object {
		ExternalInterface.call("__FOA__Control__getStorageSize", absPath);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**	
	 * Sets Motion Remote Mode.
	 *
	 * @param mode	[in] Motion R/C input mode. (lge.apis.Messagetype)
	 *
	 * @return	Returns ReturnCode = OK if the remote mode is successfully changed; otherwise ERROR.
	 */
	public function setMotionRemoteMode(mode:Number): Number {
		ExternalInterface.call("__FOA__Control__setMotionRemoteMode", mode);		
		return _root.EI_retCode;
	}
	
	/**
	 * Gets the panel type of the TV display.
	 *
	 * @param	panelAttribType	[in] The attribute type of the display panel, which you want to know (lge.apis.PanelAttributeType)
	 *
	 * @return	retObject.retCode:Number - Returns ReturnCode = OK if the display panel attribute is successfully obtained; otherwise ERROR.<br>
	 *			retObject.type: Number - The value varies depending on the display panel attribute and the attribute type. (see "lge.apis.PanelAttributeType")
	 */
	public function getDisplayPanelType(panelAttribType:Number):Object {
		ExternalInterface.call("__FOA__Control__getDisplayPanelType", panelAttribType);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Disables the screen saver or resets the value to the default setting.
	 *
	 * bOff	[in] TRUE to disable the screen saver; FALSE to reset the value to the default setting.
	 *
	 * @return Returns ReturnCode = OK if the screen saver is successfully enabled/disabled; otherwise ERROR.
	 */
	public function setScreensaverOff(bOff:Boolean):Number {
		ExternalInterface.call("__FOA__Control__setScreensaverOff", bOff);		
		return _root.EI_retCode;
	}
	
	/**
	 * Disables the dimming feature or resets the value to the default setting.
	 *
	 * @param	bOff	[in] TRUE to disable the dimming feature; FALSE to reset to the value to default setting.
	 *
	 * @return	Returns ReturnCode = OK if the dimming feature is successfully enabled/disabled; otherwise ERROR.
	 */
	public function setDimmingOff(bOff:Boolean):Number {
		ExternalInterface.call("__FOA__Control__setDimmingOff", bOff);		
		return _root.EI_retCode;
	}
	

	/**	 
	 * Creates a popup.
	 *
	 * @param	popupOption	[in] An option required to create a popup. <br>
	 *								popupOption.type: Number	- Popup	type. (lge.apis.PopupType) <br>
	 *								popupOption.timeout: Number	- The popup waiting time for the user input. (not supported. reserved for future use) <br>
	 *								popupOption.textArr: Array	- An array of text to be displayed in the popup.(not supported. reserved for future use) <br>
	 *								popupOption.textNum: Number	- The number of texts. (not supported. reserved for future use) <br>
	 *								popupOption.imagePathArr: Array		- An array of the image path (not supported. reserved for future use)<br>
	 *								popupOption.imagePathNum: Number	- The number of image paths (not supported. reserved for future use)
	 *
	 * @return	retObject.retCode:Number - Returns ReturnCode = OK if the popup is successfully created; otherwise ERROR.<br>
	 */
	public function createPopup(popupOption:Object):Object {		
		ExternalInterface.call("__FOA__Control__createPopup", popupOption.type, popupOption.timeout, popupOption.textArr.join("^"), popupOption.textNum, popupOption.imagePathArr.join("^"), popupOption.imagePathNum);		
		
		var kRetStr:String = _root.EI_retStr;				
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**	
	 * Set 3D Mode.
	 *
	 * @param input3DMode     [in] 3D Input mode. (class lge.apis.Input3DMode)<br>
	 *		  bRLBalance      [in] RL:true, LR:false 
	 *
	 * @return	 Returns ReturnCode = OK if the 3D mode is successfully changed; otherwise ERROR.<br>
	 */
	public function set3DMode(input3DMode:Number, bRLBalance:Boolean):Number
	{
		ExternalInterface.call("__FOA__Control__set3DMode", input3DMode, bRLBalance);
		return _root.EI_retCode;
	}
	
	/**
	 * Get 3D Mode.
	 *
	 * @return	retObject.retCode:Number - Returns ReturnCode = OK if the 3D mode is successfully retrieved; otherwise ERROR.<br>
	 * 			retObject.current3DMode:Number	- 3D mode, (lge.apis.Input3DMode)  (T/B, S/S, C/B, F/S ...)<br>
	 * 			retObject.bRLBalance:Boolean - RL:true, LR:false
	 */
	public function get3DMode():Object
	{
		ExternalInterface.call("__FOA__Control__get3DMode");		
		var kRetStr:String = _root.EI_retStr;				
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
	
	/**
	 * Activates the virtual keyboard on a smart phone or sends the string to the smart phone.<br>
	 * (See "FFC2.0 Development Guide" for more details.)
	 *
	 * @param	 	showSelect     [in] Start Text String의 show/hide/none enum (lge.apis.SmartMsg)<br>
	 * @param      	positionX       [in] Smart Text position x <br>
	 * @param      	positionY       [in] Smart Text position y<br>
	 * @param       textString      [in] Smart Text string
	 *           	
	 * @return	Returns ReturnCode = OK if smart text is successfully activated; otherwise ERROR.
	 */
	public function activateSmartText(showSelect:Number, positionX:Number, positionY:Number, textString:String):Number {
		ExternalInterface.call("__FOA__Control__activateSmartText", showSelect, positionX, positionY, textString);
		return _root.EI_retCode;
	}	
}