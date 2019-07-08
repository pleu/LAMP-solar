area = 1.5; %cm^2
iv_data = load('ThinFilm02.txt');
iv = PNJunction_darkIV(iv_data(:,1), iv_data(:,2), area);

%iv = OBJ_fitting_RsRsh(iv_data(:,1), iv_data(:,2), area);
iv.fit('Rs');

figure(1);
clf;
iv.plot_IV;

figure(2);
clf;
iv.plot_IV_with_fit;
