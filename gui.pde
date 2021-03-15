/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void save_button_clicked(GButton source, GEvent event) { //_CODE_:save_button:475024:
  println("save_button - GButton >> GEvent." + event + " @ " + millis());
  save_code();
} //_CODE_:save_button:475024:

public void load_button_clicked(GButton source, GEvent event) { //_CODE_:load_button:215198:
  println("load_button - GButton >> GEvent." + event + " @ " + millis());
  load_code();
} //_CODE_:load_button:215198:

public void input_path_changed(GTextField source, GEvent event) { //_CODE_:input_path:514421:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:input_path:514421:

public void output_path_changed(GTextField source, GEvent event) { //_CODE_:output_path:969312:
  println("output_path - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:output_path:969312:

public void program_char_input_changed(GTextField source, GEvent event) { //_CODE_:program_char_input:335332:
  // println("program_char_input - GTextField >> GEvent." + event + " @ " + millis());
  String text = source.getText();
  if (text.length() > 1)
  {
    interpreter.stack.push((int)text.charAt(0));
    interpreter.incrStackSize(1);
    
    source.setText("");
    source.setVisible(false);
    source.setEnabled(false);
    interpreter.running = true;
  }
} //_CODE_:program_char_input:335332:

public void program_int_input_changed(GTextField source, GEvent event) { //_CODE_:program_int_input:477745:
  // println("program_int_input - GTextField >> GEvent." + event + " @ " + millis());
  String text = source.getText();
  if (text.length() > 0 && text.charAt(text.length() - 1) == '$')
  {
    interpreter.stack.push(Integer.parseInt(text.substring(0, text.length() - 1)));
    interpreter.incrStackSize(1);
    
    source.setText("");
    source.setVisible(false);
    source.setEnabled(false);
    interpreter.running = true;
  }
} //_CODE_:program_int_input:477745:

public void run_checkbox_clicked(GCheckbox source, GEvent event) { //_CODE_:run_checkbox:243484:
  println("checkbox1 - GCheckbox >> GEvent." + event + " @ " + millis());
  //Not needed for now, maybe later so I'll keep it because time save
  //for (int i = 0; i < grid.sizeX; i++)
  //{
  //  for (int j = 0; j < grid.sizeY; j++)
  //  {
  //    grid.cells[i][j].fill = false;
  //  }
  //}
  if (source.isSelected())
  {
    grid_size_slider2d.setEnabled(false);
    grid_size_slider2d.setVisible(false);
    
    grid_size_slider2d_value.setEnabled(false);
    grid_size_slider2d_value.setVisible(false);
    
    output_path.setEnabled(false);
    output_path.setVisible(false);
    save_button.setEnabled(false);
    save_button.setVisible(false);
    
    input_path.setEnabled(false);
    input_path.setVisible(false);
    load_button.setEnabled(false);
    load_button.setVisible(false);
    
    interpreter.reset();
    interpreter.grid = grid;
    interpreter.grid.cells[editorCursor.x][editorCursor.y].fill = false;
  } else
  {
    grid_size_slider2d.setEnabled(true);
    grid_size_slider2d.setVisible(true);
    
    grid_size_slider2d_value.setEnabled(true);
    grid_size_slider2d_value.setVisible(true);
    
    output_path.setEnabled(true);
    output_path.setVisible(true);
    save_button.setEnabled(true);
    save_button.setVisible(true);
    
    input_path.setEnabled(true);
    input_path.setVisible(true);
    load_button.setEnabled(true);
    load_button.setVisible(true);
    
    grid.cells[interpreter.programCounter.x][interpreter.programCounter.y].fill = false;
    interpreter.grid.cells[editorCursor.x][editorCursor.y].fill = true;
  }
} //_CODE_:run_checkbox:243484:

public void speed_slider_changed(GSlider source, GEvent event) { //_CODE_:speed_slider:816919:
  println("speed_slider - GSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:speed_slider:816919:

public void stack_display_changed(GTextArea source, GEvent event) { //_CODE_:stack_display:350634:
  println("stack_display - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:stack_display:350634:

public void program_output_changed(GTextArea source, GEvent event) { //_CODE_:program_output:908418:
  println("program_output - GTextArea >> GEvent." + event + " @ " + millis());
} //_CODE_:program_output:908418:

public void grid_size_slider2d_changed(GSlider2D source, GEvent event) { //_CODE_:grid_size_slider2d:547517:
  println("grid_size_slider2d - GSlider2D >> GEvent." + event + " @ " + millis());
  if(!source.isDragging())
  {
    grid.resize();
  }
  grid_size_slider2d_value.setText(str(source.getValueXI()) + "x" + str(source.getValueYI()));
} //_CODE_:grid_size_slider2d:547517:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  G4P.setDisplayFont("Arial", G4P.PLAIN, 16);
  G4P.setInputFont("Arial", G4P.PLAIN, 16);
  G4P.setSliderFont("BLUE_SCHEME", G4P.PLAIN, 11);
  surface.setTitle("Sketch Window");
  save_button = new GButton(this, 1720, 980, 160, 60);
  save_button.setText("SAVE");
  save_button.addEventHandler(this, "save_button_clicked");
  load_button = new GButton(this, 1540, 980, 160, 60);
  load_button.setText("LOAD");
  load_button.addEventHandler(this, "load_button_clicked");
  input_path = new GTextField(this, 1540, 900, 160, 60, G4P.SCROLLBARS_HORIZONTAL_ONLY | G4P.SCROLLBARS_AUTOHIDE);
  input_path.setText("input.bf");
  input_path.setPromptText("Input file path");
  input_path.setOpaque(false);
  input_path.addEventHandler(this, "input_path_changed");
  output_path = new GTextField(this, 1720, 900, 160, 60, G4P.SCROLLBARS_HORIZONTAL_ONLY | G4P.SCROLLBARS_AUTOHIDE);
  output_path.setText("output.bf");
  output_path.setPromptText("Output file path");
  output_path.setOpaque(false);
  output_path.addEventHandler(this, "output_path_changed");
  program_char_input = new GTextField(this, 900, 520, 120, 30, G4P.SCROLLBARS_NONE);
  program_char_input.setPromptText("Input char");
  program_char_input.setOpaque(true);
  program_char_input.addEventHandler(this, "program_char_input_changed");
  program_int_input = new GTextField(this, 900, 520, 120, 30, G4P.SCROLLBARS_NONE);
  program_int_input.setPromptText("Input int");
  program_int_input.setOpaque(true);
  program_int_input.addEventHandler(this, "program_int_input_changed");
  run_checkbox = new GCheckbox(this, 1325, 940, 120, 20);
  run_checkbox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  run_checkbox.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  run_checkbox.setText("RUN MODE");
  run_checkbox.setLocalColorScheme(GCScheme.RED_SCHEME);
  run_checkbox.setOpaque(true);
  run_checkbox.addEventHandler(this, "run_checkbox_clicked");
  speed_slider = new GSlider(this, 1290, 990, 190, 30, 20.0);
  speed_slider.setShowValue(true);
  speed_slider.setShowLimits(true);
  speed_slider.setLimits(1, 0, 10);
  speed_slider.setNbrTicks(10);
  speed_slider.setStickToTicks(true);
  speed_slider.setShowTicks(true);
  speed_slider.setNumberFormat(G4P.INTEGER, 0);
  speed_slider.setOpaque(false);
  speed_slider.addEventHandler(this, "speed_slider_changed");
  stack_display = new GTextArea(this, 40, 660, 240, 380, G4P.SCROLLBARS_NONE);
  stack_display.setOpaque(true);
  stack_display.addEventHandler(this, "stack_display_changed");
  stack_size_label = new GLabel(this, 40, 640, 240, 20);
  stack_size_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  stack_size_label.setText("STACK SIZE: 0");
  stack_size_label.setOpaque(true);
  program_output = new GTextArea(this, 280, 660, 240, 380, G4P.SCROLLBARS_NONE);
  program_output.setOpaque(true);
  program_output.addEventHandler(this, "program_output_changed");
  program_output_label = new GLabel(this, 280, 640, 240, 20);
  program_output_label.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  program_output_label.setText("OUTPUT");
  program_output_label.setOpaque(true);
  grid_size_slider2d = new GSlider2D(this, 1540, 540, 340, 340);
  grid_size_slider2d.setLimitsX(80.0, 25.0, 256.0);
  grid_size_slider2d.setLimitsY(25.0, 25.0, 256.0);
  grid_size_slider2d.setNumberFormat(G4P.INTEGER, 0);
  grid_size_slider2d.setOpaque(true);
  grid_size_slider2d.addEventHandler(this, "grid_size_slider2d_changed");
  grid_size_slider2d_value = new GLabel(this, 1540, 520, 340, 20);
  grid_size_slider2d_value.setOpaque(true);
}

// Variable declarations 
// autogenerated do not edit
GButton save_button; 
GButton load_button; 
GTextField input_path; 
GTextField output_path; 
GTextField program_char_input; 
GTextField program_int_input; 
GCheckbox run_checkbox; 
GSlider speed_slider; 
GTextArea stack_display; 
GLabel stack_size_label; 
GTextArea program_output; 
GLabel program_output_label; 
GSlider2D grid_size_slider2d; 
GLabel grid_size_slider2d_value; 
