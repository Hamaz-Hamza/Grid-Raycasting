class Block{
    int x,y;
    boolean filled;
    Edge topEdge = null, 
    rightEdge = null,
    bottomEdge = null,
    leftEdge = null;
    Block(int row, int col, boolean fill) {x = row*blockSize; y = col*blockSize; filled = fill;}
    
    void addTopEdge()   { topEdge    = new Edge(new PVector(x,y),           new PVector(x+blockSize,y)); }
    void addRightEdge() { rightEdge  = new Edge(new PVector(x+blockSize,y), new PVector(x+blockSize,y+blockSize)); }
    void addBottomEdge(){ bottomEdge = new Edge(new PVector(x,y+blockSize), new PVector(x+blockSize,y+blockSize)); }
    void addLeftEdge()  { leftEdge   = new Edge(new PVector(x,y),           new PVector(x,y+blockSize)); }
    void removeEdges() {topEdge = null; rightEdge = null; bottomEdge = null; leftEdge = null;}
    
    void draw(){
        stroke(20);
        strokeWeight(1);
        if (filled) fill(50);
        else noFill();
        rect(x, y, blockSize, blockSize);
    }
}
