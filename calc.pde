// CALC: Logic for setting the values of voxels

int[][][] intialWrld() {
 // Inital state of the world
 int[][][] wrld = new int[sx][sy][sz];

 for (int z = 0; z < sz; z++) {
  for (int y = 0; y < sy; y++) {
   for (int x = 0; x < sx; x++) {
    float val = random(0, 3.0);
    wrld[x][y][z] = round(val);
   }
  }
 }
 return wrld;
}

// Calls various utility functions to determine the value of a voxel.
int calcVal(int[] nbhd) {
 int val = nbhd[13];
 val = checkDensity(nbhd, val);
 val = checkSun(nbhd, val);
 return val;
}

// UTILITIES FOR  CALCVAL

// Checks % full of the neighborhood
float prctFull(int[] nbhd) {
 int tot = 0;
 for (int i = 0; i < nbhd.length; i++)
  if (nbhd[i] > 0) tot++;
 return float(tot) / float(nbhd.length);
}

// Sets value based on density of neighborhood
int checkDensity(int[] nbhd, int val) {
 float percentFull = prctFull(nbhd);
 int me = nbhd[13];
 if (me == 0) { //Dead?
  if (percentFull == 0) return 1; // Mix it up a bit
  if (percentFull > .3333 && nbhd[4] > 0 || nbhd[12] > 0 && nbhd[14] > 0 || nbhd[10] > 0 && nbhd[16] > 0) return 1; // GOL Birth
  return 0; // Stay Dead
 } else {
  if (percentFull > .85) return 1; // Survival by clumping. Alternatively return 1
  if (percentFull < .25 && nbhd[4] < 1 || nbhd[10] < 1 && nbhd[17] < 1 && nbhd[11] < 1 && nbhd[15] < 1) return 0; //GOL Death by loneliness 
  if (percentFull > .5) return 0; // GOL Death by overcrowding
  return 1;
 }
}

// Sets value based on orientation rules + neighborhood
int checkSun(int[] nbhd, int val) {
 int me = nbhd[13];
 if (me > 0) {
  if (nbhd[12] < 1 && nbhd[15] < 1 && nbhd[16] < 1 && nbhd[22] > 0) return 2; //Birth by sun
  if (nbhd[9] > 0 && nbhd[10] > 0 && nbhd[11] > 0 && nbhd[12] > 0 && nbhd[14] > 0 && nbhd[18] > 0 && nbhd[19] > 0 && nbhd[20] > 0 && nbhd[23] > 0) return 0; // Death by sunblocking
 }
 // Rule that tips the balance in favor of diagonal courtyards
 if (nbhd[12] == 2 || nbhd[16] == 2) return 1;
 return val;
}

// Forces certain regions to have certain values to meet Project requirements
int[][][] postProcess(int[][][] wrldOld) {
 int[][][] wrldNxt;
 wrldOld = setRect(wrldOld, 0, 0, 6, sy - 5, sy - 1, 0, sz - 1); // alternating streetspace
 wrldOld = setRect(wrldOld, 0, 9, 13, 0, sy - 1, 2, 5); // groundpenetrates
 wrldOld = setRect(wrldOld, 0, 4, sx - 1, sy - 3, sy - 1, 2, sz - 1); // solarsetback 0
 wrldOld = setRect(wrldOld, 0, 7, sx - 1, sy - 6, sy - 3, 5, sz - 1); // solarsetback 1
 wrldOld = setRect(wrldOld, 0, sx - 3, sx - 1, 0, 1, 0, sz - 1); // cornerclear
 wrldOld = setRect(wrldOld, 0, 0, sx - 1, 0, sy - 1, sz - 1, sz - 1); // heightlimit
 wrldNxt = wrldOld;
 return wrldNxt;
}