import java.util.Stack;
import java.util.Map;

public interface Command
{
  void invoke();
}

class InterpreterInstance
{
  Grid grid;

  Stack<Integer> stack;
  int stackSize;

  Cursor programCounter;

  boolean stringMode;
  boolean running;

  int delay;

  InterpreterInstance()
  {
    this.reset();
  }

  void reset()
  {
    this.grid = new Grid(GRID_SIZE_X, GRID_SIZE_Y);
    this.stack = new Stack<Integer>();
    this.stackSize = 0;
    this.programCounter = new Cursor();
    this.stringMode = false;
    this.running = true;
    this.delay = 1000;
  }

  void programLoop()
  {
    this.grid.render();
    this.grid.cells[this.programCounter.x][this.programCounter.y].bgCol = programCounterColor;
    this.grid.cells[this.programCounter.x][this.programCounter.y].fill = true;
    if (this.running)
    {
      if (this.delay <= 0)
      {
        this.running = this.forward() && this.running;
        this.delay = 1000;
        
        this.printStack();
      } else
      {
        this.delay -= pow(1.75, speed_slider.getValueI()) * 50;
      }
    }
  }
  
  void printStack()
  {
    Stack<Integer> tempstack = (Stack<Integer>)this.stack.clone();
    StringBuffer sbuf = new StringBuffer();
    for(int i = 0; i < 20 && i < this.stackSize; i++)
    {
      sbuf.append(str(i) + ": " + str(tempstack.pop()) + "\n");
    }
    stack_display.setText("Stack size: " + str(stackSize));
    stack_display.setText(sbuf.toString());
    stack_size_label.setText(str(this.stackSize));
  }
  
  void incrStackSize(int n)
  {
    // println("Incremented stack by " + str(n));
    this.stackSize += n;
  }

  boolean forward()
  {
    boolean ret = this.runInstruction(grid.cells[programCounter.x][programCounter.y].character);
    this.moveProgramCounter(true);
    return ret;
  }

  void moveProgramCounter(boolean forward)
  {
    int curDir = this.programCounter.dir.getValue();
    Direction tempDir = forward ? this.programCounter.dir : directions[curDir > 1 ? (curDir == 2 ? 3 : 2) : 1 - curDir];

    this.grid.cells[this.programCounter.x][this.programCounter.y].bgCol = bgColor;
    this.grid.cells[this.programCounter.x][this.programCounter.y].fill = false;

    switch(tempDir)
    {
    case UP: 
      if (this.programCounter.y - 1 >= 0)
        this.programCounter.y -= 1;
      else
        this.programCounter.y = this.grid.sizeY - 1;
      break;
    case DOWN: 
      if (this.programCounter.y + 1 < this.grid.sizeY)
        this.programCounter.y += 1;
      else
        this.programCounter.y = 0;
      break;
    case LEFT: 
      if (this.programCounter.x - 1 >= 0)
        this.programCounter.x -= 1;
      else
        this.programCounter.x = this.grid.sizeX - 1;
      break;
    case RIGHT: 
      if (this.programCounter.x + 1 < this.grid.sizeX)
        this.programCounter.x += 1;
      else
        this.programCounter.x = 0;
      break;
    }
    this.grid.cells[this.programCounter.x][this.programCounter.y].bgCol = programCounterColor;
  }

  boolean runInstruction(char opcode)
  {
    if (stringMode)
    {
      this.stack.push(int(opcode));
    } else
    {
      switch (opcode)
      {
      case '+': 
        this.add(); 
        break;
      case '-':
        this.sub();
        break;
      case '*':
        this.mul();
        break;
      case '/':
        this.div();
        break;
      case '%':
        this.mod();
        break;
      case '!':
        this.not();
        break;
      case '`':
        this.greaterThan();
        break;
      case '>':
        this.pc_set(Direction.RIGHT);
        break;
      case '<':
        this.pc_set(Direction.LEFT);
        break;
      case '^':
        this.pc_set(Direction.UP);
        break;
      case 'v':
        this.pc_set(Direction.DOWN);
        break;
      case '?':
        randomSeed(millis());
        this.pc_set(directions[(int)random(4)]);
        break;
      case '_':
        this.condition(2);
        break;
      case '|':
        this.condition(0);
        break;
      case '\"':
        this.stringModeToggle();
        break;
      case ':':
        this.duplicateTopStackValue();
        break;
      case '\\':
        this.swapTopStackValues();
        break;
      case '$':
        this.removeTopStackValue();
        break;
      case '.':
        this.outputAsInt();
        break;
      case ',':
        this.outputAsASCII();
        break;
      case '#':
        this.skip();
        break;
      case 'g':
        this.getCell();
        break;
      case 'p':
        this.putCell();
        break;
      case '&':
        this.inputInt();
        break;
      case '~':
        this.inputASCII();
        break;
      case '@':
        this.moveProgramCounter(false);
        return false;
      default:
        if (opcode >= '0' && opcode <= '9')
          this.pushInt(int(opcode - '0'));
        break;
      }
    }

    return true;
  }

