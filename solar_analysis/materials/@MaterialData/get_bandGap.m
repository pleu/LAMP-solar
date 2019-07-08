function bandGap = get_bandGap(material)
  switch material
    case 'Si'
      bandGap = 1.12;
    case 'Ge'
      bandGap = 0.67;
    case 'GaSb'
      bandGap = 0.7;
    case 'GaAs'
      bandGap = 1.43;
    case 'InAs'
      bandGap = 0.354;
    case 'aSi'
      bandGap = 1.6;  ]
    case 'NanoSi'
      bandGap = 1.12;
    otherwise
      display('Unknown Material for band gap');
      bandGap = 0;
  end 
end

