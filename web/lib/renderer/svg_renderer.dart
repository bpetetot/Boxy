part of boxy;

class SvgRenderer {

  SvgSvgElement svgView;
  
  int WIDTH = 800;
  int HEIGHT = 600;
  
  SvgRenderer() {
    svgView = new SvgSvgElement();
    svgView.attributes = {
      'width' : '${WIDTH}',
      'height' : '${HEIGHT}'
    };
    
  }
  
  void attach(String viewId) {
    Element div = querySelector(viewId);
    div.append(svgView);
  }
  
  void render(Shape shape)  {  
    // Create Widget
    SvgElement widget = shape.createWidget(svgView);
    
    // Add widget to the SVG view
    svgView.append(widget);
  }

  void displayGrid() {
    
    int step = 20;
    
    for (int i = 0; i < HEIGHT; i=i+step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
         "x1": "0",
         "y1": "${i}",
         "x2": "${WIDTH}",
         "y2": "${i}",
         "stroke": "grey",
         "stroke-width": "0.2"
       };
      svgView.append(line);
    }
    
    for (int i = 0; i < WIDTH; i=i+step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
         "x1": "${i}",
         "y1": "0",
         "x2": "${i}",
         "y2": "${HEIGHT}",
         "stroke": "grey",
         "stroke-width": "0.2"
       };
      svgView.append(line);
    }
    
  }
  
}
