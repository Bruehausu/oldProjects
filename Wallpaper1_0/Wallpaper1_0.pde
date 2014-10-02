
//recursive class that are represented by cicles in-render
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
    float inc = 40.0;
    float r = red(c);
    float g = green(c)-inc;
    float b = blue(c)-inc;
    // base case: when the colour is close to true red, no recusion
    // is called
    if( b >= 10){
      // creates connected nodes based off of current node
      hasChildren = true;
      child1 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
      child2 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
      child3 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius); 
    } else {
      hasChildren = false; 
    }
  }
  
  //pre-updates a node with the movement of a parent node, and
  //feeds that information to its children
  void predate(float x, float y){
    xpos += x;
    ypos += y;
    if(hasChildren) {
      child1.predate(x,y);
      child2.predate(x,y);
      child3.predate(x,y);
    }
  }  
  
  //couses random movement in the node, and feeds that movement to
  //its children, as well as causing them to update
  void update() {
    float x = random(-2,2);
    float y = random(-5,5);
    xpos += x;
    ypos += y;
    if(hasChildren) {
      child1.predate(x,y);
      child2.predate(x,y);
      child3.predate(x,y);
      child1.update();
      child2.update();
      child3.update();
    }
  }
  
  //draws the red circles and connecting lines
  void display() {
    if(hasChildren) {
      stroke(1);
      line(xpos,ypos,child1.xpos,child1.ypos);
      line(xpos,ypos,child2.xpos,child2.ypos);
      line(xpos,ypos,child3.xpos,child3.ypos);
      child1.display();
      child2.display();
      child3.display();
    }
    noStroke();
    fill(c);
    ellipse(xpos,ypos,radius,radius);
  }
}



// class for the root node - similar to Nodes, but static - 
// not nescesarry, could be streamlined into the Node class
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
    float inc = 40.0;
    float r = red(c);
    float g = green(c)-inc;
    float b = blue(c)-inc;
    child1 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
    child2 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius);
    child3 = new Node(color(r,g,b),(xpos+random(0,width/5)),
                      (ypos+random(-(width/5),width/5)),radius);                     
    
  }
  
  void update() {
    child1.update();
    child2.update();
    child3.update();
  }
  
  void display() {
    line(xpos,ypos,child1.xpos,child1.ypos);
    line(xpos,ypos,child2.xpos,child2.ypos);
    line(xpos,ypos,child3.xpos,child3.ypos);
    child1.display();
    child2.display();
    child3.display();
    noStroke();
    fill(c);
    ellipse(xpos,ypos,radius,radius);
    stroke(1);
  }
}

Root progen;

//
void setup() {
  size(1080,720);
  progen = new Root(color(240,240,240), float(width/20), float(height/2),35);
}



void draw() {
  background(255);
  progen.update();
  progen.display();
}
