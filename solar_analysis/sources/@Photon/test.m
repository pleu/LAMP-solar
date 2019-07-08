function test
% TEST
% tests the Photon class
% 
% Copyright 2012
% Paul Leu
% LAMP, University of Pittsburgh
  ph = Photon(130);
  assert(is_numerically_equal(ph.Energy,9.537243974482946));
  ph.Energy = 3;
  assert(is_numerically_equal(ph.Wavelength,4.132805722275943e+02));
end

