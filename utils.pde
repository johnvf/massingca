// UTILS: Various helper functions

// val: The var that holds the state of each pixel.
// wrld: The var that contains a 3D matrix of all pixels.
// neighborhood: The var that is a sub-matrix of 'wrld' holding a given pixel's surrounding values.

// Sets a rectangular prism of voxels to a given value
int[][][] setRect(int[][][] wrld, int val, int x0, int x1, int y0, int y1, int z0, int z1) {
 // here you define the inital state of the world
 for (int z = z0; z < z1 + 1; z++) {
  for (int y = y0; y < y1 + 1; y++) {
   for (int x = x0; x < x1 + 1; x++) {
    wrld[x][y][z] = int(val);
   }
  }
 }
 return wrld;
}

// Returns the neigborhood for a given voxel in the 'world'
int[] getNeighborhood(int[][][] wrld, int x, int y, int z) {
 //println("getNeighborhood("+x+","+y+","+z+")");
 int[] ret = new int[] {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 
 //Level +1, Row +1
 if ((x > 0) && (y < sy - 1) && (z < sz - 1)) ret[0] = wrld[x - 1][y + 1][z + 1];
 if ((true) && (y < sy - 1) && (z < sz - 1)) ret[1] = wrld[x][y + 1][z + 1];
 if ((x < sx - 1) && (y < sy - 1) && (z < sz - 1)) ret[2] = wrld[x + 1][y + 1][z + 1];
 //Level +1, Row 0
 if ((x > 0) && (true) && (z < sz - 1)) ret[3] = wrld[x - 1][y][z + 1];
 if ((true) && (true) && (z < sz - 1)) ret[4] = wrld[x][y][z + 1];
 if ((x < sx - 1) && (true) && (z < sz - 1)) ret[5] = wrld[x + 1][y][z + 1];
 //Level +1, Row -1
 if ((x > 0) && (y > 0) && (z < sz - 1)) ret[6] = wrld[x - 1][y - 1][z + 1];
 if ((true) && (y > 0) && (z < sz - 1)) ret[7] = wrld[x][y - 1][z + 1];
 if ((x < sx - 1) && (y > 0) && (z < sz - 1)) ret[8] = wrld[x + 1][y - 1][z + 1];
 //Level 0, Row +1
 if ((x > 0) && (y < sy - 1) && (true)) ret[9] = wrld[x - 1][y + 1][z];
 if ((true) && (y < sy - 1) && (true)) ret[10] = wrld[x][y + 1][z];
 if ((x < sx - 1) && (y < sy - 1) && (true)) ret[11] = wrld[x + 1][y + 1][z];
 //Level 0, Row 0
 if ((x > 0) && (true) && (true)) ret[12] = wrld[x - 1][y][z];
 if ((true) && (true) && (true)) ret[13] = wrld[x][y][z]; //This is "me"
 if ((x < sx - 1) && (true) && (true)) ret[14] = wrld[x + 1][y][z];
 //Level 0, Row -1
 if ((x > 0) && (y > 0) && (true)) ret[15] = wrld[x - 1][y - 1][z];
 if ((true) && (y > 0) && (true)) ret[16] = wrld[x][y - 1][z];
 if ((x < sx - 1) && (y > 0) && (true)) ret[17] = wrld[x + 1][y - 1][z];
 //Level -1, Row +1
 if ((x > 0) && (y < sy - 1) && (z > 0)) ret[18] = wrld[x - 1][y + 1][z - 1];
 if ((true) && (y < sy - 1) && (z > 0)) ret[19] = wrld[x][y + 1][z - 1];
 if ((x < sx - 1) && (y < sy - 1) && (z > 0)) ret[20] = wrld[x + 1][y + 1][z - 1];
 //Level -1, Row 0
 if ((x > 0) && (true) && (z > 0)) ret[21] = wrld[x - 1][y][z - 1];
 if ((true) && (true) && (z > 0)) ret[22] = wrld[x][y][z - 1];
 if ((x < sx - 1) && (true) && (z > 0)) ret[23] = wrld[x + 1][y][z - 1];
 //Level -1, Row -1
 if ((x > 0) && (y > 0) && (z > 0)) ret[24] = wrld[x - 1][y - 1][z - 1];
 if ((true) && (y > 0) && (z > 0)) ret[25] = wrld[x][y - 1][z - 1];
 if ((x < sx - 1) && (y > 0) && (z > 0)) ret[26] = wrld[x + 1][y - 1][z - 1];

 return ret;
}

// Orbits the camera in response to mouse position
void cameraOrbit() {

 float camX = sx * cos(map(mouseX, 0.0, width, 0.0, (2 * PI))) * 2;
 float camZ = sy * sin(map(mouseX, 0.0, width, 0.0, (2 * PI))) * 2;

 camera(camX, mouseY, camZ, sx / 2, sy / 2, sz / 2, 0.0, -1.0, 0.0);

}

// Draws boxes to represent the 'world'
void drawBoxes(int[][][] wrld) {
 //draw boxes
 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    color c = color(200, 200, 200, 20);
    if (wrld[x][y][z] == 1) c = color(191, 144, 255, 200);
    if (wrld[x][y][z] == 2) c = color(144, 196, 255, 200);
    if (wrld[x][y][z] == 3) c = color(255, 144, 144, 200);
    if (wrld[x][y][z] == 4) c = color(255, 255, 255, 200);
    pushMatrix();
    translate(x, y * 2, z);
    fill(c);
    box(1, 2, 1);
    popMatrix();
   }
  }
 }
}

