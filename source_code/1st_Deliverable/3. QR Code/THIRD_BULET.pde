PImage img;
void setup() {
size(300, 300);
img = loadImage("QR_CODE.png");
}
void draw() {
background(0);
image(img, 0, 0, 300, 300);
}
