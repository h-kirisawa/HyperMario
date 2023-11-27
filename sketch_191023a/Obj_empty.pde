class Empty extends Obj {
  boolean inKinoko;
  int inKinokoFrame;
  float theta;
  Empty(float x, float y, float z, String mode) {
    super(x, y, z, mode);

    inKinoko = true;
    inKinokoFrame = 0;
  }
  void behave() {
    /*if(inKinoko){
     if(inKinokoFrame < 50){
     //全身きのこ
     if(inKinokoFrame == 0){
     
     }
     pushMatrix();
     translate(x, y - inKinokoFrame*sizeY/50, z);
     rotateX(PI/2);
     shape(kinoko);
     popMatrix();
     } else {
     inKinoko = false;
     obj.add(new Kinoko(x, y - sizeY, z));
     }
     
     inKinokoFrame++;
     }*/
    theta = frameCount/30.0;
  }
  void draw() {
    if (mode == "spin")imgbox(block_img[4], x, y, z, 0, theta, 0);
    else imgbox(block_img[4], x, y, z);
  }

  String toString() {
    return "Empty";
  }
}
