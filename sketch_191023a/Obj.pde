class Obj {
  protected float sizeX, sizeY, sizeZ;
  protected float x, y, z;
  protected float dx, dy, dz;
  protected int objNum;
  protected String mode;

  public static final float DEFAULTSIZE = 100;

  Obj(float x, float y, float z, String mode) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.mode = mode;
    
    sizeX = sizeY = sizeZ = DEFAULTSIZE;
    dx = dy = dz = 0;
  }

  public float getSizeX() {
    return sizeX;
  }
  public float getSizeY() {
    return sizeY;
  }
  public float getSizeZ() {
    return sizeZ;
  }
  public float getX() {
    return x;
  }
  public float getY() {
    return y;
  }
  public float getZ() {
    return z;
  }
  public void addX(float x) {
    this.x += x;
  }
  public void addY(float y) {
    this.y += y;
  }
  public void addZ(float z) {
    this.z += z;
  }
  public void setX(float x) {
    this.x = x;
  }
  public void setY(float y) {
    this.y = y;
  }
  public void setZ(float z) {
    this.z = z;
  }
  public void setDY(float dy) {
    this.dy = dy;
  }
  public float getDY() {
    return this.dy;
  }
  protected void setObjNum(int objNum) {
    this.objNum = objNum;
  }
  protected int getObjNum(){
    return this.objNum;
  }
  public boolean colliderUp(Obj obj) {
    boolean colX = (abs(obj.x - this.x) < obj.sizeX/2 + this.sizeX/2 -MAXSPD -CLCT);
    boolean colY = (this.y - obj.y <= obj.sizeY/2 + this.sizeY/2) && (this.y - obj.y > 0);////onpu判定のため<=にしてある
    boolean colZ = (abs(obj.z - this.z) < obj.sizeZ/2 + this.sizeZ/2 -MAXSPD -CLCT);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  public boolean colliderDown(Obj obj) {
    boolean colX = (abs(obj.x - this.x) < obj.sizeX/2 + this.sizeX/2 -MAXSPD -CLCT);
    boolean colY = (obj.y - this.y <= obj.sizeY/2 + this.sizeY/2) && (obj.y - this.y > 0);////onpu判定のため<=にしてある
    boolean colZ = (abs(obj.z - this.z) < obj.sizeZ/2 + this.sizeZ/2 -MAXSPD -CLCT);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  public boolean colliderLeft(Obj obj) {
    boolean colX = (this.x - obj.x <= obj.sizeX/2 + this.sizeX/2 -CLCT) && (this.x - obj.x > 0);
    boolean colY = (abs(obj.y - this.y) < obj.sizeY/2 + this.sizeY/2 -MAXSPD);
    boolean colZ = (abs(obj.z - this.z) < obj.sizeZ/2 + this.sizeZ/2 -MAXSPD -CLCT);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  public boolean colliderRight(Obj obj) {
    boolean colX = (obj.x - this.x <= obj.sizeX/2 + this.sizeX/2 -CLCT) && (obj.x - this.x > 0);
    boolean colY = (abs(obj.y - this.y) < obj.sizeY/2 + this.sizeY/2 -MAXSPD);
    boolean colZ = (abs(obj.z - this.z) < obj.sizeZ/2 + this.sizeZ/2 -MAXSPD -CLCT);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  public boolean colliderBack(Obj obj) {
    boolean colX = (abs(obj.x - this.x) < obj.sizeX/2 + this.sizeX/2 -MAXSPD -CLCT);
    boolean colY = (abs(obj.y - this.y) < obj.sizeY/2 + this.sizeY/2 -MAXSPD);
    boolean colZ = (this.z - obj.z <= obj.sizeZ/2 + this.sizeZ/2 -CLCT) && (this.z - obj.z > 0);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  public boolean colliderFront(Obj obj) {
    boolean colX = (abs(obj.x - this.x) < obj.sizeX/2 + this.sizeX/2 -MAXSPD -CLCT);
    boolean colY = (abs(obj.y - this.y) < obj.sizeY/2 + this.sizeY/2 -MAXSPD);
    boolean colZ = (obj.z - this.z <= obj.sizeZ/2 + this.sizeZ/2 -CLCT) && (obj.z - this.z > 0);

    //println(abs(obj.x - this.x), obj.sizeX/2 + this.sizeX/2);
    return colX && colY && colZ;
  }
  //その座標がobj領域内かどうか
  public boolean inObj(float x, float y, float z) {
    boolean inX = (abs(this.x - x) <= sizeX/2);
    boolean inY = (abs(this.y - y) <= sizeY/2);
    boolean inZ = (abs(this.z - z) <= sizeZ/2);
    return inX && inY && inZ;
  }
  /*public boolean inX(float x){
   return abs(this.x - x) <= sizeX/2;
   }
   public boolean inY(float y){
   return abs(this.y - y) <= sizeY/2;
   }
   public boolean inZ(float z){
   return abs(this.z - z) <= sizeZ/2;
   }*/

  float getArgumentXZ(Obj obj) {
    float theta = atan((float)(obj.getZ() - z)/(obj.getX()- x));
    if (obj.getX() < x) theta += PI;
    return theta;
  }
  float getArgumentXZ(Mario mario) {
    float theta = atan((float)(mario.getZ() - z)/(mario.getX()- x));
    if (mario.getX() < x) theta += PI;
    return theta;
  }
  float getDist(Obj obj){
    return dist(x, y, z, obj.getX(), obj.getY(), obj.getZ());
  }
  

  protected void imgbox(PImage img, float x, float y, float z, float thetaX, float thetaY, float thetaZ) {
    //手前面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(-sizeX/2, -sizeY/2, sizeZ/2);
    image(img, 0, 0);
    popMatrix();
    //奥面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(-sizeX/2, -sizeY/2, -sizeZ/2);
    image(img, 0, 0);
    popMatrix();
    //左面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(-sizeX/2, -sizeY/2, sizeZ/2);
    rotateY(PI/2);
    image(img, 0, 0);
    popMatrix();
    //右面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(sizeX/2, -sizeY/2, sizeZ/2);
    rotateY(PI/2);
    image(img, 0, 0);
    popMatrix();
    //上面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(-sizeX/2, -sizeY/2, sizeZ/2);
    rotateX(-PI/2);
    image(img, 0, 0);
    popMatrix();
    //下面
    pushMatrix();
    translate(x, y, z);
    rotateX(thetaX);
    rotateY(thetaY);
    rotateZ(thetaZ);
    translate(-sizeX/2, sizeY/2, sizeZ/2);
    rotateX(-PI/2);
    image(img, 0, 0);
    popMatrix();
  }
  protected void imgbox(PImage img, float x, float y, float z) {
    imgbox(img, x, y, z, 0, 0, 0);
  }

  //相互で衝突判定を行うためmoveとbehaveを分けてある
  void behave() {
  }
  void move() {
    x += dx;
    y += dy;
    z += dz;
  }

  void draw() {
  }
}
