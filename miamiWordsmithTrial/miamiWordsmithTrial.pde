class Bar {
  int iX;
  int iY;
  int sX;
  int sY;
  int eX;
  int eY;
  color c;
  
  Bar(int tempiX, int tempiY, int tempSX, int tempSY, int tempEX, 
      int tempEY, color tempC){
    iX = tempiX;
    iY = tempiY;
    sX = tempSX;
    sY = tempSY;
    eX = tempEX;
    eY = tempEY;
    c = tempC;
  }
  
  void update(float mils){
    color newC = color(225*noise(iX/10.0,iY/10.0,mils),
                225*noise(iX/10.0,iY/10.0,mils+40),
                225*noise(iX/10.0,iY/10.0,mils+80));
    c = newC;
  }
  
  void display(){
    stroke(c);
    strokeWeight(2);
    line(sX,sY,eX,eY);
  }
}

ArrayList<Bar> bars;

void setup(){
  size(1000,600);
  bars = new ArrayList<Bar>();
  int dw = width/41;
  int dh = height/26;
  float z = millis()/1000.0;
  color c;
  for(int x = 1; x < 41; x++){
    for(int y = 1; y < 26; y++){
      c = color(225*noise(x/10.0 ,y/10.0,z),
                225*noise(x/10.0 ,y/10.0,z+40),
                225*noise(x/10.0 ,y/10.0,z+10));
      bars.add(new Bar(x,y,x*dw,y*dh,x*dw+5,y*dh+15,c));
    }
  }
}

void draw(){
  background(0);
  float mils = millis()/1000.0;
  for (int i = bars.size()-1; i >= 0; i--) {
    Bar bar = bars.get(i);
    bar.update(mils);
    bar.display();
  }
}
