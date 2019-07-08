function savescript(name)

fid = fopen(create_lsf_filename(name), 'a+');

fprintf(fid, 'save("model"); \n');
fprintf(fid, 'if (fileexists(filename+"Reflection.txt")) { \n matlabsave("InputVariables",filename); \n exit; \n } \n');
fprintf(fid, 'else { \n run; \n } \n');

fprintf(fid, 'x = getdata("monitor_2","x"); \n');
fprintf(fid, 'y = getdata("monitor_2","y"); \n');
fprintf(fid, 'z = getdata("monitor_2","z"); \n');
fprintf(fid, 'f = getdata("monitor_2","f"); \n');
fprintf(fid, 'nx = length(x); \n');
fprintf(fid, 'ny = length(y); \n');
fprintf(fid, 'nz = length(z); \n');
fprintf(fid, 'nf = length(f); \n');

fprintf(fid, 'E2_matrix=getelectric("monitor_3"); \n');
fprintf(fid, 'if (havedata("monitor_3","index_x")) {\n n_matrix=getdata("monitor_3","index_x");\n}');
fprintf(fid, 'else { \n n_matrix=getdata("monitor_3","index_z"); \n} \n');

fprintf(fid, 'matlabsave(filename+"X", x); \n');
fprintf(fid, 'matlabsave(filename+"Y", y); \n');
fprintf(fid, 'matlabsave(filename+"Z", z); \n');
fprintf(fid, 'matlabsave(filename+"f", f); \n');

fprintf(fid, 'E2_matrix=getelectric("monitor_3"); \n');
fprintf(fid, 'matlabsave(filename+"E2", E2_matrix); \n');


fprintf(fid, 'W=meshgrid4d(4,x,y,z,f*2*pi); \n');            % create 4D matrix of f and sourcepower that 
fprintf(fid, 'SP=meshgrid4d(4,x,y,z,sourcepower(f)); \n');   % that is the same size as E2 and n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate power absorption 
% as a function of x,y,z,f
fprintf(fid, 'epsilon = eps0*n_matrix^2; \n');
fprintf(fid, 'Pabs_matrix = 0.5*W*E2_matrix*imag(epsilon)/SP; \n');
fprintf(fid, 'Pabs_integrated = integrate2(Pabs_matrix,1:3,x,y,z); \n');

fprintf(fid, 'matlabsave(filename+"Pabs", Pabs_matrix); \n');

% create data sets
fprintf(fid, 'Pabs = rectilineardataset("Pabs",x,y,z); \n');
fprintf(fid, 'Pabs.addparameter("f",f,"wavelength",c/f); \n');
fprintf(fid, 'Pabs.addattribute("Pabs",Pabs_matrix); \n');

fprintf(fid, 'Pabs_total = matrixdataset("Pabs total"); \n');
fprintf(fid, 'Pabs_total.addparameter("f",f,"wavelength",c/f); \n');
fprintf(fid, 'Pabs_total.addattribute("Pabs_total",Pabs_integrated); \n');

fprintf(fid, 'frequencyTransmission = getdata("monitor_1","f"); \n');
fprintf(fid, 'dataAbsorption = [transpose(frequencyReflection); transpose(Pabs_total.Pabs_total)]; \n');
fprintf(fid, 'write(filename+"IntegratedAbsorption.txt",num2str(dataAbsorption));\n');

fprintf(fid, 'matlabsave("InputVariables",filename); \n');
fprintf(fid, 'exit; \n');
system('/Applications/Lumerical/FDTD\ Solutions/FDTD\ Solutions.app/Contents/MacOS/fdtd-solutions -run runFDTD.lsf');