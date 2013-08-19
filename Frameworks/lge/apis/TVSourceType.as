/**
 * TV input source & system type.
 */
class lge.apis.TVSourceType
{
	/**   Analog input transmitted through the antenna */
	public static var INPUT_ANTENNA_ANALOG 	:Number = 0x0001;
	/**   Digital input transmitted through the antenna */
	public static var INPUT_ANTENNA_DIGITAL :Number = 0x0002;
	/**   Analog input transmitted through the cable */
	public static var INPUT_CABLE_ANALOG    :Number = 0x0003;
	/**   Digital (QAM or VSB) input transmitted through the cable */
	public static var INPUT_CABLE_DIGITAL   :Number = 0x0004;
	/**   Undefined input transmitted through the cable */
	public static var INPUT_CABLE_UNDEFINED :Number = 0x0005;
	/**   Analog input transmitted through the OpenCable */
	public static var INPUT_OCABLE_ANALOG   :Number = 0x0006;
	/**   Digital input transmitted through the OpenCable */
	public static var INPUT_OCABLE_DIGITAL  :Number = 0x0007;
	/**   1394 input */
	public static var INPUT_1394_TV	        :Number = 0x0008;
	/**   Cable box input */
	public static var INPUT_CABLE_BOX       :Number = 0x0009;
	/**  IP input */
	public static var INPUT_IP              :Number = 0x000A;
	/**  DVB System*/
	public static var SYS_DVB             :Number = 0x1000;
	/**  ATSC System */
	public static var SYS_ATSC            :Number = 0x2000;
	/**  Undefined input */
	public static var UNDEFINED       :Number = 0x0000;
}