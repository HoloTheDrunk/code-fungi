import java.awt.event.KeyEvent;

void handleKeyboard()
{
  if (input_path.hasFocus() || output_path.hasFocus() ||
      program_int_input.hasFocus() || program_char_input.hasFocus())
    return;
  if (keyCode == 8 || keyCode == KeyEvent.VK_EXCLAMATION_MARK || keyCode >= 32 && keyCode <= 255 && keyCode != 130)
  {
    if (key >= ' ' && key <= '~' && // Normal range 
        (keyCode < KeyEvent.VK_NUMPAD0 || keyCode > KeyEvent.VK_NUMPAD9) && // No numpad
        key != '<' && key != '>' && key != '^' && key != 'v') // Arrow exceptions
    {
      grid.replaceChar(key);
      moveCursor(editorCursor, true, cursorColor);
    }
    if (key == CODED)
    {
      switch(keyCode)
      {
      case LEFT:
        editorCursor.dir = Direction.LEFT;
        updateCursorRel(editorCursor, -1, 0);
        break;
      case RIGHT:
        editorCursor.dir = Direction.RIGHT;
        updateCursorRel(editorCursor, 1, 0);
        break;
      case UP:
        editorCursor.dir = Direction.UP;
        updateCursorRel(editorCursor, 0, -1);
        break;
      case DOWN:
        editorCursor.dir = Direction.DOWN;
        updateCursorRel(editorCursor, 0, 1);
        break;
      }
    } else
      switch(keyCode)
    { 
    case 98: 
      editorCursor.dir = Direction.DOWN;
      grid.replaceChar('v');
      moveCursor(editorCursor, true, cursorColor);
      break;
    case 100: 
      editorCursor.dir = Direction.LEFT;
      grid.replaceChar('<');
      moveCursor(editorCursor, true, cursorColor);
      break;
    case 102: 
      editorCursor.dir = Direction.RIGHT;
      grid.replaceChar('>');
      moveCursor(editorCursor, true, cursorColor);
      break;
    case 104: 
      editorCursor.dir = Direction.UP;
      grid.replaceChar('^');
      moveCursor(editorCursor, true, cursorColor);
      break;
    }
    switch(key)
    {
    case '^': 
      editorCursor.dir = Direction.UP;
      grid.replaceChar(key);
      moveCursor(editorCursor, true, cursorColor);
      break;
    case 'v': 
      editorCursor.dir = Direction.DOWN;
      grid.replaceChar(key);
      moveCursor(editorCursor, true, cursorColor);
      break;
    case '<': 
      editorCursor.dir = Direction.LEFT;
      grid.replaceChar(key);
      moveCursor(editorCursor, true, cursorColor);
      break;
    case '>': 
      editorCursor.dir = Direction.RIGHT;
      grid.replaceChar(key);
      moveCursor(editorCursor, true, cursorColor);
      break;
    case BACKSPACE:
      grid.replaceChar(' ');
      moveCursor(editorCursor, false, cursorColor);
      break;
    case ENTER:
      if (editorCursor.dir == Direction.LEFT || editorCursor.dir == Direction.RIGHT)
        updateCursorRel(editorCursor, 0, 1);
      else if (editorCursor.dir == Direction.UP || editorCursor.dir == Direction.DOWN)
        updateCursorRel(editorCursor, 1, 0);
      break;
    }
  }
}

void specialKeyHandling(boolean pressed)
{
  if(key == CODED)
  {
    switch(keyCode)
    {
      case CONTROL:
        ctrl = pressed;
        break;
      case SHIFT:
        shift = pressed;
        break;
      case ALT:
        alt = pressed;
        break;
    }
  }
}