  void add()
  {
    switch(stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.push(this.stack.pop());
      break;
    default:
      println(stack.size());
      this.stack.push(this.stack.pop() + this.stack.pop());
      this.incrStackSize(-1);
      break;
    }
  }

  void sub()
  {
    switch (stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.push(-this.stack.pop());
      break;
    default:
      this.stack.push(-this.stack.pop() + this.stack.pop());
      this.incrStackSize(-1);
      break;
    }
  }

  void mul()
  {
    switch(stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.pop();
      this.stack.push(0);
    default:
      this.stack.push(this.stack.pop() * this.stack.pop());
      this.incrStackSize(-1);
      break;
    }
  }

  void div()
  {
    switch(stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.pop();
      this.stack.push(0);
    default:
      this.stack.push(1/this.stack.pop() * this.stack.pop());
      this.incrStackSize(-1);
      break;
    }
  }

  void mod()
  {
    switch(stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.pop();
      this.stack.push(0);
      break;
    default:
      int a = this.stack.pop();
      int b = this.stack.pop();
      this.stack.push(b % a);
      this.incrStackSize(-1);
      break;
    }
  }

  void not()
  {
    if (stackSize > 0)
      this.stack.push(this.stack.pop() == 0 ? 1 : 0);
    else
    {
      this.stack.push(1);
      this.incrStackSize(1);
    }
  }

  void greaterThan()
  {
    switch(stackSize)
    {
    case 0:
      this.stack.push(0);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.push(this.stack.pop() < 0 ? 1 : 0);
      break;
    default:
      this.stack.push(this.stack.pop() < this.stack.pop() ? 1 : 0);
      this.incrStackSize(-1);
      break;
    }
  }

  void pc_set(Direction dir)
  {
    this.programCounter.dir = dir;
  }

  // Using the array of Direction enum values, offsetting by 0 uses vertical
  // and offsetting by 2 uses horizontal.
  void condition(int dirOffset)
  {
    if (this.stackSize > 0)
    {
      if (this.stack.pop() == 0)
        this.programCounter.dir = directions[dirOffset+1];
      else
        this.programCounter.dir = directions[dirOffset];

      incrStackSize(-1);
    } else
    {
      this.programCounter.dir = directions[dirOffset];
    }
  }

  void stringModeToggle()
  {
    this.stringMode = !this.stringMode;
  }

  void duplicateTopStackValue()
  {
    this.stack.push(this.stack.peek());
    this.incrStackSize(1);
  }

  void swapTopStackValues()
  {
    int a = this.stack.pop();
    int b = this.stack.pop();
    this.stack.push(a);
    this.stack.push(b);
  }

  void removeTopStackValue()
  {
    this.stack.pop();
    this.incrStackSize(-1);
  }

  void outputAsInt()
  {
    program_output.appendText(stack.pop().toString());
    this.incrStackSize(-1);
  }

  void outputAsASCII()
  {
    program_output.appendText(str((char)stack.pop().intValue()));
    this.incrStackSize(-1);
  }

  void skip()
  {
    moveCursor(this.programCounter, true, programCounterColor);
  }

  void getCell()
  {
    switch (stackSize)
    {
    case 0:
      this.stack.push((int)this.grid.cells[0][0].character);
      this.incrStackSize(1);
      break;
    case 1:
      this.stack.push((int)this.grid.cells[0][this.stack.pop()].character);
      break;
    default:
      int y = this.stack.pop();
      int x = this.stack.pop();
      this.stack.push((int)this.grid.cells[x][y].character);
      this.incrStackSize(-1);
      break;
    }
  }

  void putCell()
  {
    int x;
    int y;
    char v;
    switch (stackSize)
    {
    case 0:
      this.grid.cells[0][0].character = 0;
      break;
    case 1:
      this.grid.cells[0][this.stack.pop()].character = 0;
      this.incrStackSize(-1);
      break;
    case 2:
      y = this.stack.pop();
      x = this.stack.pop();
      this.grid.cells[x][y].character = 0;
      this.incrStackSize(-2);
      break;
    default:
      y = this.stack.pop();
      x = this.stack.pop();
      v = Integer.toString(this.stack.pop()).charAt(0);
      this.grid.cells[x][y].character = v;
      this.incrStackSize(-3);
      break;
    }
  }

  void inputInt()
  {
    this.running = false;
    program_int_input.setText("");
    program_int_input.setVisible(true);
    program_int_input.setEnabled(true);
  }

  void inputASCII()
  {
    this.running = false;
    program_char_input.setText("");
    program_char_input.setVisible(true);
    program_char_input.setEnabled(true);
  }

  void pushInt(int val)
  {
    this.stack.push(val);
    this.incrStackSize(1);
  }
}
