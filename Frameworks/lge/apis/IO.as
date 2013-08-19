import lge.utils.XmlToObject;
import flash.external.ExternalInterface;

/**********************************************************************************************
* This module provides functions required to use the network and 
* receives the network connection status.
**********************************************************************************************/
class lge.apis.IO {
	/**
	 * Gets the network status. Tests the connection status of the link (only if ipAddress is not "") and the network and returns the status.
	 *
	 * @param	ipAddress	[in] An IP address to ping. Ping is not performed if "".
	 *
	 * @return	retObject.retCode:Number	- Returns ReturnCode = OK if the network status is successfully obtained; otherwise ERROR.<br>
	 *			retObject.activatedNetwork:	Number - Currently enabled network type (lge.apis.NetworkType)<br>
	 *								retObject.status: Number - The network status (lge.apis.NetworkStatus)
	 */
	public function getNetworkStatus(ipAddress:String):Object {
		ExternalInterface.call("__FOA__IO__getNetworkStatus", ipAddress);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}

	/**
	 * Gets the network settings.
	 *
	 * @param	networkType	[in] A network type to get the setting (see "lge.apis.NetworkType")
	 *
	 * @return	retObject.retCode:Number	- Returns ReturnCode = OK if the network setting is successfully obtained; otherwise ERROR.<br>
	 *			retObject.ipAddress: String			- An IP address in the "A.B.C.D" format<br>
	 *			retObject.subnetMask: String		- The subnet mask in the "A.B.C.D" format.<br>
	 *			retObject.gateway: String			- The gateway in the "A.B.C.D" format.<br>
	 *			retObject.DNSServer1: String		- DNS server 1 in the "A.B.C.D" format<br>
	 *			retObject.DNSServer2: String		- DNS server 2 in the "A.B.C.D" format<br>
	 *			retObject.macAddress: String		- The MAC address in the "A:B:C:D:E:F" format<br>
	 *			retObject.DHCPServer: String		- The DHCP server address in the "A.B.C.D" format<br>
	 *			retObject.bDHCP: Boolean			- Whether the DHCP is enabled (1) or not (0)<br>
	 *			retObject.macAddressOfAP: String	- The MAC address of the wireless AP in the "A:B:C:D:E:F" format
	 */
	public function getNetworkSettings(networkType:Number):Object {
		ExternalInterface.call("__FOA__IO__getNetworkSettings", networkType);
		var kRetStr:String = _root.EI_retStr;		
		
		var kRetObj:Object = XmlToObject.parseXmlToObject(kRetStr);
		kRetObj.retCode = _root.EI_retCode;
		return kRetObj;
	}
}