// Tags the model with lines of text
void TagScreen(String[] lines, int textHeight) {
 pushMatrix();
 rotateX(radians(-90));
 textMode(SHAPE);
 fill(150);
 textSize(textHeight);
 for (int i = 0; i < lines.length; i++) {
  text(lines[i], 0, -(i * (textHeight) + 2), 0);
 }
 rotateX(radians(90));
 popMatrix();
}

// Draws and lights the scene
void drawWrld(int[][][] wrld) {

 //set the scene + camera
 background(255);
 directionalLight(255, 255, 255, -1, -20, 20);
 ambientLight(50, 50, 50, 0, 60, 0);
 cameraOrbit();


 //draw axes + reorient to match Rhino axes
 rotateX(radians(-90));
 stroke(50, 20);
 strokeWeight(5);
 line(0, 0, 100, 0);
 line(0, 0, 0, 100);
 strokeWeight(.1);

 //draw boxes
 drawBoxes(wrld);
 //return axes to processing default
 rotateX(radians(90));
}

// Reads a 'world' from a file
int[][][] loadWrld(String fileName) {
 // here you define the inital state of the world
 String load[] = loadStrings(fileName);
 String lines[] = load[0].split(",");
 println("there are " + lines.length + " lines");
 for (int i = 0; i < lines.length; i++) {
  lines[i].split(",");
 }

 int[][][] wrld = new int[sx][sy][sz];
 int count = 0;

 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    wrld[x][y][z] = int(lines[count]);
    count += 1;
   }
  }
 }
 return wrld;
}

// Writes a 'world' to a file
void wrldToFile(int[][][] wrld) {
 String wrldName;
 wrldName = ("world" + str(frameCount) + ".txt");
 createOutput(wrldName);
 String lyne = new String();
 String[] lynes = new String[0];
 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    lyne += wrld[x][y][z] + ",";

   }
  }
 }
 String[] arrayout = append(lynes, lyne);
 saveStrings(wrldName, arrayout);
}

// Gets totals for the various values in the 'world'
void evalWrld(int[][][] wrldOld) {
 // this gives the proposed world a thumbs up or thumbs down
 units0 = 0;
 units1 = 0;
 units2 = 0;

 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    int val = wrldOld[x][y][z];
    if (val == 0) units0 += 1;
    if (val == 1) units1 += 1;
    if (val == 2) units2 += 1;
   }
  }
 }
}