boolean isInPolygon(PVector p, Polygon poly){//https://en.wikipedia.org/wiki/Point_in_polygon
  ArrayList<Polygon> polygons = new ArrayList<Polygon>();
  polygons.add(poly);
  Ray ray = new Ray(p, 0, polygons);
  ray.update();
  return ray.inside;
}