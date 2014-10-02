class Bar{ //class for each of the neon bars that for the fave
  color c;
  int sX;
  int sY;
  int eX;
  int eY;
  float var;
  
  Bar(color tempC,int tempSx, int tempSy, int tempEx, int tempEy){
    c = tempC;
    sX = tempSx;
    sY = tempSy;
    eX = tempEx;
    eY = tempEy;
    var = 0.0;
  }
  void update(){
    
  }
  // randomly moves the bar based on the amount of chosen variance,
  // then draws the line
  void display(){ 
    int tsx = sX + int(random(-var, var));
    int tsy = sY + int(random(-var, var));
    int tex = eX + int(random(-var, var));
    int tey = eY + int(random(-var, var));
    strokeWeight(1);
    stroke(c);
    line(tsx, tsy, tex, tey);
    strokeWeight(4); //second low-alpha line imitates a glow
    stroke(c,100);
    line(tsx, tsy, tex, tey);
  }
  //feeds a new colour and movement cariance from a mouse click
  void updateCol(color newC, float newVar){
     c = newC; 
     var = newVar;
  }
}

//these are the 2 sets of bars that equate to 2 light sources
ArrayList<Bar> hiBars; 
ArrayList<Bar> loBars;

void setup(){
  size(600,800);
  hiBars = new ArrayList<Bar>();
  loBars = new ArrayList<Bar>();
  color cLo = color(255,0,0);
  color cHi = color(250,250,250);
  
  // adding the bars themselves
  loBars.add(new Bar(cLo, 150,200, 275,200));
  loBars.add(new Bar(cLo, 325,200, 450,200));
  loBars.add(new Bar(cLo, 240,450, 360,450));  
  
  hiBars.add(new Bar(cHi, 310,245, 335,370));
  hiBars.add(new Bar(cHi, 260,490, 340,490)); 
  hiBars.add(new Bar(cHi, 220,220, 220,235)); 
  hiBars.add(new Bar(cHi, 390,220, 390,235));
}

void draw(){
  background(30);
  Bar bar;
  for (int i = hiBars.size()-1; i >= 0; i--) {
    bar = hiBars.get(i);
    bar.update();
    bar.display();
  }
  for (int i = loBars.size()-1; i >= 0; i--) {
    bar = loBars.get(i);
    bar.update();
    bar.display();
  }
}

//returns a clolour with net brightness (r+g+b) higher than cs
color brighter(color c){
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  //rgb values are cycled to give color variance
  return color(random(g,255),random(r,255),random(b,255));
}

// creates new color choices and shake variance on click
void mousePressed(){
  color newLo = color(random(255),random(255),random(255));
  color newHi = brighter(newLo);
  int var = 20;
  Bar bar;
  for (int i = hiBars.size()-1; i >= 0; i--) {
    bar = hiBars.get(i);
    bar.updateCol(newLo, random(var));
  }
  for (int i = loBars.size()-1; i >= 0; i--) {
    bar = loBars.get(i);
    bar.updateCol(newHi, random(var));
  }
  
  
}
