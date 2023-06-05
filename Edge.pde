class Edge{
    PVector p1, p2; // points are sorted according to position
    Edge(PVector point1, PVector point2) {p1 = point1.copy(); p2 = point2.copy();}
    
    void extendRight() {p2.x += blockSize;}
    void extendDown() {p2.y += blockSize;}
    
    void draw(){
        //strokeWeight(3);
        //stroke(200,0,0);
        //line(p1.x,p1.y,p2.x,p2.y);
        //strokeWeight(5);
        //stroke(0,200,0);
        //point(p1.x,p1.y);
        //stroke(0,0,200);
        //point(p2.x,p2.y);
    }
}
