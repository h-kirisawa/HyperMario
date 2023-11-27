import ddf.minim.*;

int[][][] map = new int[30][100][100];
PImage[] block_img = new PImage[8];
PImage[] num_img = new PImage[10];

PShape mario_all_obj;
PShape[] mario_parts_obj = new PShape[4];
PShape coin_obj;
PShape kuribo_all_obj;
PShape[] kuribo_parts_obj = new PShape[2];
PShape kinoko;
PShape PSwitch;
PShape PSwitchKasu;

List<Obj> obj = new MyList2<Obj>();
List<Shadow> shadow = new MyList2<Shadow>();
Mario mario;
Kuribo kuribo;

Minim minim;
AudioPlayer stageBgm;
AudioPlayer jump;
AudioPlayer coin;
AudioPlayer dhukushi;
AudioPlayer hitHatena;
AudioPlayer $getKinoko;
AudioPlayer setup;
AudioPlayer sakebi;
AudioPlayer humi;
AudioPlayer kakin;
AudioPlayer metubo;

void test() {
  List<Integer> test = new MyList2<Integer>(30);
  println(test);
  test.add(3);
  test.add(4);
  test.add(2);
  test.add(null);
  test.add(9);
  println(test);
  println(test.size());

  test.set(0, 18);
  test.set(3, 15);
  test.set(2, 17);
  test.set(2, null);
  //test.setOver(18, null);
  test.set(5, null);
  test.set(11, null);
  test.set(9, 14);
  test.set(13, 33);
  test.set(12, 38);
  println(test);
  println(test.size());
  test.set(20, 100);
  println(test);
  println(test.size());

  println(test.get(1));
  println(test.get(3));
  println(test.get(5));
  println(test.get(6));
  println(test.get(7));
  println(test.get(13));
  println(test.get(19));
  println(test.get(20));

  for (Iterator itr = test.iterator(); itr.hasNext(); ) {
    print(itr.next() +", ");
  }
  println();

  test.remove(3);
  test.remove(4);
  test.remove(5);
  test.remove(11);
  test.remove(12);
  test.remove(13);
  test.remove(0);
  test.remove(14);
  println(test);
  println(test.size());

  for (Iterator itr = test.iterator(); itr.hasNext(); ) {
    print(itr.next() +", ");
  }
  println();

  test.clear();
  println(test);
  println(test.size());

  for (Iterator itr = test.iterator(); itr.hasNext(); ) {
    print(itr.next() +", ");
  }
  println();

  //test.set(-1, 0);

  exit();
}

