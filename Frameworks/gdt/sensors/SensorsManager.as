package gdt.sensors {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	
	import com.adobe.nativeExtensions.Gyroscope;
	import com.adobe.nativeExtensions.GyroscopeEvent;
	import com.adobe.nativeExtensions.GyroscopeIntervalValue;
	
	public class SensorsManager {
		public static var activeSensor:Sensor;
		
		private static var _accelerometer:Accelerometer;
		private static var _gyroscope:Gyroscope;
		
		public function SensorsManager() {
			
		}
		//
	}
	////////////////////////////////////////////////////
	//////////////////////////////////// Sensor class //
	////////////////////////////////////////////////////
	class Sensor {
		public function Sensor() {
			
			}
		}
}