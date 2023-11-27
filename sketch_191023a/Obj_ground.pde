class Ground extends Obj {
  Ground(float x, float y, float z, String mode) {

    super(x, y, z, mode);
  }

  void draw() {
    imgbox(block_img[0], x, y, z);
  }
  String toString() {
    return "Ground";
  }
}
