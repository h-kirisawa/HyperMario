class Mario extends Obj {
  boolean isFlying;
  boolean isMoving;
  boolean getKinoko;
  boolean meteo;

  int isOnping;//横方向に跳ねてる間の硬直
  int onpingFrame;
  Obj dhukushEnemy;
  int dhukushingFrame;
  int ateKinokoFrame;

  float hizumiX, hizumiY, hizumiZ;//カメラワークに影響与えない
  float thetaX, thetaY, thetaZ;//マリオ向き
  float enemyTheta;

  int kinokoCount;


  Mario(float x, float y, float z, String mode) {
    super(x, y, z, mode);
    super.sizeY = DEFAULTSIZE * 2;

    isFlying = true;
    isMoving = false;
    meteo = false;

    isOnping = -1;
    onpingFrame = 0;
    dhukushEnemy = null;
    dhukushingFrame = 0;

    hizumiX = 0;
    hizumiY = 0;
    hizumiZ = 0;
    thetaX = 0;
    thetaY = 0;
    thetaZ = 0;
    enemyTheta = 0;

    getKinoko = false;
    ateKinokoFrame = 0;
  }


  void setIsFlying(boolean isFlying) {
    this.isFlying = isFlying;
  }
  void setIsMoving(boolean isMoving) {
    this.isMoving = isMoving;
  }
  boolean getIsFlying() {
    return isFlying;
  }
  boolean getIsMoving() {
    return isMoving;
  }

  void behave() {
    if (mode == "up"){
      mode = "nomal";
      isFlying = true;
      super.dy = -15;
    }


    //当たり判定
    //colUp
    boolean touch = false;//for内で一度でも接触判定
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {
        case "Onpu":
          //super.setY(obj.get(i).getY() - obj.get(i).getSizeY()/2 - sizeY/2);
          if (meteo) dy = -dy;
          else dy = -25;
          continue;

        case "Kuribo":
          //super.setY(obj.get(i).getY() - obj.get(i).getSizeY()/2 - sizeY/2);
          if (dhukushEnemy != null) dy = -dy;
          else {
            dy = -25;
          }
          //obj.get(i).setIsHizuming(true);
          continue;

        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kinoko":
          getKinoko = true;
          continue;

        default:
          if (dhukushEnemy != null) dy = -dy;
          else touch |= true;
          break;
        }
      } else {
        touch |= false;
      }
    }
    isFlying = !touch;


    //colDown
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderDown(this)) {
        switch(tmp.toString()) {
        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kuribo":
          dhukushEnemy = tmp;
          continue;

        case "Kinoko":
          getKinoko = true;
          continue;

        default:
          //super.setY(obj.get(i).getY() + obj.get(i).getSizeY()/2 + sizeY/2);
          if (dhukushEnemy != null) dy = -dy;
          else dy = 0;
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
        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kuribo":
          dhukushEnemy = tmp;
          break;

        case "Kinoko":
          getKinoko = true;
          continue;

        case "Onpu":
          isOnping = 0;
          break;

        default:
          //super.setX(obj.get(i).getX() - obj.get(i).getSizeX()/2 - sizeX/2 +CLCT);
          if (dhukushEnemy != null) dx = -dx;
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
        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kuribo":
          dhukushEnemy = tmp;
          break;

        case "Kinoko":
          getKinoko = true;
          continue;

        case "Onpu":
          isOnping = 1;
          break;

        default:
          //super.setX(obj.get(i).getX() + obj.get(i).getSizeX()/2 + sizeX/2 -CLCT);
          if (dhukushEnemy != null) dx = -dx;
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
        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kuribo":
          dhukushEnemy = tmp;
          break;

        case "Kinoko":
          getKinoko = true;
          continue;

        case "Onpu":
          isOnping = 2;
          break;

        default:
          //super.setZ(obj.get(i).getZ() - obj.get(i).getSizeZ()/2 - sizeZ/2 +CLCT);
          if (dhukushEnemy != null) dz = -dz;
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
        case "Coin":
        case "PSwitchKasu":
          continue;

        case "Kuribo":
          dhukushEnemy = tmp;
          break;

        case "Kinoko":
          getKinoko = true;
          continue;

        case "Onpu":
          isOnping = 3;
          break;

        default:
          //super.setZ(obj.get(i).getZ() + obj.get(i).getSizeZ()/2 + sizeZ/2 -CLCT);
          if (dhukushEnemy != null) dz = -dz;
          break;
        }
        //break;
      }
    }

    if (getKinoko) {
      kinokoCount++;
      GAMESPD++;
      getKinoko = false;
    }
    if (kinokoCount != 0) {
      colorMode(HSB);
      background((frameCount * 2)%256, 255, 255);
      colorMode(RGB);
    }

    //jump
    if (mousePressed && !isFlying) {
      isFlying = true;
      super.dy = -20;
      jump.play();
      jump.rewind();
    }
    if (isFlying) {
      super.dy += 0.5;
    } else {
      super.dy = 0;
    }

    //音符ブロック側面処理
    if (isOnping != -1) {
      if (onpingFrame < 30) {
        if (isOnping == 0) super.dx = -10;
        else if (isOnping == 1) super.dx = 10;
        else if (isOnping == 2) super.dz = -10;
        else if (isOnping == 3) super.dz = 10;
      } else {
        onpingFrame = -1;
        isOnping = -1;
      }
      onpingFrame++;
    }
    if (dhukushEnemy != null) {
      //クリボーの攻撃処理

      if (dhukushingFrame < 40) {
        if (dhukushingFrame == 0) {
          if (dhukushEnemy.getY() + dhukushEnemy.getSizeY()/2 < y) {
            meteo = true;
            kakin.play();
            kakin.rewind();
          } else {
            dhukushi.play();
            dhukushi.rewind();
          }
        }
        hizumiX = random(-10, 10);
        hizumiY = random(-10, 10);
        hizumiZ = random(-10, 10);
        this.dx = 0;
        this.dy = 0;
        this.dz = 0;
      } else if (dhukushingFrame < 100) {
        //
        if (dhukushingFrame == 40) {
          enemyTheta = getArgumentXZ(dhukushEnemy);

          if (meteo) {
            super.dx = -10 * cos(enemyTheta);
            super.dy = 40;
            super.dz = -10 * sin(enemyTheta);
          } else {
            super.dx = -20 * cos(enemyTheta);
            super.dy = -20;
            super.dz = -20 * sin(enemyTheta);
          }
        }
        //thetaX = frameCount/3.0;
        thetaY = frameCount/5.0;
        thetaZ = frameCount/5.0;
      } else {
        thetaX = 0;
        thetaY = 0;
        thetaZ = 0;
        dhukushingFrame = -1;
        dhukushEnemy = null;
        meteo = false;
      }
      dhukushingFrame++;
    }

    if (isOnping == -1 && dhukushEnemy == null) {
      thetaZ = atan((float)(mouseY - height/2)/(mouseX - width/2));//マリオの向き
      if (mouseX < width/2) thetaZ += PI;
      float dist = dist(mouseX, mouseY, width/2, height/2);

      if (dist > 30) {
        //通常時操作
        isMoving = true;

        //pxpf : px per frame
        float pxpf = (dist - 30)*0.03;
        super.dx = ((pxpf < MARIOSPD)?pxpf : MARIOSPD) * cos(thetaZ);
        super.dz = ((pxpf < MARIOSPD)?pxpf : MARIOSPD) * sin(thetaZ);
      } else {
        isMoving = false;
        super.dx = 0;
        super.dz = 0;
      }
    }
  }
  void move() {
    x += dx;
    y += dy;
    z += dz;

    //当たり判定
    //colUp
    //boolean touch = false;//for内で一度でも接触判定
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {
        case "Coin":
        case "Kinoko":
        case "PSwitchKasu":
          break;

        case "Kuribo":
          if (dhukushEnemy != null) break;
        default:
          super.setY(tmp.getY() - tmp.getSizeY()/2 - sizeY/2);
          break;
        }
        //break;
      }
    }

    //colDown
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderDown(this)) {
        switch(tmp.toString()) {
        case "Coin":
        case "Kuribo":
        case "Kinoko":
        case "PSwitchKasu":
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
        case "Kuribo":
        case "Kinoko":
        case "PSwitchKasu":
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
        case "Coin":
        case "Kuribo":
        case "Kinoko":
        case "PSwitchKasu":
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
        case "Coin":
        case "Kuribo":
        case "Kinoko":
        case "PSwitchKasu":
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
        case "Coin":
        case "Kuribo":
        case "Kinoko":
        case "PSwitchKasu":
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
     translate(x, y + 40, z);
     rotateX(PI/2);
     rotateZ(-PI/2);
     shape(mario_all_obj);
     popMatrix();*/

    //右足
    pushMatrix();
    translate(x + hizumiX, y + 40 + hizumiY, z + hizumiZ);
    rotateX(thetaX + PI/2);
    rotateY(thetaY);
    rotateZ(thetaZ - PI);
    translate(0, -16, 0);
    if (isFlying)rotateY(1.5);
    else if (isMoving)rotateY(PI/3*sin(frameCount/5.0));
    shape(mario_parts_obj[0]);
    popMatrix();

    //左足
    pushMatrix();
    translate(x + hizumiX, y + 40 + hizumiY, z + hizumiZ);
    rotateX(thetaX + PI/2);
    rotateY(thetaY);
    rotateZ(thetaZ - PI);
    translate(0, 16, 0);
    if (isFlying)rotateY(-1);
    else if (isMoving)rotateY(-PI/3*sin(frameCount/5.0));
    shape(mario_parts_obj[0]);
    popMatrix();

    //胴体
    pushMatrix();
    translate(x + hizumiX, y + 40 + hizumiY, z + hizumiZ);
    rotateX(thetaX + PI/2);
    rotateY(thetaY);
    if (isMoving && !isFlying)rotateZ(-0.05*sin(frameCount/5.0));
    else if (!isFlying)rotateZ(-0.1*sin(frameCount/20.0));
    rotateZ(thetaZ - PI);
    shape(mario_parts_obj[1]);
    popMatrix();

    //右腕
    pushMatrix();
    translate(x + hizumiX, y + 40 + hizumiY, z + hizumiZ);
    rotateX(thetaX + PI/2);
    rotateY(thetaY);
    rotateZ(thetaZ - PI);
    translate(0, -25, 50);
    if (isFlying) {
      rotateZ(PI/4);
      rotateY(-1);
    } else if (isMoving)rotateY(-PI/3*sin(frameCount/5.0));
    else rotateY(0.1*sin(frameCount/20.0));
    shape(mario_parts_obj[2]);
    popMatrix();

    //左腕
    pushMatrix();
    translate(x + hizumiX, y + 40 + hizumiY, z + hizumiZ);
    rotateX(thetaX + PI/2);
    rotateY(thetaY);
    rotateZ(thetaZ - PI);
    translate(0, 25, 50);
    if (isFlying) {
      rotateZ(PI/4);
      rotateY(2.5);
    } else if (isMoving)rotateY(PI/3*sin(frameCount/5.0));
    else rotateY(-0.1*sin(frameCount/20.0));
    shape(mario_parts_obj[3]);
    popMatrix();
  }
  String toString() {
    return "Mario";
  }
}
