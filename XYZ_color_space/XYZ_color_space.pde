float step = 0.002;
float mult = 5.5;

void setup(){
  //fullScreen();
  size(500, 500);
  colorMode(RGB, 1, 1, 1);
  background(1);
  strokeWeight(10);
  strokeJoin(ROUND);
  noFill();
  stroke(0);//show single spectrum polygon
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  for(int i = 0; i < spectrums.length; i++){
    float[] ss = spectrums[i];
    PVector xy = XYZtoxyY(CIERGBtoXYZ(new PVector(ss[0], ss[1], ss[2])));
    vertices.add(new PVector(xy.x*height, height-xy.y*height));
  }
  Polygon polygon = new Polygon(vertices);
  noStroke();
  for(float x = 0; x < 1; x+=step){
    for(float y = 0; y < 1; y+=step){
      for(float z = 0; z < 1; z+=step){
        PVector rgb = XYZtoCIERGB(new PVector(x, y, z));
        PVector xyY = XYZtoxyY(new PVector(x, y, z));
        fill(rgb.x*mult, rgb.y*mult, rgb.z*mult);
        //if(rgb.x > 0 && rgb.x < 1 && rgb.y > 0 && rgb.y < 1 && rgb.z > 0 && rgb.z < 1){}
        PVector p = new PVector(xyY.x*height, height-xyY.y*height);
        if(isInPolygon(p, polygon)){
          rect(p.x, p.y, 1, 1);
        }
      }
    }
    println(x*100+"%");
  }
  noFill();
  stroke(0);
  //polygon.show();
  PVector xy = XYZtoxyY(CIERGBtoXYZ(new PVector(1, 0, 0)));
  PVector xy2 = XYZtoxyY(CIERGBtoXYZ(new PVector(0, 1, 0)));
  PVector xy3 = XYZtoxyY(CIERGBtoXYZ(new PVector(0, 0, 1)));
  //triangle(xy.x*height, height-xy.y*height, xy2.x*height, height-xy2.y*height, xy3.x*height, height-xy3.y*height);
}

void draw(){
  
}

PVector XYZtoxyY(PVector XYZ){
  float x = XYZ.x/(XYZ.x + XYZ.y + XYZ.z);
  float y = XYZ.y/(XYZ.x + XYZ.y + XYZ.z);
  return new PVector(x, y, XYZ.y);
}

PVector CIERGBtoXYZ(PVector cRGB){
  float x = 2.76883*cRGB.x + 1.75171*cRGB.y + 1.13014*cRGB.z;
  float y = 1.00000*cRGB.x + 4.59061*cRGB.y + 0.06007*cRGB.z;
  float z = 0.00000*cRGB.x + 0.05651*cRGB.y + 5.59417*cRGB.z;
  return new PVector(x, y, z);
}

PVector xyYtoXYZ(PVector XY){
  float x = XY.z*XY.x/XY.y;
  float z = XY.z*(1-XY.x-XY.y)/XY.y;
  return new PVector(x, XY.z, z);
}

PVector XYZtoCIERGB(PVector XYZ){
  float r =  0.418466*XYZ.x + -0.158661*XYZ.y + -0.082835*XYZ.z;
  float g = -0.091169*XYZ.x +  0.252431*XYZ.y +  0.015707*XYZ.z;
  float b =  0.000921*XYZ.x + -0.002550*XYZ.y +  0.178599*XYZ.z;
  return new PVector(r, g, b);
}
