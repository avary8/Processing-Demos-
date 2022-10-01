class MovingObject {
  PVector position = new PVector();
  PVector direction = new PVector();
  float speed;

  public MovingObject(float spd, PVector pos) {
    speed = spd;
    position.set(pos);
  }

  void Update(PVector targetPos) {
    PVector original = new PVector(targetPos.x - position.x, targetPos.y - position.y);
    direction.set(original);
    direction.normalize();
    direction.mult(speed);

    if (original.mag() > direction.mag()) {
      position.add(direction);
    } else {
      position.add(original);
    }
  }


  void Draw() {
    circle(position.x, position.y, 50);
    
    strokeWeight(5);
    direction.normalize();
    direction.mult(50);
    stroke(0);
    line(position.x, position.y, position.x + direction.x, position.y + direction.y);
  }
}
