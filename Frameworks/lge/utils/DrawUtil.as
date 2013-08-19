
/**
 * Extends the MovieClip's drawing API and provides
 * the method and event to draw figures. 
 */
class lge.utils.DrawUtil {

	
	private static function setLineStyle($holder:MovieClip, $lineThick:Number, $lineColor:Number):Void {		
		$holder.lineStyle($lineThick, $lineColor);			
	}
	
	private static function startFillColor($holder:MovieClip, $color:Number,$alpha:Number):Void {		
		$alpha = ($alpha == null)?0:$alpha;
		$holder.beginFill($color,$alpha);		
	}
	/**
	 * Draws a rectangular box marked with "X" (background: white, line: black).
	 * 
	 * @param	$holder (MovieClip) The MovieClip to draw a box into
	 * @param	$width (Number) The width of the box
	 * @param	$height (Number) The height of the box
	 */
	public static function createXBox($holder:MovieClip, $width:Number, $height:Number):Void {			
		drawRect($holder, $width, $height, 1, 0, 0xFFFFFF, 100);
		drawX($holder, $width, $height, 1, 0);		
	}
	
	/**
	 * Draws a rectangle.
	 * 
	 * @param	$holder (MovieClip) The MovieClip to draw a rectangle into
	 * @param	$width (Number) The width of the rectangle
	 * @param	$height (Number) The height of rectangle
	 * @param	$lineThick (Number) The thickness of the rectangle outline
	 * @param	$lineColor (Number) The color of the rectangle outline
	 * @param	$fillColor (Number) The color of the rectangle
	 * @param	$alpha (Number) The transparency of the rectangle
	 */
	public static function drawRect($holder:MovieClip, $width:Number, $height:Number, $lineThick:Number, $lineColor:Number, $fillColor:Number,$alpha:Number):Void {
		setLineStyle($holder, $lineThick, $lineColor);	
		if ($alpha == null) {
			$alpha = 100;
		}
		startFillColor($holder, $fillColor, $alpha);	
		
		$holder.lineTo($width,0);
		$holder.lineTo($width,$height);
		$holder.lineTo(0,$height);
		$holder.lineTo(0, 0);
		
		$holder.endFill();
	}
	
	
	private static function drawX($holder:MovieClip, $width:Number, $height:Number, $lineThick:Number, $lineColor:Number):Void {
		setLineStyle($holder, $lineThick, $lineColor);		
		
		$holder.moveTo(0, 0);		
		$holder.lineTo($width, $height);
		
		$holder.moveTo($width,0);
		$holder.lineTo(0,$height);		
	}
	
	/**
	 * Draws an ellipse (If the vertical and horizontal radius are the same, a circle is drawn).
	 * 
	 * @param	$holder (MovieClip) The MovieClip to draw a circle into
	 * @param	$xRad (Number) The horizontal radius of the circle
	 * @param	$yRad (Number) The vertical radius of the circle
	 */
	
	public static function drawOval($holder:MovieClip, $xRad:Number, $yRad:Number):Void {
		var kAngleStep:Number = Math.PI/4;
		var kXCtrlDist:Number = $xRad/Math.cos(kAngleStep/2);
		var kYCtrlDist:Number = $yRad/Math.cos(kAngleStep/2);
		$holder.moveTo($xRad,0);
		var kRX:Number;
		var kRY:Number;
		var kAX:Number;
		var kAY:Number;
		var kAngle:Number = 0;
		for (var i = 0; i<8; i++) {
			kAngle += kAngleStep;
			kRX = Math.cos(kAngle-(kAngleStep/2))*(kXCtrlDist);
			kRY = Math.sin(kAngle-(kAngleStep/2))*(kYCtrlDist);
			kAX = Math.cos(kAngle)*$xRad;
			kAY = Math.sin(kAngle)*$yRad;
			$holder.curveTo(kRX,kRY,kAX,kAY);
		}
	}
}