

class Node {
  color c;
  float xpos;
  float ypos;
  int radius;
  boolean hasChildren;
  Node child1;
  Node child2;
  Node child3;
  
  Node(color tempC, float tempXpos, float tempYpos, int tempRadius) {
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    radius = tempRadius;
    if( c == color(100,100,100)){
      hasChildren = true;
      child1 = new Node(color(200,200,200),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
      child2 = new Node(color(200,200,200),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
      child3 = new Node(color(200,200,200),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius); 
    } else {
      hasChildren = false; 
    }
  }
  
  void update() {
  }
  
  void display() {
    noStroke();
    fill(c);
    ellipse(xpos,ypos,radius,radius);
  }
}

class Root {
  color c;
  float xpos;
  float ypos;
  int radius;
  Node child1;
  Node child2;
  Node child3;
  
  Root(color tempC, float tempXpos, float tempYpos, int tempRadius) {
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    radius = tempRadius;
    //BREAK UP COLOR?
    child1 = new Node(color(100,100,100),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
    child2 = new Node(color(100,100,100),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
    child3 = new Node(color(100,100,100),(xpos+random(-(width/5),width/5)),
                      (ypos+random(-(width/5),width/5)),radius);                     
    
  }
  
  void update() {
  }
  
  void display() {
    stroke(0);
    fill(c);
    ellipse(xpos,ypos,radius,radius);
    child1.display();
    stroke(1);
    line(xpos,ypos,child1.xpos,child1.ypos);
    child2.display();
    stroke(1);
    line(xpos,ypos,child2.xpos,child2.ypos);
    child3.display();
    stroke(1);
    line(xpos,ypos,child3.xpos,child3.ypos);
  }
}

Root progen;

void setup() {
  size(500,500);
  progen = new Root(color(0,0,0), float(width/2), float(height/2),35);
}

void draw() {
  background(255);
  progen.update();
  progen.display();
}
