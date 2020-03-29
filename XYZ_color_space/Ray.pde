class Ray{
  PVector o, d;
  boolean estInside = false;
  boolean inside = false;
  boolean isFinal = false;
  ArrayList<Polygon> polygons = new ArrayList<Polygon>();
  
  Ray(float ox, float oy, float dx, float dy){
    this(new PVector(ox, oy), new PVector(dx, dy));
  }
  
  Ray(PVector o, PVector d){
    this.o = o;
    this.d = d;
  }
  
  Ray(PVector o, float angle, ArrayList<Polygon> polygons){
    this(o, PVector.fromAngle(angle));
    this.polygons = polygons;
  }
  
  void marchBit(){
    o.add(PVector.mult(d, EPSILON*10));
  }
  
  void update(){
    float bestDist = Float.POSITIVE_INFINITY;;
    PVector bestP = null;
    Barrier hitBarrier = null;
    for(int i = 0; i < polygons.size(); i++){
      Polygon polygon = polygons.get(i);
      for(int j = 0; j < polygon.barriers.length; j++){
        Barrier barrier = polygon.barriers[j];
        PVector p = intersection(barrier.sp, barrier.ep, o, PVector.add(o, d));
        if(p != null){
          float distance = dist(p.x, p.y, o.x, o.y);
          if(distance < bestDist){
            bestDist = distance;
            hitBarrier = barrier;
            bestP = p;
          }
        }
      }
    }
    if(bestP != null){
       d = PVector.sub(bestP, o);
       Ray ray = new Ray(bestP, 0, polygons);
       ray.estInside = !estInside;
       ray.marchBit();
       ray.update();
       isFinal = ray.isFinal;
       if(isFinal){
         inside = ray.inside;
       }
       //ray.show();
    }else{
      isFinal = true;
      inside = estInside;
      d.mult(100000);
    }
  }
  
  void show(){
    if(estInside){
      stroke(255);
    }else{
      stroke(255, 150);
    }
    if(inside){
      stroke(255, 0, 0);
    }
    line(o, PVector.add(o, d));
  }
}

PVector intersection(PVector s1, PVector e1, PVector s2, PVector e2) {
  float x1 = s1.x;
  float y1 = s1.y;
  float x2 = e1.x;
  float y2 = e1.y;
  float x3 = s2.x;
  float y3 = s2.y;
  float x4 = e2.x;
  float y4 = e2.y;
  float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  if (den == 0) {
    return null;
  }
  
  float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
  float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
  if (t > 0 && t < 1 && u > 0) {
    PVector pt = new PVector();
    pt.x = x1 + t * (x2 - x1);
    pt.y = y1 + t * (y2 - y1);
    return pt;
  } else {
    return null;
  }
}