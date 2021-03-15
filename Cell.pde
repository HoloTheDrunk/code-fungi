class Cell
{
  char character;
  color fgCol;
  color bgCol;
  boolean fill;
  
  Cell()
  {
    this.character = ' ';
    this.fgCol = color(255, 255, 255);
    this.bgCol = bgColor;
    fill = false;
  }
}

color charToColor(char c)
{
  switch(c)
  {
    case '+': case '-': case '*': case '/': case '%':
      return arithmeticOpColor;
    case '!': case '`':
      return logicalOpColor;
    case '>': case '<': case '^': case 'v': case '?':
      return arrowColor;
    case '_': case '|':
      return ifColor;
    case '\"':
      return stringColor;
    case ':': case '\\': case '$':
      return stackOpColor;
    case '.': case ',':
      return outputOpColor;
    case '#':
      return bridgeColor;
    case 'g': case 'p':
      return getputColor;
    case '&': case '~':
      return inputOpColor;
    case '@':
      return endColor;
  }
  
  if(c >= '0' && c <= '9')
    return numberColor;
  else
    return color(255);
}
