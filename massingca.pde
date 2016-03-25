// MASSING CA: 'Main' setup + draw loop

import processing.opengl.*;
//import processing.video.*;  // MOVIE

//MovieMaker mm; // MOVIE
int[][][] wrldCur;
int[][][] wrldNxt;

int units0 = 0;
int units1 = 0;
int units2 = 0;

int sx, sy, sz;

// Specify a file to load and view a 'world' instead of generating one
// String file = "world15000_1";
String file;

void setup() {
 size(800, 400, P3D);
 sx = 44;
 sy = 10;
 sz = 10;

 if (file == null) {
  wrldCur = intialWrld();
 } else {
  wrldCur = loadWrld(file);
 }
 //mm = new MovieMaker(this, width, height, "worlds.mov"); // MOVIE
}

// 'Main' loop
void draw() {
 evalWrld(wrldCur);
 drawWrld(wrldCur);

 if (file == null) {
  wrldNxt = calcWrld(wrldCur);
  wrldNxt = postProcess(wrldNxt);
  // wrldToFile(wrldCur); // Optionally write to file
  wrldCur = wrldNxt;
 }

 String[] output = {
  "Built/Unbuilt: " + round((float(units1 + units2) / float(units0)) * 100),
  "FAR: " + (float(units1 + units2) / float(sx * sz)),
  "Unit 2: " + units2,
  "Unit 1: " + units1,
  "Unit 0: " + units0
 };

 TagScreen(output, 5);
 //mm.addFrame(); // MOVIE
}

// Calculates values of each voxel
int[][][] calcWrld(int[][][] wrldOld) {
 // this returns a new world from a given world by applying a rule set
 int[][][] wrldNew = new int[sx][sy][sz];

 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    int[] nbhd = getNeighborhood(wrldOld, x, y, z);
    wrldNew[x][y][z] = calcVal(nbhd);
   }
  }
 }
 return wrldNew;
}

// MOVIE
//void keyPressed() { 
//  if (key == ' ') {
//    // Finish the movie if space bar is pressed
//    mm.finish();
//    // Quit running the sketch once the file is written
//    exit();
//  }
//}