class Polygon{
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  Barrier[] barriers;
  
  Polygon(float x, float y, float mr, int n){
    float Btheta = random(TWO_PI);
    for(int i = 0; i < n; i++){
      float theta = map(i, 0, n, 0, TWO_PI)+Btheta;
      float r = random(mr);
      vertices.add(new PVector(x+cos(theta)*r, y+sin(theta)*r));
    }
    calcBarrier();
  }
  
  Polygon(ArrayList<PVector> vertices){
    this.vertices = vertices;
    calcBarrier();
  }
  
  void calcBarrier(){
    barriers = new Barrier[vertices.size()];
    for(int i = 0; i < vertices.size(); i++){
      barriers[i] = new Barrier(vertices.get(i), vertices.get((i+1)%vertices.size()));
    } 
    barriers[vertices.size()-1] = new Barrier(vertices.get(vertices.size()-2), vertices.get(0));
  }
  
  void show(){
    //beginShape();
    //for(PVector vertice : vertices){
    //  vertex(vertice.x, vertice.y);
    //}
    //endShape();
    for(Barrier barrier : barriers){
      barrier.show();
    }
  }
}
