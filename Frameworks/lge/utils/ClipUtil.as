
import lge.utils.NumberUtil;
import lge.utils.DrawUtil;


/**
 * Helps handle a MovieClip which is an intrinsic class
 * of the Flash Player.
 */
class lge.utils.ClipUtil {
	
	/**
	 * When the MovieClip is resized horizontally,
	 * image distortion occurs in the corner or border area.
	 * This can be prevented by dividing the MovieClip into three 
	 * horizontal sections. Then, this function resizes the center
	 * section which is less likely to be distorted.
	 * 
	 * @param	$pieceClipArray (Array) An array that stores the instance name of the MovieClip's left, center and right sections
	 * @param	$wid (Number) The width of the entire MovieClip 
	 */
	public static function resize3PiecedRect($pieceClipArray:Array, $wid:Number):Void {		
		
		var kLeft:MovieClip = $pieceClipArray[0];
		var kCenter:MovieClip = $pieceClipArray[1];
		var kRight:MovieClip = $pieceClipArray[2];

		if ($wid != null) {
			var kCenterW:Number = Math.ceil(Math.max($wid - (kLeft._width + kRight._width), 20));						 
			
			kCenter._width = kCenterW;
			
			kCenter._x = Math.ceil(kLeft._x + kLeft._width);
			
			kRight._x = Math.ceil(kCenter._x + kCenter._width);		
		}		
		
	}
	
	/**
	 * Creates a MovieClip covering the entire stage. A mouse event is attached to this MovieClip,
	 * so the mouse event is not forwarded to the buttons that have a lower z-depth.
	 * This mouse event blocker is necessary when the current window is modal and user events should not be forwarded
	 * to the controller other than the current window.
	 * 
	 * @param	$holder (MovieClip) The MovieClip to draw the mouse event blocker into
	 * @param	$wid (Number) The width of the mouse event blocker (default: the width of the stage)
	 * @param	$hei (Number) The height of the mouse event blocker (default: the height of the stage)
	 * @param	$alpha (Number) The transparency of the mouse event blocker (default: 0)
	 */
	public static function createMouseBlocker($holder:MovieClip, $wid:Number, $hei:Number, $alpha:Number):Void {		
				
		$alpha = NumberUtil.getNumber($alpha, 0);
		
		var kWidExtra:Number = 20;
		
		var kWid:Number = NumberUtil.getIntNumber($wid, Stage.width)+kWidExtra;
		var kHei:Number = NumberUtil.getIntNumber($hei, Stage.height);
		
		DrawUtil.drawRect($holder, kWid, kHei, 0, null, 0x000000, 100);	
		
		$holder._alpha = $alpha;
		
		var kBs:Object = $holder.getBounds(_level0);
		
		$holder._x = -kBs.xMin - (kWidExtra / 2);		
		$holder._y = -kBs.yMin;		
		
		$holder._focusrect = false;
		$holder.onRollOver = function():Void {						
		}
		
	}
	
	/**
	 * Changes the color of the MovieClip to the specified color.
	 * This method is recommended for MovieClips with single color, such as the background of a button, 
	 * rather than on the ones with multiple colors.
	 * 
	 * @param	$clip (MovieClip) The MovieClip to change the color
	 * @param	$color (Number) The specified color
	 */
	public static function attachColorToClip($clip:MovieClip, $color:Number):Void {
		var kColor:Color = new Color($clip);
		kColor.setRGB($color);
	}
	
	
	/**
	 * Creates an empty MovieClip within the MovieClip passed as a parameter.
	 * The MovieClip has the createEmptyMovieClip() method but the advantage of this method is:<br>
	 * - If a MovieClip with the same name exists already, it deletes the old one.<br>
	 * - It sets the depth automatically to the highest so that it will not overlap with the depth of other MovieClips.<br>
	 * 
	 * @param	$parent (MovieClip) The parent MovieClip in which the new MovieClip is to be created
	 * @param	$name (String) The name of the instance of the new MovieClip
	 * @param	$x (Number) The X coordinate of the new MovieClip (default: 0)
	 * @param	$y (Number) The Y coordinate of the new MovieClip (default: 0)
	 * @return (MovieClip) Returns the newly created MovieClip.
	 */
	public static function createEmptyHolder($parent:MovieClip, $name:String, $x:Number, $y:Number):MovieClip {
		$parent[$name].removeMovieClip();
		var kHolder:MovieClip = $parent.createEmptyMovieClip($name, $parent.getNextHighestDepth());		
		kHolder._x = NumberUtil.getIntNumber($x, 0);
		kHolder._y = NumberUtil.getIntNumber($y, 0);	
		kHolder._focusrect = false;
		
		return kHolder;
	}
	
	/**
	 * Dynamically attaches a MovieClip symbol (with the linkage property) stored in the library.
	 * The MovieClip has the attachMovie() method but the advantage of this method is:<br><br>
	 * - If a MovieClip with the same name exists already, it deletes the old one.<br>
	 * - It sets the depth automatically to the highest so that it will not overlap with the depth of other MovieClips.<br>
	 * 
	 * @param	$parent (MovieClip) The parent MovieClip of the newly attached MovieClip
	 * @param	$lnk (String) The linkage identifier of the symbol with the linkage property
	 * @param	$name (String) The name of the instance of the new MovieClip
	 * @param	$x (Number) The X coordinate of the attached MovieClip (default: 0)
	 * @param	$y (Number) The Y coordinate of the attached MovieClip (default: 0)
	 * @param	$w (Number) The width of the attached MovieClip (default: the original width of the symbol)
	 * @param	$h (Number) The height of the attached MovieClip (default: the original height of the symbol)
	 * @return (MovieClip) Returns the newly attached MovieClip.
	 */
	public static function attachHolder($parent:MovieClip, $lnk:String, $name:String, $x:Number, $y:Number, $w:Number, $h:Number):MovieClip {
		if ($name == null) {
			$name = $lnk;
		}
		$parent[$name].removeMovieClip();
		var kHolder:MovieClip = $parent.attachMovie($lnk, $name, $parent.getNextHighestDepth());
		kHolder._width = NumberUtil.getIntNumber($w, kHolder._width);
		kHolder._height = NumberUtil.getIntNumber($h, kHolder._height);
		kHolder._x = NumberUtil.getIntNumber($x, 0);
		kHolder._y = NumberUtil.getIntNumber($y, 0);
		kHolder._focusrect = false;
		
		return kHolder;
	}
	
	/**
	 * Positions the MovieClip to the center of the stage.
	 * 
	 * @param	$holder (MovieClip) The MovieClip to be positioned
	 * @param	$stageWid (Number) The width of the stage (default: Stage.width)
	 * @param	$stageHei (Number) The height of the stage (default: Stage.height)
	 */
	public static function placeAtStageCenter($holder:MovieClip, $stageWid:Number, $stageHei:Number):Void {
		
		var kStageWid:Number = NumberUtil.getNumber($stageWid, Stage.width);
		var kStageHei:Number = NumberUtil.getNumber($stageHei, Stage.height);
		
		var kBs:Object = $holder.getBounds(_root);
		$holder._x = Math.round($holder._x-kBs.xMin + (kStageWid - $holder._width) / 2);
		$holder._y = Math.round($holder._y-kBs.yMin + (kStageHei - $holder._height) / 2);
	}
	
	
}