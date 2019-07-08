function [] = plotboundary(obj)
  Shape = obj.Shape;
  rTop=Shape(1,1);
  rBot=Shape(2,1);
  l=Shape(3,1);
  plot([-rBot -rTop],[-l l],'w--');
  hold on;
  plot([rBot rTop],[-l l],'w--');
  plot([-rBot rBot],[-l -l],'w--');
  plot([-rTop rTop],[l l],'w--');
end