Map map;
int blockSize = 20;
LightSource mouseLight;

void setup() {
   size(1000, 600);
   map = new Map(width,height);
   mouseLight = new LightSource(mouseX,mouseY);
}

void draw() {
   background(0);
   map.update();
   map.draw();
   
   mouseLight.illuminate(map.edges);
   map.edges.clear();
   mouseLight.pos.x = mouseX; mouseLight.pos.y = mouseY;
   stroke(255);
   text(frameRate,5,10);
   strokeWeight(2);
   stroke(0);
   point(835.0, 298.0);
}

void mousePressed() { map.updateBlocks(); }
