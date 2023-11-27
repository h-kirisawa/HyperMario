class PSwitch extends Obj{
  boolean isPushed;
  PSwitch(float x, float y, float z){
    super(x, y, z, null);
  }
  void behave() {
    //println(objnum, obj.get(objnum));
    //println(obj.get(objnum) == this);
    //当たり判定
    //colDown
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderDown(this)) {
        switch(tmp.toString()) {
        case "Mario":
          isPushed = true;
          //obj.remove(objnum);//destoroy
          //println(this);
          break;

        default:

          break;
        }
        break;
      }
    }
    
    if(isPushed){
      stageBgm.pause();
      metubo.play();
      metubo.rewind();
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if(tmp.toString() == "Coin"){
          obj.set(tmp.getObjNum(), new Renga(tmp.x, tmp.y, tmp.z, "momal"));
          obj.get(tmp.getObjNum()).setObjNum(tmp.getObjNum());
          shadow.get(tmp.getObjNum()).mode = "kaku";
          
        } else if(tmp.toString() == "Renga"){
          obj.set(tmp.getObjNum(), new Coin(tmp.x, tmp.y, tmp.z, "nomal"));
          obj.get(tmp.getObjNum()).setObjNum(tmp.getObjNum());
          shadow.get(tmp.getObjNum()).mode = "maru";
          
        }
      }
      obj.set(objNum, new PSwitchKasu(x, y, z));
      obj.get(objNum).setObjNum(objNum);
      //shadow.get(objNum).mode = "kaku";
      isPushed = false;
    }
  }
  void draw() {
    pushMatrix();
    translate(x, y + 5, z);
    rotateX(PI/2);
    rotateZ(PI);
    shape(PSwitch);
    popMatrix();
  }
  String toString() {
    return "PSwitch";
  }
}
