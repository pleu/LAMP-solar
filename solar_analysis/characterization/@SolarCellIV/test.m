%function [] = test()

load elec_solar_iv_data.mat

iv = SolarCellIV(iv_data(1).v, iv_data(1).i, 10);

iv.plot_IV2;
%end

