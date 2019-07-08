%function [] = test()

%load elec_solar_iv_data.mat
iv_data = load('IV2.txt');
iv = PNJunction_darkIV(iv_data(:,2), iv_data(:,3));

%iv.plot_IV;
%end

