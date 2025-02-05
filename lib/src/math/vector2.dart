class Vector2 {
  int x = 0;
  int y = 0;

  Vector2({ this.x = 0, this.y = 0});

  factory Vector2.zero() {
    return Vector2(x: 0, y: 0);
  }

  factory Vector2.one() {
    return Vector2(x: 1, y: 1);
  }
}
