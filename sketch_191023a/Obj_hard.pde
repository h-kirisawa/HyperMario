class Hard extends Obj {
  Hard(float x, float y, float z, String mode) {

    super(x, y, z, mode);
  }

  void draw() {
    imgbox(block_img[1], x, y, z);
  }
  String toString() {
    return "Hard";
  }
}
