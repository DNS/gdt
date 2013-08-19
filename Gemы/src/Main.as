package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	public class Main extends Sprite {
		
		// constants
		public static const columns	: int = 10;
		public static const rows	: int = 7;
		public static const spacing	: int = 64;
		public static const offsetX	: int = 65;
		public static const offsetY	: int = 65;
		
		//
		private var _timer:Timer = new Timer(800, 0);
		
		private var gemGrid:Array = new Array();
		
		private var matchArray:Array = new Array();
		private var swapMatchArray:Array = new Array();
		
		private var isSwapComplete:Boolean  = true;
		
		private var gameSprite:Sprite;
		
		private var gridSprite:Sprite;
		
		private var gameScore:int;
		
		private var selectedGem:BaseGem;
		
		private var score:Score;
		
		public function Main():void {
			if (stage) {
				init();
				} else { 
					addEventListener(Event.ADDED_TO_STAGE, init);
					}
			}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//
			score = new Score();
			score.x = (stage.stageWidth / 2) - (score.width / 2);
			score.y = offsetY + spacing * rows + 30;
			addChild(score);
			//
			gridSprite = new Sprite();
			gridSprite.graphics.lineStyle(2, 0xFF8040);
			gridSprite.graphics.drawRoundRect(offsetX - 10, offsetY - 10, (spacing * columns + 20), (spacing * rows + 20), 10);
			addChild(gridSprite);
			//
			gameSprite = new Sprite();
			addChild(gameSprite);
			//
			var c:int;
			var r:int;
			var gem:BaseGem;
			for (c = 0; c < columns; c++ ) {
				gemGrid[c] = new Array();
				
				for (r = 0; r < rows; r++ ) {
					gem = addGem(c, r);
					gameSprite.addChild(gem);
					gemGrid[c][r] = gem;
					}
				}
			
			getAllMatch();
			
			//_timer.addEventListener(TimerEvent.TIMER, removeMatch);
			//_timer.start();
			}
		//
		public function addGem(col:int, row:int, drop:Boolean = false):BaseGem {
			var newGem:BaseGem = new BaseGem();
			newGem.init(String(randomNumber(1, 4)), col, row, drop);
			
			gameSprite.addChild(newGem);
			//newGem.addEventListener(MouseEvent.CLICK, removeGem);
			newGem.addEventListener(MouseEvent.CLICK, clickGem);
			newGem.addEventListener(GemEvent.GEM_DROP_COMPLETE, dropComplete);
			newGem.addEventListener(GemEvent.GEM_SWAP_COMPLETE, swapComplete);
			return newGem;
			}
		//
		public function addNewGems():void {
			for (var col:int = 0; col < columns; col++) {
				var missingPieces:int = 0;
				for (var row:int = rows - 1; row >= 0; row--) {
					if (gemGrid[col][row] == null) {
						var newPiece:BaseGem = addGem(col, row, true);
						//newPiece.y = offsetY - spacing - spacing * missingPieces++;
						gemGrid[col][row] = newPiece;
						}
					}
				}
			}
		//
		public function clickGem(event:MouseEvent):void {
			var gem:BaseGem = BaseGem(event.currentTarget);
			if (selectedGem == null) {
				selectedGem = gem;
				selectedGem.selected(true);
				trace(selectedGem.getProps());
				} else if (selectedGem == gem) {
					selectedGem.selected(false);	
					selectedGem = null;
						} else {
							if ((selectedGem.row == gem.row) && (Math.abs(selectedGem.col - gem.col) == 1)) {
								makeSwap(selectedGem, gem);
								selectedGem.selected(false);
								selectedGem = null;
								} else if ((selectedGem.col == gem.col) && (Math.abs(selectedGem.row - gem.row) == 1)) {
										makeSwap(selectedGem, gem);
										selectedGem.selected(false);
										selectedGem = null;
										} else {
											selectedGem.selected(false);
											selectedGem = gem;
											selectedGem.selected(true);
											}
							}
			}
		//
		public function makeSwap(gem1:BaseGem, gem2:BaseGem):void {
			if (findAndRemoveLocalMatches(gem1, gem2)) {
				isSwapComplete = false;
				swapGems(gem1, gem2);
				}else {
					gem1.noMatchAnim(gem2.col, gem2.row);
					gem2.noMatchAnim(gem1.col, gem1.row);
					trace("no match!!!");
					}
			}
		//
		public function swapGems(gem1:BaseGem, gem2:BaseGem):void {
			var col:int = gem1.col;
			var row:int = gem1.row;
			
			gemGrid[col][row] = gem2;
			gemGrid[gem2.col][gem2.row] = gem1;
			
			gem1.move(gem2.col, gem2.row, true);
			gem2.move(col, row, true);
			}
		//
		private function swapComplete(e:GemEvent):void {
			isSwapComplete = true;
			removeMatch();
			}
		//
		private function dropComplete(e:GemEvent):void {
			getAllMatch();
			}
		//
		public function findAndRemoveLocalMatches(gem1:BaseGem, gem2:BaseGem):Boolean {
			var allMatch:Array = [];
			var math1:Array = getMatchHorizont(gem2.col, gem2.row, gem1);
			var math2:Array = getMatchHorizont(gem1.col, gem1.row, gem2);
			var math3:Array = getMatchVertical(gem2.col, gem2.row, gem1);
			var math4:Array = getMatchVertical(gem1.col, gem1.row, gem2);
			var math5:Array = getMatchDiagonal(gem2.col, gem2.row, gem1);
			var math6:Array = getMatchDiagonal(gem1.col, gem1.row, gem2);
			
			if (math1.length > 2) {
				allMatch = math1;
				}
			if (math2.length > 2) {
				allMatch = allMatch.concat(math2);
				}
			if (math3.length > 2) {
				allMatch = allMatch.concat(math3);
				}
			if (math4.length > 2) {
				allMatch = allMatch.concat(math4);
				}
			if (math5.length > 2) {
				allMatch = allMatch.concat(math5);
				}
			if (math6.length > 2) {
				allMatch = allMatch.concat(math6);
				}
			
			if (allMatch.length > 0) { 
				swapMatchArray = allMatch;
				return true; 
				}
			
			return false;
			}
		//
		//////
		private function removeGem(event:MouseEvent):void {
			var gem:BaseGem = BaseGem(event.currentTarget);
			gemGrid[gem.col][gem.row] = null;
			gem.destroy(1);
			affectAbove(gem.col, gem.row);
			gem = null;
			}
		//
		public function affectAbove(_col:int, _row:int):void {
			var gem:BaseGem;
			
			var col:int = _col;
			var row:int = _row;
			var gemRow:int;
			while (row >= 0) {
				if (gemGrid[_col][row] != null && gemGrid[_col][row + 1] == null) {
					gem = gemGrid[_col][row];
					//
					gemGrid[_col][row + 1] = gemGrid[_col][row];
					gem.move(_col, gem.row + 1, false, true);
					gemGrid[_col][row] = null;
					
					}
				row--;
				}
			addNewGems();
			//getAllMatch();
			}
		//
		//
		public function getMatchHorizont(col:int, row:int, gem:BaseGem):Array {
			var comb:Array = [];
			
			gem.isMatch = true;
			var match:Array = [];
			var mCol:Number;
			
			if ((col + 1) <= (gemGrid.length - 1) && gemGrid[col + 1][row] && gemGrid[col + 1][row].type == gem.type && !gemGrid[col + 1][row].isMatch && !gemGrid[col + 1][row].isDropping) {
				mCol = gemGrid[col + 1][row].col;
				while (mCol < columns) {
					if (gemGrid[mCol][row] && gemGrid[mCol][row].type == gem.type && !gemGrid[mCol][row].isMatch && !gemGrid[mCol][row].isDropping) {
						gemGrid[mCol][row].isMatch = true;
						match.push(gemGrid[mCol][row]);
						}else {
							break;
							}
					mCol++;
					}
				}
			
			mCol = 0;
			
			if ((col - 1) >= 0 && gemGrid[col - 1][row] && gemGrid[col - 1][row].type == gem.type && !gemGrid[col - 1][row].isMatch && !gemGrid[col - 1][row].isDropping) {
				mCol = gemGrid[col - 1][row].col;
				while (mCol >= 0) {
					if (gemGrid[mCol][row] && gemGrid[mCol][row].type == gem.type && !gemGrid[mCol][row].isMatch && !gemGrid[mCol][row].isDropping) {
						gemGrid[mCol][row].isMatch = true;
						match.push(gemGrid[mCol][row]);
						}else {
							break;
							}
					mCol--;
					}
				}
			
			if (match.length < 2) {
				gem.isMatch = false;
				var g:int;
				for (g = 0; g < match.length; g++ ) {
					(match[g] as BaseGem).isMatch = false;
					}
				}
			if (match.length >= 2) { match.push(gem); }
			//trace("comb: " + comb);
			return match;
			}
		//
		public function getMatchVertical(col:int, row:int, gem:BaseGem):Array {
			var comb:Array = [];
			
			gem.isMatch = true;
			var match:Array = [];
			var mRow:Number;
			
			if (/*(row + 1) <= rows && */gemGrid[col][row + 1] && gemGrid[col][row + 1].type == gem.type && !gemGrid[col][row + 1].isMatch && !gemGrid[col][row + 1].isDropping) {
				mRow = gemGrid[col][row + 1].row;
				while (mRow < rows) {
					if (gemGrid[col][mRow] && gemGrid[col][mRow].type == gem.type && !gemGrid[col][mRow].isMatch  && !gemGrid[col][mRow].isDropping) {
						gemGrid[col][mRow].isMatch = true;
						match.push(gemGrid[col][mRow]);
						}else {
							break;
							}
					mRow++;
					}
				}
			
			mRow = 0;
			
			if (/*(row - 1) >= 0 && */gemGrid[col][row - 1] && gemGrid[col][row - 1].type == gem.type && !gemGrid[col][row - 1].isMatch && !gemGrid[col][row - 1].isDropping) {
				mRow = gemGrid[col][row - 1].row;
				while (mRow > -1) {
					if (gemGrid[col][mRow] && gemGrid[col][mRow].type == gem.type && !gemGrid[col][mRow].isMatch && !gemGrid[col][mRow].isDropping) {
						gemGrid[col][mRow].isMatch = true;
						match.push(gemGrid[col][mRow]);
						}else {
							break;
							}
					mRow--;
					}
				}
			
			if (match.length < 2) {
				gem.isMatch = false;
				var g:int;
				for (g = 0; g < match.length; g++ ) {
					(match[g] as BaseGem).isMatch = false;
					}
				}
			if (match.length >= 2) { match.push(gem); }
			return match;
			}
		//
		public function getMatchDiagonal(col:int, row:int, gem:BaseGem):Array {
			var comb:Array = [];
			
			gem.isMatch = true;
			var match:Array = [];
			var mCol:Number;
			var mRow:Number;
			
			// down right
			if (col != (columns - 1) && row != (rows - 1) && (col + 1) <= (columns - 1)  && (row + 1) <= (rows - 1) && gemGrid[col + 1][row + 1] && gemGrid[col + 1][row + 1].type == gem.type && !gemGrid[col + 1][row + 1].isMatch && !gemGrid[col + 1][row + 1].isDropping) {
				mCol = gemGrid[col + 1][row + 1].col;
				mRow = gemGrid[col + 1][row + 1].row;
				
				downRight();
				}else if ((col - 1) >= 0  && (row + 1) <= (rows - 1) && gemGrid[col - 1][row + 1] && gemGrid[col - 1][row + 1].type == gem.type && !gemGrid[col - 1][row + 1].isMatch && !gemGrid[col - 1][row + 1].isDropping) {
					mCol = gemGrid[col - 1][row + 1].col;
					mRow = gemGrid[col - 1][row + 1].row;
					
					downLeft();
					}else if ((col - 1) > -1  && (row - 1) > -1 && gemGrid[col - 1][row - 1] && gemGrid[col - 1][row - 1].type == gem.type && !gemGrid[col - 1][row - 1].isMatch && !gemGrid[col - 1][row - 1].isDropping){
						mCol = gemGrid[col - 1][row - 1].col;
						mRow = gemGrid[col - 1][row - 1].row;
						
						upLeft();
						}else if ((col + 1) <= (columns - 1)  && (row - 1) > -1 && gemGrid[col + 1][row - 1] && gemGrid[col + 1][row - 1].type == gem.type && !gemGrid[col + 1][row - 1].isMatch && !gemGrid[col + 1][row - 1].isDropping){
							mCol = gemGrid[col + 1][row - 1].col;
							mRow = gemGrid[col + 1][row - 1].row;
							
							upRight();
							}
			
			function downRight():void {
				//trace("downRight");
				while (mCol <= (columns - 1) && mRow <= (rows - 1) && gemGrid[mCol][mRow] != null) {
					if (gemGrid[mCol][mRow].type == gem.type && !gemGrid[mCol][mRow].isMatch && !gemGrid[mCol][mRow].isDropping) {
						gemGrid[mCol][mRow].isMatch = true;
						match.push(gemGrid[mCol][mRow]);
						}else {
							break;
							}
					mCol++;
					mRow++;
					}
				}
			
			function downLeft():void {
				//trace("downLeft");
				while (mCol > -1 && mRow <= (rows - 1) && gemGrid[mCol][mRow] != null) {
					if (gemGrid[mCol][mRow].type == gem.type && !gemGrid[mCol][mRow].isMatch && !gemGrid[mCol][mRow].isDropping) {
						gemGrid[mCol][mRow].isMatch = true;
						match.push(gemGrid[mCol][mRow]);
						}else {
							break;
							}
					mCol--;
					mRow++;
					}
				}
			
			function upLeft():void {
				//trace("upLeft");
				while (mCol > -1 && mRow > -1 && gemGrid[mCol][mRow] != null) {
					if (gemGrid[mCol][mRow].type == gem.type && !gemGrid[mCol][mRow].isMatch && !gemGrid[mCol][mRow].isDropping) {
						gemGrid[mCol][mRow].isMatch = true;
						match.push(gemGrid[mCol][mRow]);
						}else {
							break;
							}
					mCol--;
					mRow--;
					}
				}
			
			function upRight():void {
				//trace("upRight");
				while (mCol > (columns - 1) && mRow > -1 && gemGrid[mCol][mRow] != null) {
					if (gemGrid[mCol][mRow].type == gem.type && !gemGrid[mCol][mRow].isMatch && !gemGrid[mCol][mRow].isDropping) {
						gemGrid[mCol][mRow].isMatch = true;
						match.push(gemGrid[mCol][mRow]);
						}else {
							break;
							}
					mCol++;
					mRow--;
					}
				}
			
			if (match.length < 2) {
				gem.isMatch = false;
				var g:int;
				for (g = 0; g < match.length; g++ ) {
					(match[g] as BaseGem).isMatch = false;
					}
				}
			if (match.length >= 2) { match.push(gem); }
			//trace("comb: " + comb);
			return match;
			}
		//
		private function getAllMatch():void {
			var col:int;
			var row:int;
			var matchHorizont:Array = [];
			var matchVertical:Array = [];
			var matchDiagonal:Array = [];
			//
			for (col = 0; col < gemGrid.length; col++ ) {
				for (row = 0; row < gemGrid[col].length; row++ ) {
					var gem:BaseGem;
					if (gemGrid[col][row] && !gemGrid[col][row].isMatch && !gemGrid[col][row].isDropping) {
						gem = gemGrid[col][row];
						
						matchHorizont = getMatchHorizont(gem.col, gem.row, gem);
						if (matchHorizont.length > 2) {
							matchArray.push(matchHorizont);
							//continue;
							}
						
						matchVertical = getMatchVertical(gem.col, gem.row, gem);
						if (matchVertical.length > 2) {
							matchArray.push(matchVertical);
							//continue;
							}
						
						matchDiagonal = getMatchDiagonal(gem.col, gem.row, gem);
						if (matchDiagonal.length > 2) {
							matchArray.push(matchDiagonal);
							//continue;
							}
						}
					}
				}
			
			if (matchArray.length > 0) {
				removeMatch();
				}
			}
		//
		private function randomNumber(low:Number = 0, high:Number = 1):Number {
			return Math.floor(Math.random() * (1 + high - low)) + low;
			}
		//
		private function removeMatch(e:TimerEvent = null):void {
			//if (e == null) {
				var s:int;
				if (isSwapComplete && swapMatchArray.length > 0) {
					for (s = 0; s < swapMatchArray.length; s++ ) {
						gemGrid[swapMatchArray[s].col][swapMatchArray[s].row] = null;
						(swapMatchArray[s] as BaseGem).destroy(s);
						affectAbove(swapMatchArray[s].col, swapMatchArray[s].row);
						}
					score.addScore(int((swapMatchArray.length - 1) * 10));
					swapMatchArray = [];
					}
				//}else {
					var m:int;
					var p:int;
					var part:Array = [];
					if (matchArray.length > 0) {
						
						//part = matchArray.shift();
						
						/*var line:Sprite = new Sprite();
						line.graphics.lineStyle(3, (Math.round( Math.random() * 0xFFFFFF )));
						line.graphics.beginFill(0xFFFFFF);
						line.graphics.moveTo(part[0].x, part[0].y);
						addChild(line);*/
						
						for (m = 0; m < matchArray.length; m++ ) {
							part = matchArray[m];
							for (p = 0; p < part.length; p++ ) {
								//line.graphics.drawCircle(part[g].x + 32, part[g].y + 32, 20);
								gemGrid[part[p].col][part[p].row] = null;
								(part[p] as BaseGem).destroy(p);
								affectAbove(part[p].col, part[p].row);
								}
							}
							
						matchArray = [];
						//line.graphics.endFill();
						//
						score.addScore(int((part.length - 1) * 10));
						}else {
							getAllMatch();
							}
					//}
			}
		//
	}
}