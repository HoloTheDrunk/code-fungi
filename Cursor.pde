enum Direction {
  UP(0), DOWN(1), LEFT(2), RIGHT(3);
  
  private final int value;
  private Direction(int value)
  {
    this.value = value;
  }
  
  public int getValue()
  {
    return value;
  }
};
Direction[] directions = Direction.values();

class Cursor
{
  int x;
  int y;

  Direction dir;

  Cursor()
  {
    this.x = 0;
    this.y = 0;
    this.dir = Direction.RIGHT;
  }

  Cursor(int x, int y)
  {
    this.x = x;
    this.y = y;
    this.dir = Direction.RIGHT;
  }

  void set(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
}

void updateCursor(Cursor cursor)
{
  pushMatrix();
  // TODO: Find out how to make clicking on cells work with scale.
  updateCursor(cursor, (int)((mouseX - xCodeOffset)/CELLSIZE), (int)((mouseY - yCodeOffset)/CELLSIZE));
  popMatrix();
}

void updateCursor(Cursor cursor, int x, int y)
{
  if (x >= 0 && x < grid.sizeX && y >= 0 && y < grid.sizeY)
  {
    grid.cells[cursor.x][cursor.y].fill = false;
    cursor.set(x, y);
    switchCursor(cursor);
    cursorTimer = 500;
    grid.cells[cursor.x][cursor.y].bgCol = cursorColor;
  }
}

void updateCursorRel(Cursor cursor, int xOffset, int yOffset)
{
  if (cursor.x + xOffset >= 0 && cursor.x + xOffset < grid.sizeX && cursor.y + yOffset >= 0 && cursor.y + yOffset < grid.sizeY)
  {
    grid.cells[cursor.x][cursor.y].fill = false;
    cursor.set(cursor.x + xOffset, cursor.y + yOffset);
    switchCursor(cursor);
    cursorTimer = 500;
    grid.cells[cursor.x][cursor.y].bgCol = cursorColor;
  }
}

void switchCursor(Cursor cursor)
{
  if (cursor.x >= 0 && cursor.x < grid.sizeX && cursor.y >= 0 && cursor.y < grid.sizeY)
    grid.cells[cursor.x][cursor.y].fill = !grid.cells[cursor.x][cursor.y].fill;
}

void blinkCursor(Cursor cursor, Grid grid, color col)
{
  if (cursorTimer < 0 && millis()%500 <= 50)
  {
    switchCursor(cursor);
    cursorTimer = 100;
  } else
  {
    cursorTimer -= millis() - time;
  }
  grid.cells[cursor.x][cursor.y].bgCol = col;
}

void moveCursor(Cursor cursor, boolean forward, color col)
{
  int curDir = cursor.dir.getValue();
  Direction tempDir = forward ? cursor.dir : directions[curDir > 1 ? (curDir == 2 ? 3 : 2) : 1 - curDir];

  grid.cells[cursor.x][cursor.y].fill = false;

  switch(tempDir)
  {
  case UP: 
    if (cursor.y - 1 >= 0)
      cursor.y -= 1;
    break;
  case DOWN: 
    if (cursor.y + 1 < grid.sizeY)
      cursor.y += 1;
    break;
  case LEFT: 
    if (cursor.x - 1 >= 0)
      cursor.x -= 1;
    break;
  case RIGHT: 
    if (cursor.x + 1 < grid.sizeX)
      cursor.x += 1;
    break;
  }
  switchCursor(cursor);
  cursorTimer = 500;
  grid.cells[cursor.x][cursor.y].bgCol = col;
}
