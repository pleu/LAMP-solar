classdef CrystaLattice
  %UNTITLED2 Summary of this class goes here
  %   Detailed explanation goes here
  
  properties
    Lattice
    Locations;
    AtomicNumbers;
    
    % http://www.lanl.gov/orgs/adtsc/publications/science_highlights_2010/2barber.pdf
  end
  
  methods
    function obj = CrystalLattice(lattice, locations, atomicNumbers)
      if nargin == 0
      else
        obj.Lattice = lattice;
        obj.Locations = locations;
        obj.AtomicNumbers = atomicNumbers;
      end
    end
    
    function diffractionPatttern = calc_diffraction_pattern(lattice, locations, atomicNumbers)
      
      
    end
    
  end
  
end

