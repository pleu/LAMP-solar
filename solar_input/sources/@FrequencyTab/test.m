fr = FrequencyTab;
fr.WavelengthMin = 0.1;
fr.WavelengthMax = 0.7;
fr.write_lsf('test');
% assert(fr.wavelengthCenter==0.4e-6)
% assert(fr.wavelengthSpan==0.6e-6)