void loading() {
  //txt
  for (int y = 0; y < 30; y++) {
    String[] strXZ = loadStrings("./data/map/map_"+ y +".txt");
    for (int z = 0; z < 100; z++) {
      String[] strX = strXZ[z].split(",");
      for (int x = 0; x < 100; x++) {
        map[y][z][x] = Integer.parseInt(strX[x]);
      }
    }
  }

  //img
  for (int i = 0; i < 6; i++) {
    block_img[i] = loadImage("./data/img/block_"+ i +".png");
    block_img[i].resize(100, 100);
  }
  for (int i = 0; i < 10; i++) {
    num_img[i] = loadImage("./data/img/num_"+ i +".png");
  }

  //obj
  mario_all_obj = loadShape("./obj/mario_all/tinker.obj");
  mario_all_obj.scale(2);
  mario_parts_obj[0] = loadShape("./obj/mario_leg/tinker.obj");
  mario_parts_obj[0].scale(2);
  mario_parts_obj[1] = loadShape("./obj/mario_body/tinker.obj");
  mario_parts_obj[1].scale(2);
  mario_parts_obj[2] = loadShape("./obj/mario_arm_R/tinker.obj");
  mario_parts_obj[2].scale(2);
  mario_parts_obj[3] = loadShape("./obj/mario_arm_L/tinker.obj");
  mario_parts_obj[3].scale(2);
  coin_obj = loadShape("./obj/coin/tinker.obj");
  coin_obj.scale(5);
  kuribo_all_obj = loadShape("./obj/kuribo_all/tinker.obj");
  kuribo_all_obj.scale(4.8);
  kuribo_parts_obj[0] = loadShape("./obj/kuribo_leg/tinker.obj");
  kuribo_parts_obj[0].scale(4.8);
  kuribo_parts_obj[1] = loadShape("./obj/kuribo_body/tinker.obj");
  kuribo_parts_obj[1].scale(4.8);
  kinoko = loadShape("./obj/kinoko/tinker.obj");
  kinoko.scale(4.8);
  PSwitch = loadShape("./obj/QSwitch/tinker.obj");
  PSwitch.scale(5.1);
  PSwitchKasu = loadShape("./obj/QSwitchkasu/tinker.obj");
  PSwitchKasu.scale(5.1);

  minim = new Minim(this);
  stageBgm = minim.loadFile("./msc/first_stage_msc.mp3/");
  stageBgm.setGain(-10);
  jump = minim.loadFile("./msc/jump.mp3/");
  jump.setGain(-10);
  coin = minim.loadFile("./msc/coin.mp3/");
  coin.setGain(-10);
  dhukushi = minim.loadFile("./msc/dhukushi.mp3/");
  hitHatena = minim.loadFile("./msc/hit_hatena.mp3/");
  hitHatena.setGain(-10);
  $getKinoko = minim.loadFile("./msc/get_kinoko.mp3/");
  setup = minim.loadFile("./msc/Windows XP Startup.wav/");
  setup.setGain(6);
  sakebi = minim.loadFile("./msc/sakebi.mp3");
  sakebi.setGain(-10);
  humi = minim.loadFile("./msc/nc27241.mp3");  
  kakin = minim.loadFile("./msc/nc95782.mp3");
  metubo = minim.loadFile("./msc/Pswitch_msc.mp3");

  //mario = new Mario(0, 0, 0);

  //kuribo = new Kuribo(100, 100, 100);

  //Sub window
  /*//getSurface().setLocation(100, 300);
   String[] args = {"--location=0,0","MarioEye"};
   MarioEye me = new MarioEye();
   PApplet.runSketch(args, me);*/
}
void initialize() {
  for (int y = 0; y < 30; y++) {
    for (int z = 0; z < 100; z++) {
      for (int x = 0; x < 100; x++) {
        switch(map[y][z][x]) {
        default:
          obj.add(null);
          shadow.add(null);
          break;
          
        case 1:
          mario = new Mario(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal");
          obj.add(mario);
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "maru"));
          break;

        case 2:
          obj.add(new Ground(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "momal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          //println(obj.size() - 1);
          break;

        case 3:
          obj.add(new Hard(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "momal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;

        case 4:
          obj.add(new Renga(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "momal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;

        case 5:
          obj.add(new Empty(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "momal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;

        case 6:
          obj.add(new Onpu(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "momal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;

        case 7:
          obj.add(new Coin(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "maru"));
          break;

        case 10:
          obj.add(new Kinoko(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "maru"));
          break;

        case 20:
          obj.add(new Kuribo(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50)));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "maru"));
          break;

        case 50:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal", "Kinoko"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
          
        case 51:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "spin", "Kinoko"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;

        case 52:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal", "Coin"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
                
        case 53:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "spin", "Coin"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
          
        case 54:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "nomal", "Mario"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
          
        case 55:
          obj.add(new Hatena(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50), "spin", "Mario"));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
          
        case 80:
          obj.add(new PSwitch(Obj.DEFAULTSIZE*(x-50), -Obj.DEFAULTSIZE*y, -Obj.DEFAULTSIZE*(z-50)));
          obj.get(obj.size() - 1).setObjNum(obj.size() - 1);
          shadow.add(new Shadow(obj.get(obj.size() - 1), "kaku"));
          break;
        }
      }
    }
  }
}
