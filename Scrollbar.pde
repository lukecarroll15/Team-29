//Scrollbar methods to scroll table writen by Xinyi on 26/03/2024 at 22:50
  int scrollbarPosX, scrollbarPosY, scrollbarWidth, scrollbarHeight;
  int sliderPosY, sliderHeight;
  boolean isDragging = false;  
  color scrollBarColor = color(0, 45, 89);
             
  void drawScrollbar(){
   fill(230);
    rect(scrollbarPosX, scrollbarPosY, scrollbarWidth, scrollbarHeight);

    if (mouseX > scrollbarPosX && mouseX < scrollbarPosX + scrollbarWidth &&
        mouseY > sliderPosY && mouseY < sliderPosY + sliderHeight || isDragging) {
      scrollBarColor = color(0,116,217);
    }
    else{
      scrollBarColor = color(0, 45, 89);
    }
    fill(scrollBarColor);
    rect(scrollbarPosX, sliderPosY, scrollbarWidth, sliderHeight);
  }
  
  void mouseDragged() {
  if (mouseX > scrollbarPosX && mouseX < scrollbarPosX + scrollbarWidth &&
      mouseY > sliderPosY && mouseY < sliderPosY + sliderHeight) {
    isDragging = true;
  }

  if (isDragging) {
    sliderPosY = mouseY - sliderHeight / 2;
    sliderPosY = constrain(sliderPosY, scrollbarPosY, scrollbarPosY + scrollbarHeight - sliderHeight);

    startRow = int(map(sliderPosY, scrollbarPosY, scrollbarPosY + scrollbarHeight - sliderHeight, 0, filteredTable.getRowCount() - visibleRows));
  }
}

void mouseReleased() {
  isDragging = false;
}
