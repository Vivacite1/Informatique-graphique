PShape terrain;
PImage texture;
PShader myShader;

Pylone pyloneRef;
Eolienne eolienneRef;

PVector upAxis = new PVector(0, 0, 1);
PVector frontHorizontalAxis = new PVector(0, 1, 0);
PVector leftHorizontalAxis = new PVector(1, 0, 0);

PVector eyePos = new PVector(0, 0, 0);
PVector dirVue = new PVector(0, 1, 0);
PVector coordDevant = new PVector(0, 1, 0);
float verticalViewAngle = 0;

boolean showTerrain = true;
boolean shadersEnabled = true;
boolean showPylones = true;
boolean showLignes = true;
boolean showEoliennes = true;

//constantes
int moveSpeed = 10;
int frameSpeed = 20;
float rotaSpeed = PI/16.0;


public void setup() {
  size(800, 800, P3D);
  frameRate(frameSpeed);
  terrain = loadShape("hypersimple.obj");
  myShader = loadShader("FragmentShader.glsl", "VertexShader.glsl");
  texture = loadImage("StAuban_texture.jpg");
  texture.loadPixels();
  pyloneRef = new Pylone();
  eolienneRef = new Eolienne();
}

public void draw() {
  background(200);
  lights();
  
  translate(width/2, height/2, 0);
  
  camera(eyePos.x, eyePos.y, eyePos.z, coordDevant.x, coordDevant.y, coordDevant.z, -upAxis.x, -upAxis.y, -upAxis.z);
  perspective(PI/3.0, width/height, 1.0, (height/2.0) / tan(PI/3.0/2.0)*10.0);
  
  if (showTerrain) {
    if (shadersEnabled) {
      texture(texture);
      shader(myShader);
      myShader.set("u_texture", texture);
      shape(terrain);
      resetShader();
    } else shape(terrain);
  }
  
  if (showPylones) pyloneRef.placePylones(20, 100, 60, -115, showLignes);
  
  if (showEoliennes) eolienneRef.placeEoliennes(85, 120, 105, 75, 20, 100, pyloneRef);
  
  drawRepere();
  //drawReperePerso();
  println("eyePos : " + eyePos.x, eyePos.y, eyePos.z);
  println("angleVueVertical : " + verticalViewAngle);
  println("p : pylones | l : lignes elec | t : terrain | h : shaders | e : eoliennes");
}





void keyPressed() {
  switch(keyCode) {
    case 32: moveUp(moveSpeed); println("moveUP"); break; //touche espace
    case 16: moveUp(-moveSpeed); println("moveDOWN"); break; //shift
    case 90: moveFront(moveSpeed); println("moveFRONT"); break; //z
    case 83: moveFront(-moveSpeed); println("moveBACK"); break; //s
    case 81: moveLeft(moveSpeed); println("moveLEFT"); break; //q
    case 68: moveLeft(-moveSpeed); println("moveRIGHT"); break; //d
    case UP: downRotation(-rotaSpeed); println("rotaUP"); break; //UP
    case DOWN: downRotation(rotaSpeed); println("rotaDOWN"); break; //DOWN
    case LEFT: leftRotation(rotaSpeed); println("rotaLEFT"); break; //LEFT
    case RIGHT: leftRotation(-rotaSpeed); println("rotaRIGHT"); break; //RIGHT
    case 80: showPylones = !showPylones; break; //p
    case 76: showLignes = !showLignes; break; //l
    case 72: shadersEnabled = !shadersEnabled; break; //h
    case 84: showTerrain = !showTerrain; break; //t
    case 69: showEoliennes = !showEoliennes; break; //e
    
  }
  calculeBlockPointe();
}






//-----------------GESTION CAMERA ET DEPLACEMENTS---------------------
void moveFront(int d) {
  eyePos.add(PVector.mult(frontHorizontalAxis, d));
}

void moveLeft(int d) {
  eyePos.add(PVector.mult(leftHorizontalAxis, d));
}

void moveUp(int d) {
  eyePos.add(PVector.mult(upAxis, d));
}

void downRotation(float a) {
  //on ne veut pas pouvoir regarder trop vers le bas ni trop vers le haut
  if (verticalViewAngle < -5*PI/12.0 && a > 0) { print("trop bas"); return; }
  if (verticalViewAngle > 5*PI/12.0 && a < 0) { print("trop haut"); return; }
  
  verticalViewAngle -= a;
  
  PVector w = dirVue.cross(leftHorizontalAxis);
  dirVue = ((PVector.mult(dirVue, cos(a))).add(PVector.mult(leftHorizontalAxis, PVector.dot(leftHorizontalAxis, dirVue)))).add(PVector.mult(w, sin(a)));
  dirVue.normalize();
}

void leftRotation(float a) {
  //rotation de leftHorizontalAxis autour de upAxis
  PVector w = leftHorizontalAxis.cross(upAxis);
  leftHorizontalAxis = ((PVector.mult(leftHorizontalAxis, cos(a))).add(PVector.mult(upAxis, PVector.dot(upAxis, leftHorizontalAxis)))).add(PVector.mult(w, sin(a)));
  leftHorizontalAxis.normalize();
  //même rotation pour frontHorizontalAxis
  w = frontHorizontalAxis.cross(upAxis);
  frontHorizontalAxis = ((PVector.mult(frontHorizontalAxis, cos(a))).add(PVector.mult(upAxis, PVector.dot(upAxis, frontHorizontalAxis)))).add(PVector.mult(w, sin(a)));
  frontHorizontalAxis.normalize();
  //nouveau dirVue est rotation d'angle verticalViewAngle de frontHorizontalAxis
  dirVue = new PVector(frontHorizontalAxis.x, frontHorizontalAxis.y, frontHorizontalAxis.z);
  w = dirVue.cross(leftHorizontalAxis);
  dirVue = ((PVector.mult(dirVue, cos(-verticalViewAngle))).add(PVector.mult(leftHorizontalAxis, PVector.dot(leftHorizontalAxis, dirVue)))).add(PVector.mult(w, sin(-verticalViewAngle)));
  dirVue.normalize();
}

void calculeBlockPointe() {
  coordDevant = PVector.add(eyePos, dirVue);
}

void drawReperePerso() {
 pushMatrix();
 translate(eyePos.x, eyePos.y, eyePos.z);
 
 //eyePos en blanc
 stroke(255, 255, 255);
 sphere(5);
 
 //frontHori en vert
 stroke(0, 255, 0);
 PVector w = PVector.mult(frontHorizontalAxis, 50);
 line(0, 0, 0, w.x, w.y, w.z);
 
 //leftHori en rouge
 stroke(255, 0, 0);
 w = PVector.mult(leftHorizontalAxis, 50);
 line(0, 0, 0, w.x, w.y, w.z);
 
 //dirVue en jaune
 stroke(255, 255, 0);
 w = PVector.mult(dirVue, 50);
 line(0, 0, 0, w.x, w.y, w.z);
 
 //upAxis en bleu
 stroke(0, 0, 255);
 w = PVector.mult(upAxis, 50);
 line(0, 0, 0, w.x, w.y, w.z);
 
 popMatrix();
 
 //blockPointe en jaune
 stroke(255, 255, 0);
 coordDevant = PVector.add(eyePos, PVector.mult(dirVue, 50));
 translate(coordDevant.x, coordDevant.y, coordDevant.z);
 box(5);
}
