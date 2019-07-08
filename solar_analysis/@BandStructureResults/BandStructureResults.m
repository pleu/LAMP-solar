classdef BandStructureResults
  % BANDSTRUCTURERESULTS class for Band Structure Results
  % Input
  % Filename - Filename of results
  
  % Copyright 2011
  % Baomin Wang
  % LAMP, University Pittsburgh
  properties
    Filename;
  end
  properties (Dependent = true)
    TEResults;   % BandStructureData object
    TMResults;   % BandStructureData object
  end
  methods
    function sr = BandStructureResults(filename)
      if nargin == 1
        sr.Filename = filename;
      end
    end
    
    function TEresults = get.TEResults(sr)
      [frequency,wavevector,k_parallel] = ...
        sr.ReadMonitorResults([sr.Filename, 'TE.txt']);
      TEresults = BandStructureData('TE',frequency,wavevector,k_parallel);
    end
    function TMresults = get.TMResults(sr)
      [frequency,wavevector,k_parallel] = ...
        sr.ReadMonitorResults([sr.Filename, 'TM.txt']);
      TMresults = BandStructureData('TM',frequency,wavevector,k_parallel);
    end
    
  end
  
  methods(Static)
    function [frequency, wavevector,k_parallel] = ReadMonitorResults(filename)
      output = load(filename);
      CoNo=size(output,2);
      RowNo=size(output,1);
      kx=output(:,1);
      ky=output(:,2);
      frequency = output(:, 3:CoNo);
      vector=zeros(RowNo,1);
      for i=1:1:RowNo
        if i==1
          vector(i)=kx(i)+ky(i);
        elseif kx(i)>ky(i)
          vector(i)=kx(i)+ky(i);
        else
          vector(i)=1+sqrt((kx(i))^2+(ky(i))^2);
        end
      end
      wavevector=sort(vector);
      k_parallel=sqrt(kx.*kx+ky.*ky);
    end
    
   
  end
end