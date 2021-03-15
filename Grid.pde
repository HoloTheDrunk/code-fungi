class Grid
{
  Cell[][] cells;
  int sizeX;
  int sizeY;

  Grid(int x, int y)
  {
    this.sizeX = x;
    this.sizeY = y;

    this.newCells(this.sizeX, this.sizeY);
  }

  void newCells(int x, int y)
  {
    this.cells = new Cell[this.sizeX][this.sizeY];
    for (int i = 0; i < this.sizeX; i++)
      for (int j = 0; j < this.sizeY; j++)
        this.cells[i][j] = new Cell();
  }

  void render()
  {
    pushMatrix();

    if (run_checkbox.isSelected())
      stroke(cursorColor);
    else
      stroke(programCounterColor);

    noFill();
    rect(0, 0, this.cells.length * CELLSIZE, this.cells[0].length * CELLSIZE);
    noStroke();

    for (int i = 0; i < this.cells.length; i++)
    {
      for (int j = 0; j < this.cells[i].length; j++)
      {
        // println(str(this.sizeX) + "x" + str(this.sizeY) + " | " + str(i) + ", " + str(j));
        if (this.cells[i][j].fill)
        {
          fill(this.cells[i][j].bgCol);
          rect(i*CELLSIZE, j*CELLSIZE, CELLSIZE, CELLSIZE);
        }
        //else
        //  continue;
        fill(charToColor(this.cells[i][j].character));
        if (this.cells[i][j].character != ' ')
          text(this.cells[i][j].character, (i+.5)*CELLSIZE, (j+.25)*CELLSIZE);
      }
    }

    popMatrix();
  }

  void resize()
  {
    Cell[][] newCells = new Cell[grid_size_slider2d.getValueXI()][grid_size_slider2d.getValueYI()];
    
    int newSizeX = grid_size_slider2d.getValueXI();
    int newSizeY = grid_size_slider2d.getValueYI();
   
    // println(str(newSizeX) + "x" + str(newSizeY));
    
    for (int i = 0; i < newSizeX; i++)
    {
      for (int j = 0; j < newSizeY; j++)
      {
        newCells[i][j] = new Cell();
      }
    }
    
    // println("yolo");
    
    int maxSizeX = newSizeX > this.sizeX ? this.sizeX : newSizeX;
    int maxSizeY = newSizeY > this.sizeY ? this.sizeY : newSizeY;

    for (int i = 0; i < maxSizeX; i++)
    {
      for (int j = 0; j < maxSizeY; j++)
      {
        // println(str(i) + ", " + str(j));
        newCells[i][j] = this.cells[i][j];
      }
    }
    
    this.sizeX = newSizeX;
    this.sizeY = newSizeY;
    
    this.cells = newCells.clone();
  }

  void replaceChar(char c)
  {
    cells[editorCursor.x][editorCursor.y].character = c;
  }
}
