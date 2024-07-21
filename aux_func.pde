void drawRepere() {
  strokeWeight(3);
  // Axe X rouge
  stroke(255, 0, 0);
  line(0, 0, 0, width/2, 0, 0);

  // Axe Y vert
  stroke(0, 255, 0);
  line(0, 0, 0, 0, height/2, 0);

  // Axe Z bleu
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, height/2);  
}


float getTerrainHeight(float x, float y) {
  PVector vert = terrain.getChild(0).getVertex(0);
  float dMin = sqrt((vert.x - x)*(vert.x - x) + (vert.y - y)*(vert.y - y));
  float zMin = vert.z;
  float d;
  for (int c = 0; c<terrain.getChildCount(); c++) {
    for (int v = 0; v<terrain.getChild(c).getVertexCount(); v++) {
      vert = terrain.getChild(c).getVertex(v);
      d = sqrt((vert.x - x)*(vert.x - x) + (vert.y - y)*(vert.y - y));
      if (d<dMin) {
        dMin = d;
        zMin = vert.z;
      }
    }
  }
  return zMin;
}


PVector pointIntermediaireBezier(PVector p0, PVector p1, PVector p2, PVector p3, float t) {
  PVector p = new PVector();
  p.x = (1-t)*(1-t) * (1-t) * p0.x + 3 * (1-t)*(1-t) * t * p1.x + 3 * (1-t) * t*t * p2.x + t*t * t * p3.x;
  p.y = (1-t)*(1-t) * (1-t) * p0.y + 3 * (1-t)*(1-t) * t * p1.y + 3 * (1-t) * t*t * p2.y + t*t * t * p3.y;
  p.z = (1-t)*(1-t) * (1-t) * p0.z + 3 * (1-t)*(1-t) * t * p1.z + 3 * (1-t) * t*t * p2.z + t*t * t * p3.z;

  return p;
}
