class Kinoko extends Obj {
  boolean isFlying;
  float theta;
  //boolean isNyokking;
  int nyokkingFrame;//キノコが生えてる途中

  Kinoko(float x, float y, float z, String mode) {
    super(x, y, z, mode);

    this.isFlying = false;
    //isNyokking = true;
  }
  void setIsFlying(boolean isFlying) {
    this.isFlying = isFlying;
  }

  void behave() {
    if (mode == "up") {
      nyokkingFrame++;
      dy = -(float)DEFAULTSIZE/60;
      if (nyokkingFrame == 60) {
        mode = "nomal";
      }
    } else {
      //当たり判定
      //colUp
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderUp(this)) {
          switch(tmp.toString()) {
          case "Mario":
            obj.remove(objNum);
            shadow.remove(objNum);
            $getKinoko.play();
            $getKinoko.rewind();
            break;

          case "Kinoko":
          case "Kuribo":
          case "Coin":
            break;

          case "Onpu":
            this.setDY(-25);
            //obj.get(i).setIsHizuming(true);//
            continue;

          default:
            //this.setIsFlying(false
            dy = -10;
            break;
          }
          break;
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
            $getKinoko.play();
            $getKinoko.rewind();
            break;


          case "Kinoko":
          case "Kuribo":
            break;

          case "Coin":
            break;

          default:
            this.setDY(0);
            break;
          }
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
            $getKinoko.play();
            $getKinoko.rewind();
            break;


          case "Kinoko":
          case "Kuribo":
          case "Coin":
            break;

          default:
            dy = -15;
            break;
          }
          break;
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
            $getKinoko.play();
            $getKinoko.rewind();
            break;


          case "Kinoko":
          case "Kuribo":
          case "Coin":
            break;


          default:
            dy = -15;
            break;
          }
          break;
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
            $getKinoko.play();
            $getKinoko.rewind();
            break;


          case "Kinoko":
          case "Kuribo":
          case "Coin":
            break;


          default:
            dy = -15;
            break;
          }
          break;
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
            $getKinoko.play();
            $getKinoko.rewind();
            break;


          case "Kinoko":
          case "Kuribo":
          case "Coin":
            break;

          default:
            dy = -15;
            break;
          }
          break;
        }
      }

      theta = getArgumentXZ(mario);

      dx = ENEMYSPD * cos(theta);
      dz = ENEMYSPD * sin(theta);

      dy += 0.5;
    }
  }

  void move() {
    x += dx;
    y += dy;
    z += dz;

    //当たり判定
    //colUp
    if (mode != "up") {
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderUp(this)) {
          switch(tmp.toString()) {
          case "Coin":
            break;

          default:
            super.setY(tmp.getY() - tmp.getSizeY()/2 - sizeY/2);
            break;
          }
        }
      }
      //colDown
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderDown(this)) {
          switch(tmp.toString()) {
          case "Coin":
            break;

          default:
            super.setY(tmp.getY() + tmp.getSizeY()/2 + sizeY/2);
            break;
          }
        }
      }
      //colLe
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderLeft(this)) {
          switch(tmp.toString()) {

          case "Coin":
            break;

          default:
            super.setX(tmp.getX() - tmp.getSizeX()/2 - sizeX/2 +CLCT);
            break;
          }
        }
      }
      //colRi
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderRight(this)) {
          switch(tmp.toString()) {
          case "Coin":
            break;


          default:
            super.setX(tmp.getX() + tmp.getSizeX()/2 + sizeX/2 -CLCT);
            break;
          }
        }
      }
      //colFRe
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderBack(this)) {
          switch(tmp.toString()) {

          case "Coin":
            break;


          default:
            super.setZ(tmp.getZ() - tmp.getSizeZ()/2 - sizeZ/2 +CLCT);
            break;
          }
        }
      }
      //colFr
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        if (tmp.colliderFront(this)) {
          switch(tmp.toString()) {

          case "Coin":
            break;

          default:
            super.setZ(tmp.getZ() + tmp.getSizeZ()/2 + sizeZ/2 -CLCT);
            break;
          }
        }
      }
    }
  }

  void draw() {
    //全身
    pushMatrix();
    translate(x, y, z);
    //box(100 ,100, 100);
    //translate(0, 0, 0);
    rotateX(PI/2);
    rotateZ(theta);
    shape(kinoko);
    popMatrix();
  }

  String toString() {
    return "Kinoko";
  }
}
