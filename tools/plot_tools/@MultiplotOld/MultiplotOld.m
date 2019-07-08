classdef Multiplot
% MULTIPLOT class for plotting multiple plots on one-axis
% 
% See also 
%
% Copyright 2011
% Paul Leu
% LAMP, University of Pittsburgh   
  properties
    X;       % vector of plot data
    Y;       % vector of plot data
    Colors = 'bgrcmy';
    LegendStrings = ''; 
    XAxisLabel = '';
    YAxisLabel = '';
    Varargin;
  end
  
  properties(Dependent = true) 
    NumPlots;
  end
  
  methods
    
    function [numPlots] = get.NumPlots(mp)
      % We assume it is the lesser dimension; 
      numPlots = min(size(mp.X));
    end
    
    function mp = Multiplot(x, y, varargin)
      mp.X = x;
      mp.Y = y;
      mp.Varargin = varargin;
      if ~isempty(extract_argoption(varargin,'Colors'));
        mp.Colors = extract_argoption(varargin,'Colors');
      end
      if ~isempty(extract_argoption(varargin,'LegendStrings'));
        mp.LegendStrings = extract_argoption(varargin,'LegendStrings');
      end
      if ~isempty(extract_argoption(varargin,'XAxisLabel'));
        mp.XAxisLabel = get_option(varargin,'XAxisLabel');
      end
      if ~isempty(extract_argoption(varargin,'YAxisLabel'));
        mp.YAxisLabel = get_option(varargin,'YAxisLabel');
      end
      mp.ErrorCheck;
    end
    
    function ErrorCheck(mp)
      if all(size(mp.X) ~= size(mp.Y))
        error('x and y must be the same size');
      end
    end
    
    function plot(mp)
      %legendArray = cell(mp.NumPlots,1);
      for i = 1:mp.NumPlots
        optionplot(mp.X, mp.Y, [mp.Varargin, 'Color', mp.Colors(i)]);
        hold on;
      end
      %      legendArray{i} = mp.LegendStrings;
      if mp.NumPlots == 1
        title(mp.LegendStrings);
      else
        legend(mp.LegendStrings);
      end
      xlabel(mp.XAxisLabel);
      ylabel(mp.YAxisLabel);
      grid on;
      
    end
    
    
  end
  
end

