class Eolienne {
  private PShape eoSansPales;
  private PShape tripletPales;
  
  private float XtranslationPales;
  private float YtranslationPales;
  private float ZtranslationPales;
  
  private float hauteurPilier;
  private float rayonPilier;
  private float longueurPales;

  Eolienne() {
    hauteurPilier = 6;
    rayonPilier = 0.5;
    longueurPales = 4;
    init();
  }
  
  Eolienne(int hPilier, int rPilier, int lPales) {
    hauteurPilier = hPilier;
    rayonPilier = rPilier;
    longueurPales = lPales;
    init();
  }
  
  private void init() {
    eoSansPales = createShape(GROUP);
  
    //pilier
    PShape pilier = createShape();
    pilier.beginShape(QUAD_STRIP);
    pilier.noStroke();
    for (int i = 0; i<=50; i++) {
      float a = i*2*PI/50;
      pilier.fill(255);
      pilier.vertex(cos(a)* rayonPilier, sin(a)* rayonPilier, 0);
      pilier.fill(255);
      pilier.vertex(cos(a)* rayonPilier, sin(a)* rayonPilier, hauteurPilier);
    }
    pilier.endShape();
    eoSansPales.addChild(pilier); 
    
    //teteEolienne en haut
    PShape teteEolienne = createShape();
    teteEolienne.beginShape(QUAD_STRIP);
    teteEolienne.fill(255);
    teteEolienne.vertex(-rayonPilier*2, -rayonPilier, hauteurPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(rayonPilier*2, -rayonPilier, hauteurPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(-rayonPilier*2, -rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(rayonPilier*2, -rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(-rayonPilier*2, rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(rayonPilier*2, rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(-rayonPilier*2, rayonPilier, hauteurPilier);
    teteEolienne.fill(255);
    teteEolienne.vertex(rayonPilier*2, rayonPilier, hauteurPilier);
    teteEolienne.endShape(CLOSE);
    
    teteEolienne.beginShape(QUAD_STRIP);
    teteEolienne.vertex(-rayonPilier*2, rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.vertex(-rayonPilier*2, -rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.vertex(-rayonPilier*2, rayonPilier, hauteurPilier);
    teteEolienne.vertex(-rayonPilier*2, -rayonPilier, hauteurPilier);
    teteEolienne.vertex(rayonPilier*2, rayonPilier, hauteurPilier);
    teteEolienne.vertex(rayonPilier*2, -rayonPilier, hauteurPilier);
    teteEolienne.vertex(rayonPilier*2, rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.vertex(rayonPilier*2, -rayonPilier, hauteurPilier + 2*rayonPilier);
    teteEolienne.endShape(CLOSE);
    
    
    float rBaseMoyeu = 0.75*rayonPilier;
    PShape moyeu = createShape();
    float da = 2*PI/50.0;
    for (int i = 0; i<=50; i++) {
      float a = i*2*PI/50.0;
      moyeu.beginShape(QUAD_STRIP);
      moyeu.noStroke();
      for (int j = 0; j<=20; j++) {
        float r = cos(j*PI/2.0/20.0)*rBaseMoyeu;
        moyeu.fill(255);
        moyeu.vertex(cos(a)*r, sin(a)*r, j*2.5*rBaseMoyeu/20.0);
        moyeu.fill(255);
        moyeu.vertex(cos(a+da)*r, sin(a+da)*r, j*2.5*rBaseMoyeu/20.0);
      }
      moyeu.endShape();
    }
    
    moyeu.rotateY(-PI/2.0);
    moyeu.translate(-rayonPilier*2, 0, hauteurPilier + rayonPilier);
    
    eoSansPales.addChild(teteEolienne);
    eoSansPales.addChild(moyeu);
    
    
    tripletPales = createShape(GROUP);
    
    PShape[] pales = new PShape[3];
    
    PVector pAttaqueRef = new PVector(0, 0, 0);
    PVector pFuiteRef = new PVector(100, 0, 0);
    PVector p1FaceRef = new PVector(10, 45, 0);
    PVector p2FaceRef = new PVector(60, -5, 0);
    PVector p1DosRef = new PVector(33, -20, 0);
    PVector p2DosRef = new PVector(66, -20, 0);
    
    
    PVector p1D; 
    PVector p2D; 
    PVector pFuite; 
    PVector p1F; 
    PVector p2F; 
    
    PVector p1DPrec; 
    PVector p2DPrec; 
    PVector pFuitePrec; 
    PVector p1FPrec; 
    PVector p2FPrec; 
    
    
    PVector c1;
    PVector c2;
    
    float z;
    float zPrec;
    
    for (int n = 0; n<3; n++) {
      pales[n] = createShape();
      
      p1DPrec = PVector.mult(p1DosRef, 0.5);
      p2DPrec = PVector.mult(p2DosRef, 0.5);
      pFuitePrec = PVector.mult(pFuiteRef, 0.5);
      p1FPrec = PVector.mult(p1FaceRef, 0.5);
      p2FPrec = PVector.mult(p2FaceRef, 0.5);
      
      z = 0;
      zPrec = 0;
      
      for (int i = 0; i<60; i++) {
        if (i<5) {
          p1D = PVector.mult(p1DosRef, (6+i)/10.0);
          p2D = PVector.mult(p2DosRef, (6+i)/10.0);
          pFuite = PVector.mult(pFuiteRef, (6+i)/10.0);
          p1F = PVector.mult(p1FaceRef, (6+i)/10.0);
          p2F = PVector.mult(p2FaceRef, (6+i)/10.0);
        } else {
          p1D = PVector.mult(p1DosRef, (59-i)/55.0);
          p2D = PVector.mult(p2DosRef, (59-i)/55.0);
          pFuite = PVector.mult(pFuiteRef, (59-i)/55.0);
          p1F = PVector.mult(p1FaceRef, (59-i)/55.0);
          p2F = PVector.mult(p2FaceRef, (59-i)/55.0);
        }
      
        z += 10;
      
        pales[n].beginShape(QUAD_STRIP);
        pales[n].noStroke();
        for (int t = 0; t<26; t++) {
          c1 = pointIntermediaireBezier(pAttaqueRef, p1D, p2D, pFuite, t/25.0);
          c2 = pointIntermediaireBezier(pAttaqueRef, p1DPrec, p2DPrec, pFuitePrec, t/25.0);
          pales[n].fill(255);
          pales[n].vertex(c1.x, c1.y, z);
          pales[n].fill(255);
          pales[n].vertex(c2.x, c2.y, zPrec);
        }
        pales[n].endShape();
      
        pales[n].beginShape(QUAD_STRIP);
        pales[n].noStroke();
        for (int t = 0; t<26; t++) {
          c1 = pointIntermediaireBezier(pAttaqueRef, p1F, p2F, pFuite, t/25.0);
          c2 = pointIntermediaireBezier(pAttaqueRef, p1FPrec, p2FPrec, pFuitePrec, t/25.0);
          pales[n].fill(255);
          pales[n].vertex(c1.x, c1.y, z);
          pales[n].fill(255);
          pales[n].vertex(c2.x, c2.y, zPrec);
        }
        pales[n].endShape();
      
        p1DPrec = p1D.copy();
        p2DPrec = p2D.copy();
        pFuitePrec = pFuite.copy();
        p1FPrec = p1F.copy();
        p2FPrec = p2F.copy();
      
        zPrec = z;
      }
      
      pales[n].scale(longueurPales/600.0);
      pales[n].translate(-rBaseMoyeu/3.0, 0, rBaseMoyeu/2.0);
      pales[n].rotateZ(PI/2.0);
      
      XtranslationPales = -rayonPilier*2 - 2*rBaseMoyeu/3.0;
      YtranslationPales = 0;
      ZtranslationPales = hauteurPilier + rayonPilier;
      
      pales[n].rotateX(2*n*PI/3.0);
      tripletPales.addChild(pales[n]);      
    }
  }
  
  
  void paintShape() {
    shape(eoSansPales);
    pushMatrix();
    translate(XtranslationPales, YtranslationPales, ZtranslationPales);
    rotateX(2*PI*(frameCount % 100)/100.0);
    shape(tripletPales);
    popMatrix();
  }
  
  void placeEoliennes(int x1, int y1, int x2, int y2, int xLink, int yLink, Pylone p) {
    float xDistanceBetween = 1.5*longueurPales;
    float yDistanceBetween = 3*longueurPales;
    int xDensity = (int)max(1, (abs(x2 - x1)/xDistanceBetween)+1);
    int yDensity = (int)max(1, (abs(y2 - y1)/yDistanceBetween)+1);
    int xDep = (x2-x1 >=0)? x1 :x2;
    int yDep = (y2-y1 >=0)? y1 : y2;
    float xVar = xDep;
    float yVar;
    int effectiveYDensity;
    
    for (int i = 0; i<xDensity; i++) {
      if (i%2 == 0) { 
        effectiveYDensity = yDensity; 
        yVar = yDep;
      } else { 
        effectiveYDensity = yDensity -1 ; 
        yVar = yDep + yDistanceBetween/2.0;
      }
      for (int j = 0; j<effectiveYDensity; j++) {
        pushMatrix();
        translate(xVar, yVar, getTerrainHeight(xVar, yVar));
        paintShape();
        popMatrix();
        yVar += yDistanceBetween;
      }
      xVar += xDistanceBetween;
    }
    
    p.placePylones(x1, y1, xLink, yLink, true);
    
  }

}
