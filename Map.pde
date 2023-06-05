class Map{
    Block[][] map;
    int rows, cols;
    ArrayList<Edge> edges = new ArrayList<Edge>();
    
    Map(int width, int height){
         cols = width/blockSize;
         rows = height/blockSize;
         map = new Block[cols][rows];
         for(int y=0; y < rows; y++) for(int x=0; x < cols; x++) map[x][y] = new Block(x,y,false);
    }
    
    void draw(){
        drawBlocks();
        drawEdges();
    }
    
    void update(){
        updateEdges();
        for (Block[] blockRow : map) for(Block block : blockRow) block.removeEdges();
    }
    
    void drawBlocks() { for (Block[] blockRow : map) for(Block block : blockRow) block.draw(); }
    void drawEdges() { for(Edge edge : edges) edge.draw(); }
    
    void updateBlocks(){
        int x = int(mouseX/blockSize); 
        int y = int(mouseY/blockSize);
        map[x][y].filled = !map[x][y].filled;
    }
    
    void updateEdges(){
        Block current, top, right, left, bottom;
        
        for(int y=0; y < rows; y++){
           for(int x=0; x < cols; x++){
         
              current = map[x][y];
              
              if (current.filled){
                  if (x != 0) left = map[x-1][y];
                  else left = null;
                  if (y != 0) top = map[x][y-1];
                  else top = null;
                  if (x != cols-1) right = map[x+1][y];
                  else right = null;
                  if (y != rows-1) bottom = map[x][y+1];
                  else bottom = null;
         
                  addEdges(current, top, right, bottom, left);
              }
           }
        }
        edges.add(new Edge(new PVector(0,0), new PVector(width-1,0)));
        edges.add(new Edge(new PVector(0,0), new PVector(0,height-1)));
        edges.add(new Edge(new PVector(width-1,0), new PVector(width-1,height-1)));
        edges.add(new Edge(new PVector(0,height-1), new PVector(width-1,height-1)));
    }
    
    void addEdges(Block current, Block top, Block right, Block bottom, Block left){
        if (left != null && !left.filled && top == null){
            current.addLeftEdge();
            edges.add(current.leftEdge);
        }
        else if (top != null && !top.filled && left == null){
            current.addTopEdge();
            edges.add(current.topEdge);
        }
        else if (left != null && !left.filled && top != null && !top.filled){
            current.addTopEdge();
            edges.add(current.topEdge);
            current.addLeftEdge();
            edges.add(current.leftEdge);
        }
        
        if (left != null && left.filled) {
            if (top != null && !top.filled) {
                if (left.topEdge != null) {
                    left.topEdge.extendRight();
                    current.topEdge = left.topEdge;
                }
                else {
                    current.addTopEdge();
                    edges.add(current.topEdge);
                }
            }
            if (bottom != null && !bottom.filled) {
                if (left.bottomEdge != null)  {
                    left.bottomEdge.extendRight();
                    current.bottomEdge = left.bottomEdge;
                }
                else {
                    current.addBottomEdge();
                    edges.add(current.bottomEdge);
                }
            }
        }
        else if (bottom != null && !bottom.filled) {
            current.addBottomEdge();
            edges.add(current.bottomEdge);
        }
        
        if (top != null && top.filled) {
            if (left != null && !left.filled) {
                if (top.leftEdge != null) {
                    top.leftEdge.extendDown();
                    current.leftEdge = top.leftEdge;
                }
                else {
                    current.addLeftEdge();
                    edges.add(current.leftEdge);
                }
            }
            if (right != null && !right.filled) {
                if (top.rightEdge != null) {
                    top.rightEdge.extendDown();
                    current.rightEdge = top.rightEdge;
                }
                else {
                    current.addRightEdge();
                    edges.add(current.rightEdge);
                }
            }
        }
        else if (right != null && !right.filled) {
            current.addRightEdge();
            edges.add(current.rightEdge);
        }
    }
}
        
