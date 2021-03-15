import java.io.FileNotFoundException;
import java.util.Scanner;

void loadColors()
{
  String[] lines = loadStrings("colors.csv");
  color[] colors = new color[lines.length];
  String[] temp;

  for (int i = 0; i < lines.length; i++)
  {
    temp = split(lines[i], ',');
    colors[i] = color(Integer.parseInt(temp[0]), Integer.parseInt(temp[1]), Integer.parseInt(temp[2]));
  }

  bgColor = colors[0];
  cursorColor = colors[1];
  textColor = colors[2];
  numberColor = colors[3];
  arithmeticOpColor = colors[4];
  logicalOpColor = colors[5];
  arrowColor = colors[6];
  ifColor = colors[7];
  stringColor = colors[8];
  stackOpColor = colors[9];
  outputOpColor = colors[10];
  bridgeColor = colors[11];
  getputColor = colors[12];
  inputOpColor = colors[13];
  endColor = colors[14];
  programCounterColor = colors[15];
}

void load_code()
{
  String[] lines = loadStrings(input_path.getText());
  grid_size_slider2d.setValueX(lines[0].length());
  grid_size_slider2d.setValueY(lines.length);
  grid.resize();
  
  for (int j = 0; j < lines.length; j++)
  {
    for (int i = 0; i < lines[j].length(); i++)
    {
      grid.cells[i][j].character = lines[j].charAt(i);
    }
  }
}

void save_code()
{
  PrintWriter output = createWriter("data/" + output_path.getText());
  for (int j = 0; j < grid.sizeY; j++)
  {
    for (int i = 0; i < grid.sizeX; i++)
    {
      output.print(grid.cells[i][j].character);
    }
    output.println();
  }
  output.flush();
  output.close();
}
