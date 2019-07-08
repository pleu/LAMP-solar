diameter = 100;
filename = ['AgNW_TM_d', num2str(diameter), 'nm_p400nm_lambda600nm'];
fr = FieldResults.create_vector(filename, 'H');
clf;
fr.contour('z');
hold on;

theta=0:pi/100:2*pi;
x=diameter/2*cos(theta);
y=diameter/2*sin(theta);
plot(x,y,'white--','LineWidth',2);
axis image;


