function [] = test()
%TEST Summary of this function goes here
%   Detailed explanation goes here

% Plots the absorption coefficient for an array of materials.
% 
% Copyright 2011
% Paul Leu
  clear all;
  
  md2 = MaterialData('Ag');
  assert(is_numerically_equal(md2.Rho,1.58e-8))
  
  md = MaterialData('Si');
  assert(is_numerically_equal(md.BandGap,1.12))
  
  
%  md(2) = MaterialData('Ge');


end

