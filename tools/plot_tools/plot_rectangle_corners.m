function [p] = plot_rectangle_corners(p, varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%p = calculate_rectangle(x, y, w, h);
p = [p(1) p(3);
  p(1) p(4);
  p(2) p(4);
  p(2) p(3);
  p(1) p(3)];

optionplot(p(:, 1), p(:, 2), varargin{:});

end