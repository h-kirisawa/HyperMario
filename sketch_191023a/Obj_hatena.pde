class Hatena extends Obj {
  float theta;
  boolean isHizuming;
  int hizumiFrame;
  float hizumiY;
  String item;

  Hatena(float x, float y, float z, String mode, String item) {
    super(x, y, z, mode);
    this.item = item;

    this.theta = 0;
  }
  void behave() {
    //println(objnum, obj.get(objnum));
    //println(obj.get(objnum) == this);
    //当たり判定
    //colUp
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {
        case "Mario":
          isHizuming = true;
          //obj.remove(objnum);//destoroy
          //println(this);
          break;

        default:

          break;
        }
        break;
      }
    }

    if (isHizuming) {
      if (hizumiFrame == 0) {
        if (item == "Kinoko" || item == "Mario") {
          hitHatena.play();
          hitHatena.rewind();
        }
      } else if (hizumiFrame < 5) {
        hizumiY = -hizumiFrame*10;
      } else if (hizumiFrame < 10) {
        hizumiY = -(10 - hizumiFrame)*10;
      } else {
        isHizuming = false;
        hizumiFrame = 0;
        hizumiY = 0;
        //ただの入れ替え
        obj.set(objNum, new Empty(x, y, z, mode));
        //shadow.remove(objNum);

        if (item == "Kinoko")obj.add(new Kinoko(x, y, z, "up"));
        if (item == "Coin") obj.add(new Coin(x, y, z, "up"));
        if (item == "Mario") obj.add(new Mario(x, y - Obj.DEFAULTSIZE * 1.6, z, "up"));
        obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
        shadow.add(new Shadow(obj.get(obj.size() - 1), "maru"));
      }
      hizumiFrame++;
    }


    theta = frameCount/30.0;
  }
  void draw() {
    pushMatrix();
    if (mode == "spin")imgbox(block_img[3], x, y + hizumiY, z, 0, theta, 0);
    else imgbox(block_img[3], x, y + hizumiY, z);
    popMatrix();
  }
  String toString() {
    return "Hatena";
  }
}
