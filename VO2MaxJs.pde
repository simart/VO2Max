Slider ageSlider, timeSlider, bmiSlider;
boolean male = false;
int minutes = 10;
int seconds = 0;
int totalSeconds = minutes*60+seconds;
int age = 15;
float bmi = 18.2;
int sliderTall = 350;
int sliderSpacing = 70;
int sliderWidth = 25;
int sliderTop = 80;
void setup()
{
  size(640, 480);
  ageSlider = new Slider(""+age, 5, 18, age, 20, sliderTop, sliderWidth, sliderTall);
  timeSlider = new Slider(minutes + "\'" + " " + seconds + "\"", 5*60, 20*60, totalSeconds, 20+sliderSpacing, sliderTop, sliderWidth, sliderTall);
  bmiSlider = new Slider(""+bmi, 12, 45, bmi, 20+8*sliderSpacing/3, sliderTop, sliderWidth, sliderTall); 
}
void draw()
{
  background(150);
  textSize(24);
  ageSlider.show();
  timeSlider.show();
  bmiSlider.show();
  int fem = 0;
  if (male)
  {
    rect(5, 10, 65, 45);
    fill(0);
    text("Male", 10, 40);
    if (mouseX >= 85 && mouseX <= 175 && mouseY >= 10 && mouseY <= 55)
      fill(200);
    else
      fill(175);
    text("Female", 90, 40);
    fem = 1;
  }
  else
  {
    rect(85, 10, 90, 45);
    if (mouseX >= 5 && mouseX <= 70 && mouseY >= 10 && mouseY <= 55)
      fill(200);
    else
      fill(175);
    text("Male", 10, 40);
    fill(0);
    
    text("Female", 90, 40);
  }
  float vo2max = 0.21 * age * fem - 0.84 * bmi - 8.41 * totalSeconds/60.0 + 
    0.34 * totalSeconds/60.0 * totalSeconds/60.0 + 108.94;
    
    fill(200);
    text("Age",13,460);
    text("Time",80,460);
    text("BMI",200,460);
    textSize(32);
  text("VO2Max = " + int(vo2max*10)/10.0, 300, 150);
}
void mouseDragged()
{
  if (timeSlider.adjust())
  {  
    minutes = (int)(timeSlider.value())/60;
    seconds = (int)(timeSlider.value())%60;
    totalSeconds = minutes*60+seconds;
    timeSlider.setValueLabel((int)minutes + "\'" + " " + (int)seconds + "\"");
  }
  else if (bmiSlider.adjust())
  {
    bmiSlider.setValueLabel(""+ (int(bmiSlider.value()*10))/10.0);
    bmi = bmiSlider.value();
  }
  else if (ageSlider.adjust())
  {
    if (ageSlider.value() == 18)
      ageSlider.setValueLabel("18+");
    else
      ageSlider.setValueLabel("" + int(ageSlider.value()));
    age = int(ageSlider.value());
  }
}
void mousePressed()
{
  if (mouseX >= 85 && mouseX <= 175 && mouseY >= 10 && mouseY <= 55)
    male = false;
  else if (mouseX >= 5 && mouseX <= 70 && mouseY >= 10 && mouseY <= 55)
    male = true;
}
class Slider
{
  String name;
  float mn, mx, val;
  int nX, nY, nW, nH, smallRectHeight, smallRectY;
  Slider(String theName, float theMin, float theMax, 
  float theDefaultValue, int theX, int theY, int theW, int theH)
  {
    name = theName;
    mn = theMin;
    mx = theMax;
    val = theDefaultValue;
    nX = theX;
    nY = theY;
    nW = theW;
    nH = theH;
    smallRectHeight = int(nH*(val-mn)/(mx-mn));
    smallRectY = nY + nH - smallRectHeight;
  }
  void show()
  {
    fill(70);
    rect(nX, nY, nW, nH);
    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH)
      fill(225);
    else
      fill(200);
    rect(nX, smallRectY, nW, smallRectHeight);
    text(name, nX+nW+5, smallRectY);
    fill(200);
  }
  void setValueLabel(String s)
  {
    name = s;
  }
  float value()
  {
    return val;
  }
  void setValue(float v)
  {
    val = v;
    if (val > mx )
      val = mx;
    if (val < mn)
      val = mn;
    adjust();
  }
  boolean adjust()
  {
    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH && mousePressed)
    {
      smallRectY = mouseY;
      smallRectHeight = nY + nH - smallRectY;
    }
    else
    {
      smallRectHeight = int(nH*(val-mn)/(mx-mn));
      smallRectY = nY + nH - smallRectHeight;
    }
    val = (smallRectHeight*(mx-mn)/nH)+mn;
    if (val > mx )
      val = mx;
    if (val < mn)
      val = mn;

    if (mouseX >= nX && mouseX <= nX + nW && mouseY>=nY && mouseY <= nY + nH && mousePressed)
      return true;
    else
      return false;
  }
}


