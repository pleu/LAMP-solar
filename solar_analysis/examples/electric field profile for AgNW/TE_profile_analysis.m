diameter = 100;
filename = ['AgNW_TE_d', num2str(diameter), 'nm_p600nm_lambda300nm'];
fr = FieldResults.create_vector(filename, 'E');
clf;
fr.contour('2');

hold on;

theta=0:pi/100:2*pi;
x=diameter/2*cos(theta);
y=diameter/2*sin(theta);
plot(x,y,'white--','LineWidth',2);
axis image;