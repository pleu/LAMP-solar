function [p] = plot_ellipse(x, y, a, b, angle, varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

p = calculate_ellipse(x, y, a, b, angle);
optionplot(p(:, 1), p(:, 2), varargin);



end

