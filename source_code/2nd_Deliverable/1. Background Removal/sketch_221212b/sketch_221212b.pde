// Kanoume click gia na apothikeusei to background
import processing.video.*;

// Metablhth gia to video
Capture video;

// Apothikeush tou background
PImage backgroundImage;

Movie backgroundReplace;

// poso diaforetiko prepei na einai ena pixel, wste na einai proskhniou
float threshold = 20;

void setup() {
  size(1080, 720);
  video = new Capture(this, width, height, 30);
  video.start();

  // dhmiourgoume kenh eikona sto idio megethos me to video
  backgroundImage = createImage(video.width, video.height, RGB);
  backgroundReplace = new Movie(this,"SOUND.mp4");
  backgroundReplace.loop ();
}

// Neo plaisio diathesimo apo thn kamera
void captureEvent(Capture video) {
  video.read();
}

void movieEvent (Movie backgroundReplace){
  backgroundReplace.read();
}


void draw() {
  // Antistoixoume to orio me bash to pontiki
  threshold = map(mouseX, 0, width, 5, 50);

  // Exetazoume ta stoixeia toy binteo, ta apothikeumena pixel twn eikonidiwn tou background 
  //kathws kai thn prosbash sta stoixeia ths othonhs  
  // Opote prepei loadPixels() gia ola
  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();

  // Xekiname to loop gia na perasoume apo kathe pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width; // Step 1, what is the 1D pixel location
      color fgColor = video.pixels[loc]; // Step 2, what is the foreground color

      // Step 3, what is the background color
      color bgColor = backgroundImage.pixels[loc];

      // Step 4, compare the foreground and background color
      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Einai to xrwma toy proskhnioy diaforetiko xrwma me ayto tou fontou?
      if (diff > threshold) {
        // If so, display the foreground color
        pixels[loc] = fgColor;
      } else {
        // If not, display the beach scene
        pixels[loc] = backgroundReplace.pixels[loc];
      }
    }
  }
  updatePixels();
}

void mousePressed() {
  // Antigrafoume to sugkekrimeno video frame sto background object 
  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}
