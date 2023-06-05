class Intersection{
    PVector point;
    float distance;
    Intersection(PVector location, float dis) { point = location.copy(); distance = dis; }
    boolean equalToBase() { if (point.x == mouseLight.pos.x && point.y == mouseLight.pos.y) return true; else return false;}
}
