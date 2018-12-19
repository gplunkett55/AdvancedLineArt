import processing.pdf.*; //<>//
PGraphics vectorImage;
// reserve space in memory for an object of type PImage, to store the source image
PImage source; 
static int SIZE = 5;
 
// setup() function runs once only
void setup() {
 

  // create the canvas
  // WIDTH  HEIGHT
  size(725, 544); 
  vectorImage = createGraphics(width, height, PDF, "output.pdf");
  vectorImage.beginDraw();
  noFill();
  vectorImage.noFill();


  //strokeWeight(2);
  // make the backgound white
  background(255);

  // load "van.JPG" from the "data" folder into source object 
  source = loadImage("IMG_2328 22.jpg");

  // we want to manipulate the pixels of this image directly
  // creates an array named "source.pixels"
  // array will have 424,000 values (width * height = 800 * 530 = 424,000)
  // the array will start at position 0
  // and with 424,000 values
  // the final position will then be at 423,999
  source.loadPixels();
}

// draw() runs repeatedly until we tell it to stop
void draw() {
  // loop from first pixel, at position 0, to final pixel, at position 423,999
  for (int position = 0; position <= 394399; position += 1) {

    // get brightness of current pixel
    float b = 255 - brightness(source.pixels[position]);

    // change brightness value (range of 0 to 255) into a diameter of range 1 to 10 
    float diameter = map(b, 0, 255, 1, SIZE);

    // get the pixel's current position using integer arithmetic, see: http://russellgordon.ca/lcs/ics3u/integer_arithmetic.jpg
    int x = position % width;  // remainder after integer division e.g.: 13 % 5 = 3 
    int y = position / width;  // integer division e.g.: 13 / 5 = 2

    //Only draw an ellipse for some pixels
    //BOOLEAN OPERATORS
    //&& lets us run TWO conditions
    //only run whats in the code block when BOTH conditions are true 
    //CONDITION 1 AND CONDITION 2
    if ( (x > 11) &&  (y > 11) && (y % SIZE == 0) && (x % SIZE == 0)) {

      // draw an ellipse at position of current pixel
      ellipse(x, y, diameter, diameter);
      vectorImage.ellipse(x, y, diameter, diameter);
      // we don't need to animate, so stop the automatic loop
      noLoop();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    vectorImage.endDraw();
    vectorImage.dispose();
    vectorImage = null;
    exit();
  }
}
