import processing.video.*;

// Metablhth gia katagrafh video
Capture video;
//Prohgoumeno Frame
PImage prevFrame;

// Poso diaforetiko prepei na einai ena pixel wste na einai pixel kinhshs
float threshold = 50;

void setup() {
  size(320, 240);
  // Using the default capture device
  video = new Capture(this, width, height, "pipeline:autovideosrc");
  video.start();

  // Dhmiourgoume mia kenh eikona sto idio megethos tou video
  prevFrame = createImage(video.width, video.height, RGB);
}

// Neo plaisio diathesimo apo thn camera
void captureEvent(Capture video) {
  // Save previous frame for motion detection!!
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  prevFrame.updatePixels();  
  video.read();
}


void draw() {
  background(0);

  image(video, 0, 0);


  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  // Autes einai oi metablhtes pou tha xreiastoume gia na broume ton meso oro
  float sumX = 0;
  float sumY = 0;
  int motionCount = 0; 

  // Xekiname to loop gia kathe pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      // Current color
      color current = video.pixels[x+y*video.width];

      // Previous color
      color previous = prevFrame.pixels[x+y*video.width];

      // Sugkrinoume xrwmata, Current vs Previous
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);

      // H kinhsh gia ena memonomeno pixel einai h diafora metaxy tou prohgoumenou xrwmatos kai tou trexontos
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // An einai stoixeio eikonas prosthetoume to x me to y
      if (diff > threshold) {
        sumX += x;
        sumY += y;
        motionCount++;
      }
    }
  }

  // H mesh topothesia einai h sunolikh topothesia opoy diaireite me ton arithmo eikonostoixeiwn kinhshs
  float avgX = sumX / motionCount; 
  float avgY = sumY / motionCount; 

  // Sxediazoume kuklo me bash thn mesh kinhsh
  smooth();
  noStroke();
  fill(0);
  rect(avgX, avgY, 20, 20);
}
