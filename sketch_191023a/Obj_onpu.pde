class Onpu extends Obj {
  int isHizuming;
  float hizumiX, hizumiY, hizumiZ;
  int hizumiFrame;
  Onpu(float x, float y, float z, String mode) {
    super(x, y, z, mode);

    this.isHizuming = -1;
    this.hizumiX = 0;
    this.hizumiY = 0;
    this.hizumiZ = 0;
    this.hizumiFrame = 0;
  }

  void behave() {
    //当たり判定
    //colUp
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderUp(this)) {
        switch(tmp.toString()) {

        case "Mario":
        case "Kuribo":
        case "Kinoko":
          isHizuming = 0;
          continue;

        default:
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
        case "Kuribo":
        case "Kinoko":
          isHizuming = 1;
          continue;

        default:
          break;
        }

        break;
      }
    }
    //colLe
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      if (tmp.colliderLeft(this)) {
        switch(tmp.toString()) {
        case "Mario":
        case "Kuribo":
        case "Kinoko":
          isHizuming = 2;
          continue;

        default:
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
        case "Kuribo":
        case "Kinoko":
          isHizuming = 3;
          continue;

        default:
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
        case "Kuribo":
        case "Kinoko":
          isHizuming = 4;
          continue;

        default:
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
        case "Kuribo":
        case "Kinoko":
          isHizuming = 5;
          continue;

        default:
          break;
        }

        break;
      }
    }



    if (isHizuming != -1) {
      hizumiFrame++;
      if (hizumiFrame < 10) {
        if (isHizuming == 0) hizumiY = -hizumiFrame*10;
        else if (isHizuming == 1) hizumiY = hizumiFrame*10;
        else if (isHizuming == 2) hizumiX = -hizumiFrame*10;
        else if (isHizuming == 3) hizumiX = hizumiFrame*10;
        else if (isHizuming == 4) hizumiZ = -hizumiFrame*10;
        else if (isHizuming == 5) hizumiZ = hizumiFrame*10;
      } else if (hizumiFrame < 20) {
        if (isHizuming == 0) hizumiY = -(20 - hizumiFrame)*10;
        else if (isHizuming == 1) hizumiY = (20 - hizumiFrame)*10;
        else if (isHizuming == 2) hizumiX = -(20 - hizumiFrame)*10;
        else if (isHizuming == 3) hizumiX = (20 - hizumiFrame)*10;
        else if (isHizuming == 4) hizumiZ = -(20 - hizumiFrame)*10;
        else if (isHizuming == 5) hizumiZ = (20 - hizumiFrame)*10;
      } else {
        isHizuming = -1;
        hizumiFrame = 0;
        hizumiX = 0;
        hizumiY = 0;
        hizumiZ = 0;
      }
    }
  }
  void draw() {
    imgbox(block_img[5], x + hizumiX, y + hizumiY, z + hizumiZ);
  }
  String toString() {
    return "Onpu";
  }
}
