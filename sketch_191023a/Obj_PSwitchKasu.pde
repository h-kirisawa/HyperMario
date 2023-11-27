class PSwitchKasu extends Obj {
  PSwitchKasu(float x, float y, float z) {
    super(x, y, z, null);
  }
  void behave() {
    if (!metubo.isPlaying()) {
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.toString() == "Coin") {
          obj.set(tmp.getObjNum(), new Renga(tmp.x, tmp.y, tmp.z, "momal"));
          obj.get(tmp.getObjNum()).setObjNum(tmp.getObjNum());
          shadow.get(tmp.getObjNum()).mode = "kaku";
        } else if (tmp.toString() == "Renga") {
          obj.set(tmp.getObjNum(), new Coin(tmp.x, tmp.y, tmp.z, "nomal"));
          obj.get(tmp.getObjNum()).setObjNum(tmp.getObjNum());
          shadow.get(tmp.getObjNum()).mode = "maru";
        }
      }
      stageBgm.loop();
      stageBgm.rewind();
      obj.set(objNum, new PSwitch(x, y, z));
      obj.get(objNum).setObjNum(objNum);
      //shadow.get(objNum).mode = "kaku";
    }
  }
  void draw() {
    pushMatrix();
    translate(x, y + 5, z);
    rotateX(PI/2);
    rotateZ(PI);
    shape(PSwitchKasu);
    popMatrix();
  }
  String toString() {
    return "PSwitchKasu";
  }
}
