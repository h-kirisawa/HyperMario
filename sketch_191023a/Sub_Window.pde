class MarioEye extends PApplet {

  MarioEye() {
  }

  void settings() {
    size(800, 600, P3D);
  }

  void setup() {
    rectMode(CENTER);
  }

  void draw() {
    background(200, 200, 255);
    camera(mario.getX(), mario.getY()- 300, mario.getZ()+ 500, mario.getX(), mario.getY(), mario.getZ(), 0, 1, 0);
    for (int j = 0; j < obj.size(); j++) {
      obj.get(j).draw();
    }
    //println(mario);
    //mario.draw();

    /*for(int i = 0; i < obj.size(); i++){
     try{
     obj.get(i).draw();
     } catch (Exception e){
     }
     }*/


    //全身
    pushMatrix();
    translate(0, 0 + 40, 0);
    rotateX(PI/2);
    rotateZ(-PI/2);
    shape(mario_all_obj);
    popMatrix();

    /*background(0);
     translate(width/2, height/2, -10);
     rotateX(noise(.01*frameCount)*4*PI);  
     rotateY(noise(.01*frameCount)*4*PI); 
     rotateZ(.1*frameCount);
     lights();
     rect(0, 0, 100, 10);*/
  }
}
