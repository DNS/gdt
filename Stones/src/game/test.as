package game 
{
	/**
	 * ...
	 * @author danil.ostroushko@gmail.com
	 */
	import game.gems.BaseGem;
	import game.gems.Gem1;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class test extends Sprite 
	{
		private var isPause:Boolean = false;
		
		private var gems_array:Array = new Array();
		private var dead_blocks:Array = new Array();
		//private var aGem:Gem1;
		private var aGem:Sprite;
		private var selectorBox:Sprite = new Sprite();
		private var selectorRow:int = -10;
		private var selectorColumn:int = -10;
		private var red:uint = 0xFF0000;
		private var green:uint = 0xFF00;
		private var blue:uint = 0xFF;
		private var yellow:uint = 0xFFFF00;
		private var cyan:uint = 0xFFFF;
		private var magenta:uint = 0xFF00FF;
		private var white:uint = 0xFFFFFF;
		private var colours_array:Array = new Array(red, green, blue, yellow, cyan, magenta, white);
		private var clickPossible:Boolean = true;
		private var score_txt:TextField = new TextField();
		private var hint_txt:TextField = new TextField();
		private var score:uint = 0;
		private var inaRow:uint = 0;
		private var match:Boolean = true;
		private var rows:int = 8;
		private var columns:int = 8;
		//
		public function test() 
		{
			addEventListener(Event.ADDED_TO_STAGE, startGame);
		}
		//
		public function startGame(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, startGame);
			// Game initiation
			dead_blocks.push("0_0");
			dead_blocks.push("0_1");
			dead_blocks.push("0_6");
			dead_blocks.push("0_7");
			dead_blocks.push("3_0");
			dead_blocks.push("3_1");
			dead_blocks.push("3_6");
			dead_blocks.push("3_7");
			dead_blocks.push("5_3");
			dead_blocks.push("5_5");
			// Create and style score text
			addChild(score_txt);
			score_txt.textColor = 0xFFFFFF;
			score_txt.x = rows * 60 + 50;
			// Create and style hint text
			addChild(hint_txt);
			hint_txt.textColor = 0xFFFFFF;
			hint_txt.x = rows * 60 + 100;
			// Create Gems in rows and columns
			for (var i:uint = 0; i < rows; i++) 
			{
				gems_array[i] = new Array();
				for (var j:uint = 0; j < columns; j++) 
				{
					if (dead_blocks.indexOf(i.toString() + "_" + j.toString(), 0) == -1)
					{
						do 
						{
							gems_array[i][j] = Math.floor(Math.random() * 7);
						}
						while (rowLineLength(i, j) > 2 || columnLineLength(i, j) > 2);
						//aGem = new Gem1();
						//aGem.init("gem1");

						aGem = new Sprite();
						aGem.graphics.beginFill(colours_array[gems_array[i][j]]);
						aGem.graphics.drawCircle(30, 30, 29);
						aGem.graphics.endFill();
						aGem.name = i + "_" + j;
						aGem.x = j * 60;
						aGem.y = i * 60;
						addChild(aGem);
					}
					else
						gems_array[i][j] = - 1000;
				}
			}
			// Create and style selector box
			addChild(selectorBox);
			selectorBox.graphics.lineStyle(2, red, 1);
			selectorBox.graphics.drawRect(0, 0, 60, 60);
			selectorBox.visible = false;
			// Listen for user input
			stage.addEventListener(MouseEvent.CLICK, onClick);
 
			addEventListener(Event.ENTER_FRAME, everyFrame);
		}
		//
		public function pauseGame():void 
		{
			isPause = !isPause;
			if (isPause)
				removeEventListener(Event.ENTER_FRAME, everyFrame);
			else 
				addEventListener(Event.ENTER_FRAME, everyFrame);
		}
		
		// Every frame...
		private function everyFrame(e:Event):void 
		{
			//Assume that gems are not falling
			var gemsAreFalling:Boolean = false;
			// Check each gem for space below it
			for (var i:int = rows - 2; i >= 0; i--)
			{
				for (var j:uint = 0; j < columns; j++) 
				{
					// If a spot contains a gem, and has an empty space below...
					if (gems_array[i][j] != -1 && gems_array[i][j] != - 1000 && gems_array[i + 1][j] == -1) 
					{
						// Set gems falling
						gemsAreFalling = true;
						gems_array[i + 1][j] = gems_array[i][j];
						gems_array[i][j] = -1;
						getChildByName(i + "_" + j).y += 60;
						getChildByName(i + "_" + j).name = (i + 1) + "_" + j;
						break;
					}
				}
				// If a gem is falling
				if (gemsAreFalling)
					// don't allow any more to start falling
					break;
			}
			
			for (i = rows - 2; i >= 0; i--)
			{
				// If a spot contains a gem, and has an empty space oposit...
				for (var z:uint = 0; z < dead_blocks.length; z++)
				{
					var cd:Array = dead_blocks[z].split("_");
					if (int(cd[1]) < columns && gems_array[i][int(cd[1]) + 1] != -1 && gems_array[i][int(cd[1])] == -1 && 
						i > int(cd[0]) && (columns / 2 - 1 - int(cd[1])) >= 0)
					{
						// Set gems falling
						gemsAreFalling = true;
						gems_array[i][int(cd[1])] = gems_array[i][int(cd[1]) + 1];
						gems_array[i][int(cd[1]) + 1] = -1;
						getChildByName(i + "_" + (int(cd[1]) + 1)).x -= 60;
						getChildByName(i + "_" + (int(cd[1]) + 1)).name = i + "_" + int(cd[1]);
						break;
					}
					else if (int(cd[1]) > 0 && gems_array[i][int(cd[1]) - 1] != -1 && gems_array[i][int(cd[1])] == -1 && 
							i > int(cd[0]) && (columns / 2 - 1 - int(cd[1])) < 0)
					{
						// Set gems falling
						gemsAreFalling = true;
						gems_array[i][int(cd[1])] = gems_array[i][int(cd[1]) - 1];
						gems_array[i][int(cd[1]) - 1] = -1;
						getChildByName(i + "_" + (int(cd[1]) - 1)).x += 60;
						getChildByName(i + "_" + (int(cd[1]) - 1)).name = i + "_" + int(cd[1]);
						break;
					}
				}
				if (gemsAreFalling)
					// don't allow any more to start falling
					break;
			}
			// If no gems are falling
			if (! gemsAreFalling) 
			{
				// Assume no new gems are needed
				var needNewGem:Boolean = false;
				// but check all spaces...
				for (i = rows - 1; i >= 0; i--) 
				{
					for (j = 0; j < columns; j++) 
					{
						// and if a spot is empty
						if (gems_array[i][j] == -1) 
						{
							var isDeadBlock:Boolean = false;
							for (z = 0; z < dead_blocks.length; z++)
							{
								cd = dead_blocks[z].split("_");
								if ( i > int(cd[0]) && j == int(cd[1]))
									isDeadBlock = true;
							}
							if (!isDeadBlock)
							{
								// now we know we need a new gem
								needNewGem = true;
								// pick a random color for the gem
								gems_array[0][j] = Math.floor(Math.random() * 7);
								// create the gem
								//aGem = new Gem1();
								//aGem.init("gem1");
								aGem = new Sprite();
								aGem.graphics.beginFill(colours_array[gems_array[0][j]]);
								aGem.graphics.drawCircle(30, 30, 29);
								aGem.graphics.endFill();
								// ID it
								aGem.name = "0_" + j;
								// position it
								aGem.x = j * 60;
								aGem.y = 0;
								// show it
								addChild(aGem);
								// stop creating new gems
								break;
							}
						}
					}
					// if a new gem was created, stop checking
					if (needNewGem)
						break;
				}
				// If no new gems were needed...
				if (! needNewGem) 
				{
					// assume no more/new lines are on the board
					var moreLinesAvailable:Boolean = false;
					// check all gems
					for (i = rows - 1; i >= 0; i--)
					{
						for (j = 0; j < columns; j++)
						{
							// if a line is found
							if (rowLineLength(i, j) > 2 || columnLineLength(i, j) > 2) 
							{
								// then we know more lines are available
								moreLinesAvailable = true;
								// creat a new array, set the gem type of the line, and where it is
								var lineGems:Array = [i + "_" + j];
								var gemType:uint = gems_array[i][j];
								var linePosition:int;
								// check t's a horizontal line...
								if (rowLineLength(i, j) > 2) 
								{
									// if so, find our how long it is and put all the line's gems into the array
									linePosition=j;
									while (sameGemIsHere(gemType, i, linePosition - 1)) 
									{
										linePosition--;
										lineGems.push(i + "_" + linePosition);
									}
									linePosition = j;;
									while (sameGemIsHere(gemType, i, linePosition + 1)) 
									{
										linePosition++;
										lineGems.push(i + "_" + linePosition);
									}
								}
								// check t's a vertical line...
								if (columnLineLength(i, j) > 2) 
								{
									// if so, find our how long it is and put all the line's gems into the array
									linePosition=i;
									while (sameGemIsHere(gemType, linePosition - 1, j)) 
									{
										linePosition--;
										lineGems.push(linePosition + "_" + j);
									}
									linePosition=i;
									while (sameGemIsHere(gemType, linePosition + 1, j)) 
									{
										linePosition++;
										lineGems.push(linePosition + "_" + j);
									}
								}
								// for all gems in the line...
								for (i = 0; i < lineGems.length; i++) 
								{
									// remove it from the program
									removeChild(getChildByName(lineGems[i]));
									// find where it was in the array
									cd = lineGems[i].split("_");
									// set it to an empty gem space
									gems_array[cd[0]][cd[1]] = -1;
									// set the new score
									score += inaRow;
									// set the score setter up
									inaRow++;
								}
								// if a row was made, stop the loop
								break;
							}
						}
						// if a line was made, stop making more lines
						if (moreLinesAvailable)
							break;
					}
					// if no more lines were available...
					if (! moreLinesAvailable) 
					{
						// allow new moves to be made
						clickPossible = true;
						// remove score multiplier
						inaRow = 0;
					}
				}
			}
			// display new score
			score_txt.text = score.toString();
		}
		//
		// When the user clicks
		private function onClick(e:MouseEvent):void 
		{
			// If a click is allowed
			if (clickPossible) 
			{
				// If the click is within the game area...
				if (mouseX < columns * 60 && mouseX > 0 && mouseY < rows * 60 && mouseY > 0)
				{
					// Find which row and column were clicked
					var clickedRow:uint = Math.floor(mouseY / 60);
					var clickedColumn:uint = Math.floor(mouseX / 60);
					hint_txt.text = gems_array[clickedRow][clickedColumn];
					//(getChildByName(clickedRow + "_" + clickedColumn) as BaseGem).select();
					if (gems_array[clickedRow][clickedColumn] != - 1000)
					{
						// Check if the clicked gem is adjacent to the selector
						// If not...
						if (!(((clickedRow == selectorRow + 1 || clickedRow == selectorRow - 1) && clickedColumn == selectorColumn) || ((clickedColumn == selectorColumn + 1 || clickedColumn == selectorColumn - 1) && clickedRow == selectorRow)))
						{
							// Find row and colum the selector should move to
							selectorRow = clickedRow;
							selectorColumn = clickedColumn;
							// Move it to the chosen position
							selectorBox.x = 60 * selectorColumn;
							selectorBox.y = 60 * selectorRow;
							// If hidden, show it.
							selectorBox.visible = true;
						}
						// If it is not next to it...
						else 
						{
							// Swap the gems;
							swapGems(selectorRow, selectorColumn, clickedRow, clickedColumn);
							// If they make a line...
							if (rowLineLength(selectorRow, selectorColumn) > 2 || columnLineLength(selectorRow, selectorColumn) > 2 || rowLineLength(clickedRow, clickedColumn) > 2 || columnLineLength(clickedRow, clickedColumn) > 2) 
							{
								// remove the hint text
								// dis-allow a new move until cascade has ended (removes glitches)
								clickPossible = false;
								// move and rename the gems
								getChildByName(selectorRow + "_" + selectorColumn).x = clickedColumn * 60;
								getChildByName(selectorRow + "_" + selectorColumn).y = clickedRow * 60;
								getChildByName(selectorRow + "_" + selectorColumn).name = "t";
								getChildByName(clickedRow + "_" + clickedColumn).x = selectorColumn * 60;
								getChildByName(clickedRow + "_" + clickedColumn).y = selectorRow * 60;
								getChildByName(clickedRow + "_" + clickedColumn).name = selectorRow + "_" + selectorColumn;
								getChildByName("t").name = clickedRow + "_" + clickedColumn;
								match = true;
							}
							// If not...
							else 
							{
								// Switch them back
								swapGems(selectorRow, selectorColumn, clickedRow, clickedColumn);
								match = false;
							}
							if (match) 
							{
								// Move the selector position to default
								selectorRow = -10;
								selectorColumn = -10;
								// and hide it
								selectorBox.visible = false;
							}
							else 
							{
								// Set the selector position
								selectorRow = clickedRow;
								selectorColumn = clickedColumn;
								// Move the box into position
								selectorBox.x = 60 * selectorColumn;
								selectorBox.y = 60 * selectorRow;
								match = false;
								// If hidden, show it.
								selectorBox.visible = true;
							}
						}
					}
					// If the click is outside the game area
					else 
					{
						// Move the selector position to default
						selectorRow = -10;
						selectorColumn = -10;
						// and hide it
						selectorBox.visible = false;
					}
				}
			}
		}
		//
		//Swap given gems
		private function swapGems(fromRow:uint, fromColumn:uint, toRow:uint, toColumn:uint):void 
		{
			//Save the original position
			var originalPosition:uint = gems_array[fromRow][fromColumn];
			//Move original gem to new position
			gems_array[fromRow][fromColumn] = gems_array[toRow][toColumn];
			//move second gem to saved, original gem's position
			gems_array[toRow][toColumn] = originalPosition;
		}
		//
		//Find out if there us a horizontal line
		private function rowLineLength(row:uint, column:uint):uint
		{
			var gemType:uint = gems_array[row][column];
			var lineLength:uint = 1;
			var checkColumn:int = column;
			//check how far left it extends
			while (sameGemIsHere(gemType, row, checkColumn - 1))
			{
				checkColumn--;
				lineLength++;
			}
			checkColumn = column;
			//check how far right it extends
			while (sameGemIsHere(gemType, row, checkColumn + 1))
			{
				checkColumn++;
				lineLength++;
			}
			// return total line length
			return (lineLength);
		}
		//
		//Find out if there us a vertical line
		private function columnLineLength(row:uint, column:uint):uint 
		{
			var gemType:uint = gems_array[row][column];
			var lineLength:uint = 1;
			var checkRow:int = row;
			//check how low it extends
			while (sameGemIsHere(gemType, checkRow - 1, column)) 
			{
				checkRow--;
				lineLength++;
			}
			//check how high it extends
			checkRow = row;
			while (sameGemIsHere(gemType, checkRow + 1, column)) 
			{
				checkRow++;
				lineLength++;
			}
			// return total line length
			return (lineLength);
		}
		//
		private function sameGemIsHere(gemType:uint, row:int, column:int):Boolean 
		{
			//Check there are gems in the chosen row
			if (gems_array[row] == null)
				return false;
			//If there are, check if there is a gem in the chosen slot
			if (gems_array[row][column] == null)
				return false;
			//If there is, check if it's the same as the chosen gem type
			return gemType == gems_array[row][column];
		}
	}
}