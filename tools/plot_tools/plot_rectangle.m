function [p] = plot_rectangle(x, y, w, h, varargin)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

p = calculate_rectangle(x, y, w, h);
optionplot(p(:, 1), p(:, 2), varargin{:});



end

