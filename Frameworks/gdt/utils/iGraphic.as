package gdt.utils {
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	
	import flash.filters.ColorMatrixFilter;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class iGraphic {
		
		public function iGraphic() {
			
		}
		//
		public static function useDeactivateFilter(target:*):void {
			var matrix: Array = [
				0.3, 0.6, 0.1, 0, 0,
				0.3, 0.6, 0.1, 0, 0,
				0.3, 0.6, 0.1, 0, 0,
				0,   0,   0,   1, 0
				];
			target.filters = [new ColorMatrixFilter(matrix)];
			}
	}
}