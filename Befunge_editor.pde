import g4p_controls.*;

int CELLSIZE = 24;
int GRID_SIZE_X = 80;
int GRID_SIZE_Y = 25;

Grid grid;
Cursor editorCursor;

InterpreterInstance interpreter;

color bgColor;
color cursorColor;
color textColor;
color numberColor;
color arithmeticOpColor;
color logicalOpColor;
color arrowColor;
color ifColor;
color stringColor;
color stackOpColor;
color outputOpColor;
color bridgeColor;
color getputColor;
color inputOpColor;
color endColor;
color programCounterColor;

int time;
int cursorTimer;

PFont monoFont;

float xCodeOffset;
float yCodeOffset;

boolean ctrl = false;
boolean shift = false;
boolean alt = false;

public void setup()
{
  fullScreen(JAVA2D);

  createGUI();
  program_char_input.setVisible(false);
  program_int_input.setVisible(false);
  grid_size_slider2d_value.setText(str(GRID_SIZE_X) + "x" + str(GRID_SIZE_Y));

  loadColors();

  time = millis();

  grid = new Grid(GRID_SIZE_X, GRID_SIZE_Y);
  editorCursor= new Cursor(0, 0);

  interpreter = new InterpreterInstance();

  updateCursor(editorCursor, 0, 0);
  cursorTimer = 100;

  monoFont = createFont("JetBrainsMono-Regular.ttf", 32*height/1080);
  textFont(monoFont);
  textSize(24);
  textAlign(CENTER, CENTER);

  xCodeOffset = 0;
  yCodeOffset = 0;

  ctrl = false;
  shift = false;
  alt = false;
}

public void draw()
{
  background(25, 25, 50);

  pushMatrix();
  translate(xCodeOffset, yCodeOffset);
  if (run_checkbox.isSelected())
  {
    // text(interpreter.delay, width/2, height/2);
    interpreter.programLoop();
  } else
  {
    grid.render();
    blinkCursor(editorCursor, grid, cursorColor);

    if (ctrl && grid.cells[editorCursor.x][editorCursor.y].character != ' ')
      grid.replaceChar(' ');
  }
  popMatrix();

  time = millis();
}

public void mouseDragged()
{
  if (speed_slider.isDragging() || grid_size_slider2d.isDragging())
    return;
  xCodeOffset += (mouseX-pmouseX) / 2f;
  yCodeOffset += (mouseY-pmouseY) / 2f;
}

public void mouseClicked()
{
  if (!run_checkbox.isSelected())
    updateCursor(editorCursor);
}

public void keyPressed()
{
  if (!run_checkbox.isSelected())
  {
    specialKeyHandling(true);
    handleKeyboard();
  }
}

public void keyReleased()
{
  if (!run_checkbox.isSelected())
  {
    specialKeyHandling(false);
  }
}
