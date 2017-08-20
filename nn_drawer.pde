void setup(){
  size(1280,720);
  smooth();
  background(0);
  
  ArrayList<PVector> points = genPoints(100);
  ArrayList<Integer> pointSizes = genPointSizes(points);
  ArrayList<Integer> pointBlurSizes = genBlurSizes(pointSizes);
  ArrayList<PVector> lines = genLineVectors(points.size(), 500);
  ArrayList<Integer> lineSizes = genLineSizes(lines, pointSizes);
  
  fill(119, 210, 255);
  stroke(119, 210, 255);
  drawLines(lines, lineSizes, points);
  drawPoints(points, pointBlurSizes);
  blur(3);
  fill(68, 191, 252);
  stroke(68, 191, 252);
  drawPoints(points, pointSizes);
  blur(1);
}

ArrayList<PVector> genPoints(int amt){
  ArrayList<PVector> result = new ArrayList<PVector>();
  
  for(int i = 50; i <= width - 50; i += 50){
    for(int j = 50; j <= height - 50; j += 50){
      result.add(new PVector(i, j));
    }
  }
  
  return result;
}

ArrayList<PVector> genLineVectors(int numPoints, int amt){
  ArrayList<PVector> result = new ArrayList<PVector>();

  for(int i = 0; i < amt; i++){
    result.add(new PVector(int(random(0, numPoints)), int(random(0, numPoints))));
  }
  
  return result;
}

ArrayList<Integer> genLineSizes(ArrayList<PVector> lineVectors, ArrayList<Integer> pointSizes){
  ArrayList<Integer> lineSizes = new ArrayList<Integer>();
  
  for(int i = 0; i < lineVectors.size(); i++){
    PVector lineVector = lineVectors.get(i);
    int pointSize = min(pointSizes.get(int(lineVector.x)), pointSizes.get(int(lineVector.y)));
    lineSizes.add(int(random(1, pointSize/4)));
  }
    
  return lineSizes;
}

ArrayList<Integer> genPointSizes(ArrayList<PVector> points){
  ArrayList<Integer> result = new ArrayList<Integer>();

  for(PVector point : points){
    result.add(int(random(5, 12)));
  }
  
  return result;
}

void drawLines(ArrayList<PVector> lineVectors, ArrayList<Integer> lineSizes, ArrayList<PVector> points){
  for(int i = 0; i < lineVectors.size(); i++){
    PVector lineVector = lineVectors.get(i);
    int lineSize = lineSizes.get(i);
    strokeWeight(lineSize);
    PVector point1 = points.get(int(lineVector.x));
    PVector point2 = points.get(int(lineVector.y));
    line(point1.x, point1.y, point2.x, point2.y);
  }
}

ArrayList<Integer> genBlurSizes(ArrayList<Integer> sizes){
  ArrayList<Integer> result = new ArrayList<Integer>();

  for(Integer size : sizes){
    result.add(int(size * random(1.4f, 2.0f)));
  }
  
  return result;
}

void drawPoint(int x, int y){
  int size = int(random(5, 12));
  int glowSize = int(size * random(1.2f, 2.0f));
  noStroke();
  ellipse(x,y,glowSize,glowSize);
  noStroke();
  ellipse(x,y,size,size);
}

void blur(int amt){
  filter(BLUR, amt);
}

void drawPoints(ArrayList<PVector> points, ArrayList<Integer> sizes){
  for(int i = 0; i < points.size(); i++){
    PVector point = points.get(i);
    int size = sizes.get(i);
    noStroke();
    ellipse(point.x, point.y, size, size);
  }
}

void draw(){}