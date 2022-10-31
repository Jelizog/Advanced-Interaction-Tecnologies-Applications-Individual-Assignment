PImage img;
import qrcodeprocessing.*;
Decoder decoder;

void setup() {
decoder = new Decoder(this);
size(300, 300);
img = loadImage("QR_CODE.png");
 
}

void draw() {
background(0);
image(img, 0, 0, 300, 300);
decoder.decodeImage(img);
}

void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  println(statusMsg);
}

void keyReleased() {
  // Depending on which key is hit, do different things:
  switch (key) {
  case 'R':link(decoder.getDecodedString());
  }
}
