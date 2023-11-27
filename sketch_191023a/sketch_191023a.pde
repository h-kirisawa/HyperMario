/**
 * @author kirisawa
 * @version 1.0
 */

final int CLCT = 15;//当たり判定補正
final float ENEMYSPD = 2;
final float MARIOSPD = 10;// < 20 
float MAXSPD;
float GAMESPD = 1;
String scene = "title";
PFont dasa;

//Obj psw;
void settings() {
  size(displayWidth, displayHeight, P3D);
  //size(500, 500, P3D);
  //P3D==processing.opengl.PGraphics3D
}

void setup() {
  //(右、上、奥)=(x, -y, -z)
  //test();
  textAlign(CENTER, CENTER);
  dasa = createFont("HGPSoeiKakupoptai", 160);
  textFont(dasa);
  fill(0);

  loading();
  initialize();
  //kamemushi = loadShape("kamemushi.obj");

  MAXSPD = max(ENEMYSPD, MARIOSPD);

  //mario.setY(-300);
  mouseX = width/2;
  mouseY = height/2;

  setup.play();
  setup.rewind();
  //
  
  //psw = new PSwitch(0, 0, 0);
}
float m;
void draw() {
  //println(frameRate);
  if (scene == "title") {
    background(200, 200, 255);
    camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
    textSize(120);
    text("ハイパーマリオ\n        オデッセイ", width/2, 300);
    textSize(60);
    text("-Press Enter-", width/2, 600);

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0), height*0.8*sin(frameCount/80.0), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0 + PI/3), height*0.8*sin(frameCount/80.0 + PI/3), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0 + PI * 2/3), height*0.8*sin(frameCount/80.0 + PI * 2/3), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0 + PI * 3/3), height*0.8*sin(frameCount/80.0 + PI * 3/3), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0 + PI * 4/3), height*0.8*sin(frameCount/80.0 + PI * 4/3), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    pushMatrix();
    translate(width/2 + width/2*cos(frameCount/80.0 + PI * 5/3), height*0.8*sin(frameCount/80.0 + PI * 5/3), 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    if (frameCount == 2) {
      if (mario == null) throw new MarioIsNotExistingException("mapにマリオいねーじゃんフィクションは本だけにしとけよw");
    }

    if (keyPressed) {
      if (keyCode == 10) {
        scene = "game";
        frameCount = 0;
        setup.pause();
        stageBgm.loop();
        stageBgm.rewind();
      }
    }
  } else if (scene == "game") {
    background(200, 200, 255);
    //background(240, 240, 240);
    directionalLight(255, 255, 255, -10000, 10000, 10000);
    directionalLight(255, 255, 255, 10000, 10000, -10000);
    //////////////////
    //mario.behave();
    //mario.move();
    double start1, end1;
    start1 = System.currentTimeMillis();
    //通常時挙動
    int a = (int)((frameCount - 1)* GAMESPD);
    int b = (int)((frameCount * GAMESPD) - a);
    for (int i = 0; i < b; i++) {
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        tmp.behave();
      }

      //オブジェクト移動
      for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
        Obj tmp = itr.next();
        switch(tmp.toString()) {
        case "Mario":
        case "Kuribo":
        case "Coin":
        case "Onpu":
        case "Kinoko":
          tmp.move();
          break;
        }
      }
    }
    end1 = System.currentTimeMillis();
    //camera(300*sin(frameCount/50.0), -300*sin(frameCount/50.0), 300*cos(frameCount/50.0), 0, 0, 0, 0, 1, 0);
    //camera(300*sin(frameCount/50.0), 0, 300*cos(frameCount/50.0), 0, 0, 0, 0, 1, 0);
    //camera(mario.getX(), mario.getY()- 300, mario.getZ()+ 500, mario.getX(), mario.getY(), mario.getZ(), 0, 1, 0);
    //camera(kuribo.getX() + 300*sin(frameCount/50.0), 0, kuribo.getZ()+ 300*cos(frameCount/50.0), kuribo.getX(), kuribo.getY(), kuribo.getZ(), 0, 1, 0);
    camera(mario.getX(), ((mario.getY() < 300)?mario.getY():300) - 700, mario.getZ()+ 700, mario.getX(), ((mario.getY() < 300)?mario.getY():300), mario.getZ(), 0, 1, 0);
    textSize(1000);
    //text(frameRate, -4000, 1000);
    
    
    //double start, end;
    double start2, end2;
    start2 = System.currentTimeMillis();
    println(frameRate);
    for (Iterator<Obj> itr = obj.iterator(); itr.hasNext(); ) {
      Obj tmp = itr.next();
      //start = System.currentTimeMillis();
      tmp.draw();
      //end = System.currentTimeMillis();

      /*if (end - start > 50) {
        println((end - start)+"[ms]", tmp);
      }*/
    }
    end2 = System.currentTimeMillis();

    double start3, end3;
    start3 = System.currentTimeMillis();
    for (Iterator<Shadow> itr = shadow.iterator(); itr.hasNext();) {
      Shadow shd = itr.next();
      shd.draw();
    }
    end3 = System.currentTimeMillis();
    
    /*println("move:"+(end1 - start1)+"[ms]");
    println("draw:"+(end2 - start2)+"[ms]");
    println("shad:"+(end3 - start3)+"[ms]");*/
    
    //println(mario);
    //mario.draw();

    //println(mario.getIsFlying());
    //////////////////////////////////////
    //kuribo.draw();

    //println(mario.getIsFlying(), mario.colliderUp(obj.get(0)));
    //println(mario);

    pushMatrix();
    translate(100, 100, 100);
    fill(255, 0, 0);
    //noFill();
    //box(100 ,100, 100);
    popMatrix();

    //println(mario.getY());
    if (mario.getY() > 1000) {
      stageBgm.pause();
      metubo.pause();
      scene = "gameover";
      frameCount = 0;
      sakebi.play();
      sakebi.rewind();
    }
  } else if (scene == "gameover") {
    camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0);
    background(0);
    fill(255, 0, 0, (frameCount < 255)? frameCount : 255);
    textSize(180);
    text("GAMEOVER", width/2, height/2);
    textSize(60);
    text("-RETRY ENTER-", width/2, height/2+300);

    if (keyPressed) {
      if (keyCode == 10) {
        scene = "game";
        sakebi.pause();
        stageBgm.loop();
        stageBgm.rewind();
        obj.clear();
        shadow.clear();
        initialize();

        GAMESPD = 1;
      }
    }
  }


  mouseReleased = false;
}

void stop() {
  stageBgm.close();
  jump.close();
  coin.close();
  dhukushi.close();
  hitHatena.close();
  $getKinoko.close();
  setup.close();
  sakebi.close();
  humi.close();
  kakin.close();
  minim.stop();
  super.stop();
}

boolean mouseReleased = false;
//void mousePressed(){
//}
void mouseReleased() {
  mouseReleased = true;
}

class MarioIsNotExistingException extends RuntimeException {
  public MarioIsNotExistingException(String msg) {
    super(msg);
  }
}

//3D
//https://yoppa.org/proga10/1301.html
/*camera(
 eyeX, eyeY, eyeZ, 視点の位置
 centerX, centerY, centerZ, 注視する中心位置
 upX, upY, upZ カメラの向き
 ) */

//ライトとか
//http://r-dimension.xsrv.jp/classes_j/5_interactive3d/
