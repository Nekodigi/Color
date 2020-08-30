import hypermedia.net.*;

float mult = 10;
UDP udp;
String msg = "";

final String IP = "MainPC.local";//please input your local IP
final int PORT = 5000;

void setup() {
  size(500, 500);
  //fullScreen(P3D);
  udp = new UDP(this, PORT);
  udp.listen( true );
}

void draw() {
  //background(255);
  String[] datas = msg.split(",");
  noStroke();
  if(datas.length >= 3){
    fill(int(datas[0])*mult, int(datas[1])*mult, int(datas[2])*mult);
    float x = frameCount%width;
    rect(x, 0, 1, height);
  }
}

void receive( byte[] data, String ip, int port ) {
  msg = new String( data );
  println(msg);
}
