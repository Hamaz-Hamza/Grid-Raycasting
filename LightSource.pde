class LightSource {
    PVector pos;
    LightSource(float x, float y) {pos = new PVector(x,y);}
    PVector[] endPoints = {new PVector(0,0), new PVector(width-1,0), new PVector(0,height-1), new PVector(width-1,height-1)};
    
    void illuminate(ArrayList<Edge> edges){
        
        ArrayList<PVector> vertices = new ArrayList<PVector>();
        for(int i=0; i < edges.size(); i++){
           PVector vertex = edges.get(i).p1;
           if (!vertices.contains(vertex)) vertices.add(vertex);
           vertex = edges.get(i).p2;
           if (!vertices.contains(vertex)) vertices.add(vertex);
        }
        
        PVector[] intersectionPoints = new PVector[vertices.size()*3];
        for(int i=0; i < vertices.size(); i++){
            int index = i*3;
            
            Ray ray = new Ray(pos, vertices.get(i).copy().sub(pos));
            Intersection closestIntersection = new Intersection(pos, width+height);
            for(int j=0; j < edges.size(); j++){
                Intersection intersection = ray.testIntersection(convertToRay(edges.get(j)));
                if (intersection != null) if (intersection.distance < closestIntersection.distance) closestIntersection = intersection;
            }
            //if (closestIntersection.equalToBase()) print(ray.start, ray.dir,closestIntersection.distance,"\n");
            intersectionPoints[index++] = closestIntersection.point.copy();
            
            ray = new Ray(pos, ray.dir.rotate(-0.001));
            closestIntersection = new Intersection(pos, width+height);
            for(int j=0; j < edges.size(); j++){
                Intersection intersection = ray.testIntersection(convertToRay(edges.get(j)));
                if (intersection != null) if (intersection.distance < closestIntersection.distance) closestIntersection = intersection;
            }
            intersectionPoints[index++] = closestIntersection.point.copy();
            
            ray = new Ray(pos, ray.dir.rotate(0.002));
            closestIntersection = new Intersection(pos, width+height);
            for(int j=0; j < edges.size(); j++){
                Intersection intersection = ray.testIntersection(convertToRay(edges.get(j)));
                if (intersection != null) if (intersection.distance < closestIntersection.distance) closestIntersection = intersection;
            }
            intersectionPoints[index++] = closestIntersection.point.copy();
        }
        
        Coordinates[] coords = new Coordinates[intersectionPoints.length];
        for(int i=0; i < coords.length; i++) coords[i] = new Coordinates(intersectionPoints[i], getTheta(intersectionPoints[i].copy().sub(pos)));
        mergeSort(coords, 0, coords.length-1);
        
        PVector[] sortedPoints = new PVector[coords.length+2];
        sortedPoints[0] = pos;
        for(int i=0; i < coords.length; i++) sortedPoints[i+1] = coords[i].point;
        sortedPoints[sortedPoints.length-1] = coords[0].point;
        
        fill(255);
        stroke(255);
        beginShape(TRIANGLE_FAN);
        for (PVector point : sortedPoints) vertex(point.x, point.y);
        endShape();
    }
    
    void drawLine(PVector v1, PVector v2){ stroke(255, 100); line(v1.x, v1.y, v2.x, v2.y); }
    Ray convertToRay(Edge edge){return new Ray(edge.p1, edge.p2.copy().sub(edge.p1));}
    float getTheta(PVector dir){return atan2(dir.y,dir.x);}
}
