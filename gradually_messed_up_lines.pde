
import processing.pdf.*;

int num_pts = 22;
float[] xs = new float[num_pts];
float[] ys = new float[num_pts];

String fname;
fname = String.format("C:/Users/Jason/Documents/Processing Projects/Output/gradually_messed_up_lines_%d%d%d%d%d.pdf", year(), month(), day(), hour(), minute(), second());

boolean rec_flag = false;

if(rec_flag) {
  beginRecord(PDF, fname); 
}

colorMode(HSB, 360,100,100,100);
size(1800,1900);
background(100,25,100);

float y_nz_sd = 1000;
float y_nz_off = .03;
float y_off = 0;

float num_lines = 2200;

float y_spacing = (height / num_lines);
  float rnd_adj = 1.5; //randomGaussian() * 2 + y_spacing;
println(y_spacing);  

//first line
    
    ys[0] = 15;
    xs[0] = 0;
    
    for (int n = 1; n < num_pts-1; n++) {
      ys[n] = 25;
      xs[n] = n * (width/num_pts);
    }
    
    stroke(300, 100, 80, .5);
    strokeWeight(1);
       
       beginShape();
          for (int p = 0; p < num_pts; p++) {
          //  println(xs[p], ys[p]);
            curveVertex(xs[p], ys[p]);
          }
       endShape();
    
  
  // second to num lines
  for(int i = 1; i < num_lines; i++) {
      
      //initial point
      
      //type 1
        //y_off = map(noise(y_nz_sd), 0, 1, 0.5, 1.5);
        //ys[0] = ys[0] + (y_spacing * y_off) + rnd_adj;
      //type 2
        y_off = map(noise(y_nz_sd), 0, 1, -1.5, 1.5);
        ys[0] = ys[0] + y_spacing + (y_off * rnd_adj);// * y_spacing);
      
      ys[0] = min(ys[0], height - 25);  // leave border at bottom
      xs[0] = 0;
      
      //set points on line
      for (int n = 1; n < num_pts-1; n++) {
        
       
       //type 1
         //y_off = map(noise(y_nz_sd), 0, 1, 0.5, 1.5);
         //ys[n] = ys[n] + (y_spacing * y_off) + rnd_adj; //(randomGaussian() * 2.5 + (y_spacing + y_off));
       //type 2
         y_off = map(noise(y_nz_sd), 0, 1, -1.5, 1.5);
         ys[n] = ys[n] + y_spacing + (y_off * rnd_adj);// * y_spacing);
       
        float x_off = (width/num_pts) + random(-20,20);
        xs[n] = xs[n-1] + x_off;
        ys[n] = min(ys[n], height - 25);  // leave border at bottom
               
        y_nz_sd += y_nz_off;     
      }// points on line
      
    //last point
     ys[num_pts-1] = ys[num_pts-2] + map(noise(y_nz_sd), 0, 1, -1 * (i/10), 1 * (i/10));;
     xs[num_pts-1] = width;
    
       noFill();      
       float alp = map(i, 0, num_lines, 55, 20);
       float sat = map(i, 0, num_lines, 0, 100);
       //println(sat, alp);
       
       //simple lines
       //stroke(100, 80, 80, 50);
       //strokeWeight(2);
       //for (int p = 1; p < num_pts; p++) {
       //     line(xs[p-1], ys[p-1], xs[p], ys[p]);
       //}
       
       stroke(300, sat, 80, alp);
       strokeWeight(map(i, 0, num_lines, .5, 2.5));
       
      // curve(xs[0], ys[0], xs[1], ys[1]);
       
       beginShape();
          for (int p = 0; p < num_pts; p++) {
            //println(xs[p], ys[p]);
         
            curveVertex(xs[p], ys[p]);
          }
       endShape();
    
    //
     //    for (int p = 0; p < num_pts; p++) {
     //       ellipse(xs[p], ys[p], 20,20);
     //     }
 
    //println(xs[0], ys[0], xs[num_pts-1], ys[num_pts-1]);

y_nz_sd += y_nz_off;
} // num_lines

  
if (rec_flag) {
  endRecord();
  exit();  
}
