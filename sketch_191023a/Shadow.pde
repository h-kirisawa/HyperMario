class Shadow {
  Obj thing;
  String mode;
  float FINENES = 0.1;//影描画の粗さ
  final float size = 40;//影半径 (< 50)
  float x, y, z;//影中心座標
  Shadow(Obj thing, String mode) {
    this.thing = thing;
    this.mode = mode;
  }
  void draw() {
    if (thing == null) return;

    this.x = thing.getX();
    this.z = thing.getZ();
    int numX = round(thing.getX()/Obj.DEFAULTSIZE)+50;
    int numY = round(thing.getY()/-Obj.DEFAULTSIZE);
    int numZ = round(thing.getZ()/-Obj.DEFAULTSIZE)+50;

    

    switch(mode) {
    case "maru":

      Obj[][] tmp = {
        {null, null, null}, 
        {null, null, null}, 
        {null, null, null}};

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          for (int k = 1; k <= numY; k++) {//自身を含めないのでk=1
            if ((numY-k)< 0 || (j-1+numZ)< 0 || (i-1+numX) < 0) break;
            if ((numY-k)>= 30 || (j-1+numZ)>= 100 || (i-1+numX) >= 100) break;

            Obj memo = obj.get((numY-k)*10000 + (j-1+numZ)*100 + (i-1+numX));
            if (memo == null) continue;
            switch(memo.toString()) {
            case "Empty":
            case "Ground":
            case "Hard":
            case "Hatena":
            case "Onpu":
            case "Renga":
              tmp[j][i] = memo;
              break;

            default:
              continue;
            }
            break;
          }
        }
      }

      /*if(thing.toString() == "Coin" && true){
       println(tmp[0][0], tmp[0][1], tmp[0][2]);
       println(tmp[1][0], tmp[1][1], tmp[1][2]);
       println(tmp[2][0], tmp[2][1], tmp[2][2]);
       }*/

      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (tmp[i][j] == null) continue;
          y = (tmp[i][j].getY() - tmp[i][j].getSizeY()/2) - 1; 
          float start1 = 0, end1 = 0, start2 = 0, end2 = 0;//
          float objEdgeX = x, objEdgeZ = z;
          float XL = acos((tmp[i][j].getX()- tmp[i][j].getSizeX()/2 - x)/size);//z軸と平行な直線のx座標
          float XH = acos((tmp[i][j].getX()+ tmp[i][j].getSizeX()/2 - x)/size);//from 0 to PI 
          float ZL = asin((tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2 - z)/size);//from -PI/2 to PI/2
          float ZH = asin((tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2 - z)/size);
          boolean onXL = !Float.isNaN(XL);//値が虚数になる（実数解をもたない）なら接してない
          boolean onXH = !Float.isNaN(XH);
          boolean onZL = !Float.isNaN(ZL);
          boolean onZH = !Float.isNaN(ZH);

          switch(10*i+j) {
          case 00:
            if (!onXL && onXH && onZL && !onZH) {
              start1 = XH;
              end1 = PI - ZL;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            }
            break;

          case 01:
            if (onXL && !onXH && onZL && !onZH) {
              start1 = ZL;
              end1 = min(XL, PI - ZL);
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            } else if (!onXL && !onXH && onZL && !onZH) {
              start1 = ZL;
              end1 = PI - ZL;
              objEdgeX = x;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            } else if (!onXL && onXH && onZL && !onZH) {
              start1 = max(XH, ZL);
              end1 = PI - ZL;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            }
            break;

          case 02:
            if (onXL && !onXH && onZL && !onZH) {
              start1 = ZL;
              end1 = XL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            }
            break;

          case 10:
            if (!onXL && onXH && !onZL && onZH) {
              start1 = max(PI - ZH, XH);
              end1 = TWO_PI - XH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (!onXL && onXH && !onZL && !onZH) {
              start1 = XH;
              end1 = TWO_PI - XH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = z;
            } else if (!onXL && onXH && onZL && !onZH) {
              start1 = XH;
              end1 = min(PI - ZL, TWO_PI - XH);
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            }
            break;

          case 11:
            if (!onXL && !onXH && !onZL && !onZH) {
              start1 = 0;
              end1 = TWO_PI;
              objEdgeX = x;
              objEdgeZ = z;
            } else if (!onXL && onXH && !onZL && onZH) {
              start1 = PI - ZH;
              end1 = TWO_PI - XH;
              start2 = TWO_PI + XH;
              end2 = TWO_PI + ZH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (!onXL && !onXH && !onZL && onZH) {
              start1 = PI - ZH;
              end1 = TWO_PI + ZH;
              objEdgeX = x;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (onXL && !onXH && !onZL && onZH) {
              start1 = -XL;
              end1 = ZH;
              start2 = PI - ZH;
              end2 = XL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (onXL && !onXH && !onZL && !onZH) {
              start1 = -XL;
              end1 = XL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = z;
            } else if (onXL && !onXH && onZL && !onZH) {
              start1 = ZL;
              end1 = XL;
              start2 = TWO_PI - XL;
              end2 = PI - ZL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            } else if (!onXL && !onXH && onZL && !onZH) {
              start1 = ZL;
              end1 = PI - ZL;
              objEdgeX = x;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            } else if (!onXL && onXH && onZL && !onZH) {
              start1 = XH;
              end1 = PI - ZL;
              start2 = TWO_PI + ZL;
              end2 = TWO_PI - XH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            } else if (!onXL && onXH && !onZL && !onZH) {
              start1 = XH;
              end1 = TWO_PI - XH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = z;
            }
            break;

          case 12:
            if (onXL && !onXH && !onZL && onZH) {
              start1 = -XL;
              end1 = min(ZH, XL);
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (onXL && !onXH && !onZL && !onZH) {
              start1 = -XL;
              end1 = XL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = z;
            } else if (onXL && !onXH && onZL && !onZH) {
              start1 = max(ZL, -XL);
              end1 = XL;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()- tmp[i][j].getSizeZ()/2;
            }
            break;

          case 20:
            if (!onXL && onXH && !onZL && onZH) {
              start1 = PI - ZH;
              end1 = TWO_PI - XH;
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            }
            break;

          case 21:
            if (onXL && !onXH && !onZL && onZH) {
              start1 = max(TWO_PI - XL, PI - ZH);
              end1 = TWO_PI + ZH;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (!onXL && !onXH && !onZL && onZH) {
              start1 = PI - ZH;
              end1 = TWO_PI + ZH;
              objEdgeX = x;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            } else if (!onXL && onXH && !onZL && onZH) {
              start1 = PI - ZH;
              end1 = min(TWO_PI - XH, TWO_PI + ZH);
              objEdgeX = tmp[i][j].getX()+ tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            }
            break;

          case 22:
            if (onXL && !onXH && !onZL && onZH) {
              start1 = -XL;
              end1 = ZH;
              objEdgeX = tmp[i][j].getX()- tmp[i][j].getSizeX()/2;
              objEdgeZ = tmp[i][j].getZ()+ tmp[i][j].getSizeZ()/2;
            }
            break;
          }

          fill(0, 64);
          noStroke();
          if (start2 < end2) {
            //[1][1]マスにおいて、[0][0],[0][2],[2][0],[2][2]のマスに影が存在しないための条件式
            beginShape();
            //vertex(objEdgeX, y, objEdgeZ);
            vertex(x + size*cos(start1), y, z + size*sin(start1));
            for (float theta = start1; theta < end1; theta += FINENES) {
              vertex(x + size*cos(theta), y, z + size*sin(theta));
            }
            for (float theta = start2; theta < end2; theta += FINENES) {
              vertex(x + size*cos(theta), y, z + size*sin(theta));
            }
            vertex(x + size*cos(end2), y, z + size*sin(end2));
            endShape(CLOSE);
          } else if (start1 < end1) {
            //縦横両方の直線に影が接触しているとき[i][j]のマスには影が存在する場合の条件式
            //縦のみ、横のみの時もここに入る
            beginShape();
            vertex(objEdgeX, y, objEdgeZ);
            vertex(x + size*cos(start1), y, z + size*sin(start1));
            for (float theta = start1; theta < end1; theta += FINENES) {
              vertex(x + size*cos(theta), y, z + size*sin(theta));
            }
            vertex(x + size*cos(end1), y, z + size*sin(end1));
            endShape(CLOSE);
          }
          stroke(0);
        }
      }
      break;

    case "kaku":
      for (int k = 1; k <= numY; k++) {
        if ((numY-k)< 0 || numZ < 0 || numX < 0) break;

        Obj memo = obj.get((numY-k)*10000 + numZ*100 + numX);
        if (memo == null) continue;
        switch(memo.toString()) {
        case "Empty":
        case "Ground":
        case "Hard":
        case "Hatena":
        case "Onpu":
        case "Renga":
          y = (memo.getY() - memo.getSizeY()/2) - 1; 
          fill(0, 64);
          noStroke();
          beginShape();
          vertex(x - thing.getSizeX()/2, y, z - thing.getSizeZ()/2);
          vertex(x - thing.getSizeX()/2, y, z + thing.getSizeZ()/2);
          vertex(x + thing.getSizeX()/2, y, z + thing.getSizeZ()/2);
          vertex(x + thing.getSizeX()/2, y, z - thing.getSizeZ()/2);
          endShape(CLOSE);
          stroke(0);
          break;

        default:
          continue;
        }
        break;
      }
      break;
    }
  }
}
