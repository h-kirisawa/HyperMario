class Kuribo extends Obj {
  boolean isFlying;
  boolean isMoving;
  int isNotMovingFrame;
  boolean getKinoko;
  //int getKinokoFrame;
  float theta;
  Kuribo(float x, float y, float z) {
    super(x, y, z, null);

    this.isFlying = false;
    this.isMoving = true;
    this.isNotMovingFrame = 0;
  }
  void setIsFlying(boolean isFlying) {
    this.isFlying = isFlying;
  }
  //void behave(){}
  //void draw(){}
  void behave() {
    //当たり判定
    //colUp
    boolean touch = false;//for内で一度でも接触判定
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {
        case "Mario":
          isMoving = false;
          //super.setY(obj.get(i).getY() - obj.get(i).getSizeY()/2 - sizeY/2);
          break;

        case "Coin":
          break;

        case "Kinoko":
          getKinoko = true;
          break;

        case "Onpu":
          this.setDY(-25);
          //obj.get(i).setIsHizuming(true);//
          continue;

        default:
          touch |= true;
          break;
        }
        //break;
      } else {
        //段差からジャンプ
        /*if(!isFlying){
         setIsFlying(true);
         setDY(-15);
         }*/
        touch |= false;
      }
    }
    if (!isFlying && !touch) {
      isFlying = true;
      dy = -15;
    }
    isFlying = !touch;
    //colDown
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderDown(this)) {
        switch(tmp.toString()) {
        case "Mario":
          obj.remove(objNum);
          shadow.remove(objNum);
          humi.play();
          humi.rewind();
          break;

        case "Coin":
          break;

        case "Kinoko":
          getKinoko = true;
          break;

          /*case "Kinoko":
           case "Kuribo":
           super.setY(obj.get(i).getY() + obj.get(i).getSizeY()/2 + sizeY/2);
           break;*/

        default:
          this.setDY(0);
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
          isMoving = false;
          break;

        case "Coin":
          //case "Kinoko":
        case "Kuribo":
          break;

        case "Kinoko":
          getKinoko = true;
          break;  

        default:
          if (!isFlying) {
            setIsFlying(true);
            setDY(-15);
          }
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
          isMoving = false;
          break;

        case "Coin":
          //case "Kinoko":
        case "Kuribo":
          break;

        case "Kinoko":
          getKinoko = true;
          break;

        default:
          if (!isFlying) {
            setIsFlying(true);
            setDY(-15);
          }
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
          isMoving = false;
          break;

        case "Coin":
          //case "Kinoko":
        case "Kuribo":
          break;

        case "Kinoko":
          getKinoko = true;
          break;

        default:
          if (!isFlying) {
            setIsFlying(true);
            setDY(-15);
          }
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
          isMoving = false;
          break;

        case "Coin":
          break;

        case "Kinoko":
          getKinoko = true;
          break;

          //case "Kinoko":
        case "Kuribo":
          break;

        default:
          if (!isFlying) {
            setIsFlying(true);
            setDY(-15);
          }
          break;
        }
        //break;
      }
    }

    if (isFlying) {
      dy += 0.5;
    } else {
      dy = 0;
    }

    theta = getArgumentXZ(mario);//クリボー

    if (isMoving) {
      if (getDist(mario) < 600) {
        dx = ENEMYSPD * cos(theta);
        dz = ENEMYSPD * sin(theta);
      } else {
        dx = 0;
        dz = 0;
      }
    } else {
      isNotMovingFrame++;
      if (isNotMovingFrame < 60) {
        dx = 0;
        dy = 0;
        dz = 0;
      } else {
        isMoving = true;
        isNotMovingFrame = 0;
      }
    }
    
    if(y > 1000){
      obj.remove(objNum);
      shadow.remove(objNum);
    }
  }

  void move() {
    x += dx;
    y += dy;
    z += dz;

    //当たり判定
    //colUp
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {
        case "Mario":
        case "Coin":
          //case "Kinoko":
          //case "Kuribo":
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
        case "Mario":
        case "Coin":
          //case "Kinoko":
          //case "Kuribo":
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
        case "Mario":
        case "Coin":
          //case "Kinoko":
          break;

        default:
          super.setX(tmp.getX() - tmp.getSizeX()/2 - sizeX/2 +CLCT);
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
        case "Coin":
          //case "Kinoko":
          break;

        default:
          super.setX(tmp.getX() + tmp.getSizeX()/2 + sizeX/2 -CLCT);
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
        case "Coin":
          //case "Kinoko":
          break;

        default:
          super.setZ(tmp.getZ() - tmp.getSizeZ()/2 - sizeZ/2 +CLCT);
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
        case "Coin":
          //case "Kinoko":
          break;

        default:
          super.setZ(tmp.getZ() + tmp.getSizeZ()/2 + sizeZ/2 -CLCT);
          break;
        }
        //break;
      }
    }
  }

  void draw() {
    /*//全身
     pushMatrix();
     translate(x, y + 25, z);
     rotateX(PI/2);
     rotateZ(PI);
     shape(kuribo_all_obj);
     popMatrix();*/

    //右足
    pushMatrix();
    translate(x, y, z);
    rotateX(PI/2);
    rotateZ(PI/2 + theta);
    translate(24, -10, -25);
    rotateX(0.5*sin(frameCount/5.0) + 0.2);
    shape(kuribo_parts_obj[0]);
    popMatrix();

    //左足
    pushMatrix();
    translate(x, y, z);
    rotateX(PI/2);
    rotateZ(PI/2 + theta);
    translate(-24, -10, -25);
    rotateX(-0.5*sin(frameCount/5.0) + 0.2);
    shape(kuribo_parts_obj[0]);
    popMatrix();

    //胴体
    pushMatrix();
    translate(x, y, z);
    rotateX(PI/2);
    rotateZ(PI/2 + 0.1*sin(frameCount/5.0) + theta);
    translate(0, 0, -25 + 2*sin(frameCount/2.5));
    shape(kuribo_parts_obj[1]);
    popMatrix();
  }

  String toString() {
    return "Kuribo";
  }
}
