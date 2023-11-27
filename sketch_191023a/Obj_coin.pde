class Coin extends Obj {
  float theta;
  int koiinFrame;//コイーンってなるやつ
  Coin(float x, float y, float z, String mode) {
    super(x, y, z, mode);

    theta = 0;
  }
  void behave() {
    if (mode == "up") {
      if (koiinFrame == 0) {
        coin.play();
        coin.rewind();
      } else if (koiinFrame == 30) {
        obj.remove(objNum);
        shadow.remove(objNum);
      }
      koiinFrame++;
      dy = (koiinFrame - 30)*0.5;
      theta = frameCount/3.0;
    } else {
      //当たり判定
      //colUp
      //boolean touch = false;//for内で一度でも接触判定
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderUp(this)) {
          switch(tmp.toString()) {

          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }
        }
      }


      //colDown
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderDown(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }

          //break;
        }
      }
      //colLe
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderLeft(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }
          //break;
        }
      }
      //colRi
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderRight(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }
          //break;
        }
      }
      //colFRe
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderBack(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }
          //break;
        }
      }
      //colFr
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderFront(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            coin.play();
            coin.rewind();
            continue;

          default:
            break;
          }
          //break;
        }
      }
      theta = frameCount/10.0;
    }
  }  
  void draw() {
    pushMatrix();
    translate(x, y, z);
    rotateX(PI/2);
    rotateZ(theta);
    shininess(3.0);
    shape(coin_obj);
    shininess(0);
    popMatrix();
  }

  String toString() {
    return "Coin";
  }
}
