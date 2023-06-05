class Ray{
    PVector start;
    PVector dir;
    
    Ray(PVector beginPoint, PVector rayDirection) {    
        start = beginPoint.copy(); 
        dir = rayDirection.copy();
    }
    
    Intersection testIntersection(Ray wallRay){
        // ray = p(ray rayStart) + rayDist * r(ray rayDirection)
        // wall = q(wall rayStart) + wallPercent * s(wall rayDirection)
        // rayDist = (q-p) x (s * (1/rxs))
        // wallPercent = (q-p) x (r * (1/rxs))
        
        PVector rayStart = start.copy();
        PVector rayDir = dir.copy();
        boolean parralel = false;
        float rxs = cross(rayDir, wallRay.dir);
        float rxsReciprocal;
        float wallPercent;
        
        if (rxs == 0) {
            rxsReciprocal = 1;
            parralel = true;
        }
        else rxsReciprocal = 1/rxs;

        PVector qSubP = wallRay.start.copy().sub(rayStart);
        
        if (qSubP.x == rayDir.x && qSubP.y == rayDir.y) wallPercent = 0;
        else {
            float qSubPCrossRayDir = cross(qSubP,rayDir);
            if (qSubPCrossRayDir == rxs) wallPercent = 1;
            else wallPercent = qSubPCrossRayDir * rxsReciprocal;
        }
        
        if (wallPercent < 0 || wallPercent > 1) return null;
        else if (parralel) return new Intersection(rayStart,0);
        else {
            float qSubPCrossWallDir = cross(qSubP, wallRay.dir);
            float rayDist = qSubPCrossWallDir * rxsReciprocal;
            if (rayDist > 0) return new Intersection(rayStart.add(rayDir.mult(rayDist)),rayDist);
            else return null;
        }
    }
    
    float cross(PVector v1, PVector v2) {return v1.x*v2.y - v1.y*v2.x;}
}
