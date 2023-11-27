class Renga extends Obj {
  Renga(float x, float y, float z, String mode) {

    super(x, y, z, mode);
  }

  void draw() {
    imgbox(block_img[2], x, y, z);
  }
  String toString() {
    return "Renga";
  }
}
