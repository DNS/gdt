package game {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.utils.FloatingPopUps;
	import game.gems.BaseGem;
	
	//import Vector;
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class Game extends Sprite {
		// constants
		public const numPieces:uint = 7;
		public const spacing:Number = 60;
		public const offsetX:Number = 65;
		public const offsetY:Number = 65;
		
		// game grid and mode
		public var gemGrid:Array;
		
		private var gameSprite:Sprite;
		private var gridSprite:Sprite;
		private var isDropping:Boolean;
		private var isSwapping:Boolean;
		private var gameScore:int;
		public var rows:int = 7;
		public var columns:int = 10;
		private var firstPiece:BaseGem;
		
		public function Game() {
			
			}
		//
		public function init():void {
			gridSprite = new Sprite();
			addChild(gridSprite);
			//
			gameSprite = new Sprite();
			addChild(gameSprite);
			//
			gemGrid = new Array();
			var r:int;
			var c:int;
			for (c = 0; c < columns; c++) {
				gemGrid[c] = new Vector.<BaseGem>(rows, true);
				for (r = 0; r < rows; r++) {
					gemGrid[c][r] = addPiece(c, r);
					}
				}
			//
			addEventListener(Event.ENTER_FRAME, movePieces);
			}
		//
		public function addPiece(col:int, row:int):BaseGem {
			var newGem:BaseGem = new BaseGem();
			newGem.init(String(Math.ceil(Math.random() * 6)), col, row);
			newGem.x = col * spacing + offsetX;
			newGem.y = row * spacing + offsetY;
			
			gameSprite.addChild(newGem);
			newGem.addEventListener(MouseEvent.CLICK, clickPiece);
			return newGem;
		}
		//
		public function clickPiece(event:MouseEvent):void {
			var piece:BaseGem = BaseGem(event.currentTarget);
			//if (piece.type != 7 && piece.health == 0){
				if (firstPiece == null) {
					//piece.select.visible = true;
					firstPiece = piece;
					} else if (firstPiece == piece) {
							//piece.select.visible = false;
							firstPiece = null;
							} else {
								//firstPiece.select.visible = false;
								if ((firstPiece.row == piece.row) && (Math.abs(firstPiece.col - piece.col) == 1)) {
									makeSwap(firstPiece, piece);
									firstPiece = null;
									} else if ((firstPiece.col == piece.col) && (Math.abs(firstPiece.row - piece.row) == 1)) {
												makeSwap(firstPiece,piece);
												firstPiece = null;
												} else {
													firstPiece = piece;
													//firstPiece.select.visible = true;
													}
									}
				//}
		}
		//
		public function makeSwap(piece1:BaseGem, piece2:BaseGem):void {
			swapPieces(piece1, piece2);
			//
			if (lookForMatches().length == 0){
				swapPieces(piece1, piece2);
				}else{
					isSwapping = true;
					}
			}
		//
		public function swapPieces(piece1:BaseGem , piece2:BaseGem):void {
			var tempCol:uint = piece1.col;
			var tempRow:uint = piece1.row;
			piece1.col = piece2.col;
			piece1.row = piece2.row;
			piece2.col = tempCol;
			piece2.row = tempRow;
			
			// swap grid positions
			gemGrid[piece1.col][piece1.row] = piece1;
			gemGrid[piece2.col][piece2.row] = piece2;
			}
		//
		public function lookForMatches():Array {
			var matchList:Array = new Array();
			// search for horizontal matches
			for (var row:int = 0; row < rows; row++) {
				for (var col:int = 0; col < columns - 2; col++) {
					var match:Array = getMatchHoriz(col,row);
					if (match.length > 2 && gemGrid[col][row].type != 7) {
						matchList.push(match);
						col += match.length - 1;
						}
					}
				}
			// search for vertical matches
			for (col = 0; col < columns; col++) {
				for (row = 0; row < rows - 2; row++) {
					match = getMatchVert(col,row);
					if (match.length > 2 && gemGrid[col][row].type != 7){
						matchList.push(match);
						row += match.length-1;
						}	
					}
				}
			return matchList;
			}
		//
		// gets matches and removes them, applies points
		public function findAndRemoveMatches():void {
			// get list of matches
			var matches:Array = lookForMatches();
			for (var i:int = 0; i < matches.length; i++) {
				var numPoints:Number = (matches[i].length - 1) * 50;
				for (var j:int = 0; j < matches[i].length; j++) {
					if (gameSprite.contains(matches[i][j])) {// && matches[i][j].health == 0
						var pb:FloatingPopUps = new FloatingPopUps(String(numPoints), matches[i][j]);
						addChild(pb);
						//addScore(numPoints);
						gameSprite.removeChild(matches[i][j]);// TODO: death animation
						gemGrid[matches[i][j].col][matches[i][j].row] = null;
						affectAbove(matches[i][j].col, matches[i][j].row);
						}
					/*if (gameSprite.contains(matches[i][j]) && matches[i][j].health != 0) {
						gemGrid[matches[i][j].col][matches[i][j].row].health--;
						}*/
					}
				}
			// add any new piece to top of board
			addNewPieces();
			// no matches found, maybe the game is over?
			/*if (matches.length == 0) 
				if (!lookForPossibles()) 
					endGame();*/
			}
		//
		// if there are missing pieces in a column, add one to drop
		public function addNewPieces():void 
		{
			for (var col:int = 0; col < columns; col++) {
				var missingPieces:int = 0;
				for (var row:int = rows - 1; row >= 0; row--) {
					if (gemGrid[col][row] == null) {// && !aboveBlock(col, row)
						var newPiece:BaseGem = addPiece(col, row);
						//newPiece.y = offsetY - spacing - spacing * missingPieces++;
						gemGrid[col][row] = newPiece;
						isDropping = true;
						}
					}
				}
		}
		
		//
		// look for horizontal matches starting at this point
		public function getMatchHoriz(col:int, row:int):Array {
			var match:Array = new Array(gemGrid[col][row]);
			for (var i:int = 1; col + i < columns; i++) 
			{
				if (gemGrid[col][row] != null && gemGrid[col + i][row] != null && gemGrid[col][row].type == gemGrid[col + i][row].type)
					match.push(gemGrid[col + i][row]);
				else
					return match;
			}
			return match;
		}

		// look for vertical matches starting at this point
		public function getMatchVert(col:int, row:int):Array {
			var match:Array = new Array(gemGrid[col][row]);
			for (var i:int = 1; row + i < rows; i++) 
			{
				if (gemGrid[col][row] != null && gemGrid[col][row + i] != null && gemGrid[col][row].type == gemGrid[col][row + i].type)
					match.push(gemGrid[col][row+i]);
				else 
					return match;
			}
			return match;
		}
		//
		//
		//
		public function movePieces(event:Event):void {	
			for (var col:int = 0; col < columns; col++ ) {
				for (var row:int = 0; row < rows; row++ ) {
					if (gemGrid[col][row] != null) {
						(gemGrid[col][row] as BaseGem).moveIt();
						}
					}
				}
			}
		//
		public function affectAbove(_col:int, _row:int):void {
			var row:int = _row;
			while (row >= 0) {
				if (gemGrid[_col][row] != null) {
					gemGrid[_col][row].row++;
					gemGrid[_col][row + 1] = gemGrid[_col][row];
					gemGrid[_col][row] = null;
					}
				row--;
				}
			}
		//
		public function useSpecials(event:MouseEvent):void{
			var piece:BaseGem = event.currentTarget as BaseGem;
			
			gemGrid[piece.col][piece.row] = null;
			gameSprite.removeChild(piece);
			affectAbove(piece.col, piece.row);
			}
	}

}