classdef Model < handle
  properties
    Structures;
    Source;
    Monitor1;
    Monitor2;
    SimulationCell;
  end

  methods
    function obj = Model(structures, source, monitor1, monitor2, simulationcell)
      if nargin == 0
        obj.Structures = structures;
        obj.Source = source;
        obj.Monitor1 = monitor1;
        obj.Monitor2 = monitor2;
        obj.SimulationCell = simulationcell;
      else
        obj.Structures = structures;
        obj.Source = source;
        obj.Monitor1 = monitor1;
        obj.Monitor2 = monitor2;
        obj.SimulationCell = simulationcell;
      end
    end
  end

  methods(Static)
    test();
  end
end