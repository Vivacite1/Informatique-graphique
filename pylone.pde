class Pylone {
  private float largeurCentre;
  private float hauteurEtage;
  private int nbSectionsGBras;
  private int nbSectionsPBras;
  
  private PShape pyloneShape;
  
  Pylone() {
    largeurCentre = 0.6;
    hauteurEtage = largeurCentre/2;
    nbSectionsGBras = 7;
    nbSectionsPBras = 3;
    init();
  }
  
  Pylone(float largeurPilier, float hauteurEtage, int nbSectionsBrasInf, int nbSectionsBrasSup) {
    largeurCentre = largeurPilier;
    this.hauteurEtage = hauteurEtage;
    nbSectionsGBras = nbSectionsBrasInf;
    nbSectionsPBras = nbSectionsBrasSup;
    init();
  }
  
  private void init() {
    pyloneShape = createShape(GROUP);
  
    //pilier centrale (plaques, children 0 - 4*nbEtages-1)
    int nbEtages = 16;
    PShape[][] plaques = new PShape[nbEtages][4];
  
    float l = largeurCentre/2;
    float h = hauteurEtage/2;
    float epaisseurP = largeurCentre;
  
    for (int i = 0; i<nbEtages; i++) {
      for (int j = 0; j<4; j++) {
        plaques[i][j] = createShape();
        plaques[i][j].beginShape(LINES);
        plaques[i][j].strokeWeight(epaisseurP);
        plaques[i][j].stroke(5);
        plaques[i][j].vertex(-l, -l, h);
        plaques[i][j].vertex(l, -l, -h);
        plaques[i][j].vertex(l, -l, h);
        plaques[i][j].vertex(-l, -l, -h);
        plaques[i][j].vertex(-l, -l, h);
        plaques[i][j].vertex(-l, -l, -h);
        plaques[i][j].vertex(l, -l, h);
        plaques[i][j].vertex(l, -l, -h);
        plaques[i][j].vertex(-l, -l, -h);
        plaques[i][j].vertex(l, -l, -h);
        plaques[i][j].endShape();
        pyloneShape.addChild(plaques[i][j]);
        pyloneShape.getChild(4*i + j).rotateZ(j * PI/2.0);
        pyloneShape.getChild(4*i + j).translate(0, 0, i*hauteurEtage);
      }
    }
  
  
  
    //chapeau (children 4*nbEtages - 4*nbEtages+1)
    PShape[] plaqueCh = new PShape[2];
    for (int i = 0; i<2; i++) {
      plaqueCh[i] = createShape();
      plaqueCh[i].beginShape(LINES);
      plaqueCh[i].strokeWeight(epaisseurP);
      plaqueCh[i].stroke(5);
      plaqueCh[i].vertex(-l, -l, -h);
      plaqueCh[i].vertex(l, -l, -h);
      plaqueCh[i].vertex(-l, 0, h);
      plaqueCh[i].vertex(l, 0, h);
      plaqueCh[i].vertex(-l, -l, -h);
      plaqueCh[i].vertex(-l, 0, h);
      plaqueCh[i].vertex(l, -l, -h);
      plaqueCh[i].vertex(l, 0, h);
      plaqueCh[i].vertex(-l, -l, -h);
      plaqueCh[i].vertex(l, 0, h);
      plaqueCh[i].vertex(l, -l, -h);
      plaqueCh[i].vertex(-l, 0, h);
      plaqueCh[i].vertex(l, -l, -h);
      plaqueCh[i].vertex(l, l, -h);
      plaqueCh[i].endShape();
      pyloneShape.addChild(plaqueCh[i]);
      pyloneShape.getChild(4*nbEtages + i).rotateZ(i * PI);
      pyloneShape.getChild(4*nbEtages + i).translate(0, 0, nbEtages*hauteurEtage);
    }
    
  
  
    //bras (children 4*nbEtages+2 - 4*nbEtages+5)
    PShape[][] bras = new PShape[2][2];
    float lsec = l/2.0;
    PShape[][] sections = new PShape[2][nbSectionsGBras];
  
    int nb;
    for (int t = 0; t<2; t++) {
      if (t==0) { nb = nbSectionsGBras; }
      else { nb = nbSectionsPBras; }
    
      for (int i = 0; i<2; i++) {
        bras[t][i] = createShape(GROUP);
        for (int j = 0; j<nb; j++) {
          float ratio = (nb - (j+1))/(float)nb;
          float ratioPrec = (nb - j)/(float)nb;
          sections[i][j] = createShape();
          sections[i][j].beginShape(LINES);
          sections[i][j].strokeWeight(epaisseurP);
          sections[i][j].stroke(5);
          sections[i][j].vertex(-lsec, -l*ratio, 0);
          sections[i][j].vertex(lsec, -l*ratioPrec, 0);
          sections[i][j].vertex(-lsec, 0, hauteurEtage*ratio);
          sections[i][j].vertex(lsec, 0, hauteurEtage*ratioPrec);
          sections[i][j].vertex(-lsec, -l*ratio, 0);
          sections[i][j].vertex(-lsec, 0, hauteurEtage*ratio);
          sections[i][j].vertex(lsec, -l*ratioPrec, 0);
          sections[i][j].vertex(lsec, 0, hauteurEtage*ratioPrec);
          sections[i][j].vertex(-lsec, -l*ratio, 0);
          sections[i][j].vertex(lsec, 0, hauteurEtage*ratioPrec);
          sections[i][j].vertex(lsec, -l*ratioPrec, 0);
          sections[i][j].vertex(-lsec, 0, hauteurEtage*ratio);
          sections[i][j].vertex(lsec, -l*ratioPrec, 0);
          sections[i][j].vertex(lsec, l*ratioPrec, 0);
          sections[i][j].vertex(-lsec, l*ratio, 0);
          sections[i][j].vertex(lsec, l*ratioPrec, 0);
          sections[i][j].vertex(-lsec, l*ratio, 0);
          sections[i][j].vertex(-lsec,0 , hauteurEtage*ratio);
          sections[i][j].vertex(-lsec,0 , hauteurEtage*ratio);
          sections[i][j].vertex(lsec, l*ratioPrec, 0);
          sections[i][j].vertex(lsec, 0 , hauteurEtage*ratioPrec);
          sections[i][j].vertex(-lsec, l*ratio, 0);
          sections[i][j].vertex(-lsec, -l*ratio , 0);
          sections[i][j].vertex(lsec, l*ratioPrec, 0);
          sections[i][j].vertex(lsec, -l*ratioPrec , 0);
          sections[i][j].vertex(-lsec, l*ratio, 0);
          sections[i][j].endShape();
          sections[i][j].translate(-(j+1) * l - lsec, 0, -h);
          bras[t][i].addChild(sections[i][j]);
        }
        bras[t][i].rotateZ(i*PI);
        bras[t][i].translate(0, 0, (13+3*t)*hauteurEtage);
        pyloneShape.addChild(bras[t][i]);
      }
    }
    pyloneShape.translate(0, 0, h);
  }
  
  
  void paintShape() { shape(pyloneShape); }
  
  
  void placePylones(int x1, int y1, int x2, int y2, boolean showLignes) {
    PVector dir = new PVector(x2 - x1, y2 - y1, 0);
    dir.normalize();
    float a = (x2 > x1)? -acos(dir.dot(new PVector(0, 1, 0))) : acos(dir.dot(new PVector(0, 1, 0)));
    float d = sqrt((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1));
    int nbPylones = (int)(d/(30*hauteurEtage) + 1);
    float dInter = d/(nbPylones-1);
    PVector vInterXY = PVector.mult(dir, dInter);
    
    //placement du premier
    PVector coordPylonePrec = new PVector(x1, y1, getTerrainHeight(x1, y1));
    pushMatrix();
    translate(coordPylonePrec.x, coordPylonePrec.y, coordPylonePrec.z);
    rotateZ(a);
    shape(pyloneShape);
    popMatrix();
    
    PVector coord = new PVector(x1, y1, 0).add(vInterXY);
    for (int i = 0; i<nbPylones-1; i++) {
      coord.z = getTerrainHeight(coord.x, coord.y);
      pushMatrix();
      translate(coord.x, coord.y, coord.z);
      rotateZ(a);
      shape(pyloneShape);
      popMatrix();
      
      if (showLignes) placeLignesElec(coord, coordPylonePrec, a);
      
      coordPylonePrec.x = coord.x;
      coordPylonePrec.y = coord.y;
      coordPylonePrec.z = coord.z;
      
      coord.add(vInterXY);
    }
  }


  void placeLignesElec(PVector c, PVector cPrec, float a) {
    int nbSections = 20; 
    float d = sqrt((c.x - cPrec.x)*(c.x - cPrec.x) + (c.y - cPrec.y)*(c.y - cPrec.y) + (c.z - cPrec.z)*(c.z - cPrec.z));
    float coefFlechissement = d/10.0;
    PVector dir = new PVector((c.x - cPrec.x)/nbSections, (c.y - cPrec.y)/nbSections, (c.z - cPrec.z)/nbSections);
    PVector coord1 = new PVector(cPrec.x + 4*largeurCentre*cos(a), cPrec.y + 4*largeurCentre*sin(a), cPrec.z + 13*hauteurEtage);
    PVector coord2 = new PVector(cPrec.x - 4*largeurCentre*cos(a), cPrec.y - 4*largeurCentre*sin(a), cPrec.z + 13*hauteurEtage);
    float niveau;
    float niveauPrec = 0;
    for (int i = 1; i<=nbSections ; i++) {
      niveau = sin(PI * i/nbSections) * coefFlechissement;
      beginShape(LINES);
      stroke(0);
      strokeWeight(2);
      vertex(coord1.x, coord1.y, coord1.z - niveauPrec);
      coord1.add(dir);
      vertex(coord1.x, coord1.y, coord1.z - niveau);
      vertex(coord2.x, coord2.y, coord2.z - niveauPrec);
      coord2.add(dir);
      vertex(coord2.x, coord2.y, coord2.z - niveau);
      endShape();
      niveauPrec = niveau;
    }
  }
  
}
