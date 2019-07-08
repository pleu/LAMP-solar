function savescript(name)

fid = fopen(create_lsf_filename(name), 'a+');
fprintf(fid, 'save("model"); \n');
fprintf(fid, 'if (fileexists(filename+"Reflection.txt")) { \n matlabsave("InputVariables",filename); \n exit; \n } \n');
fprintf(fid, 'else { \n run; \n } \n');
fprintf(fid, 'frequencyTransmission = getdata("monitor_1","f"); \n');
fprintf(fid, 'transmissionData = -transmission("monitor_1"); \n');
fprintf(fid,'dataTransmission = [transpose(frequencyTransmission); transpose(transmissionData)]; \n');
%fprintf(fid,'write("ThinFilmHole"+"Transmission.txt",num2str(dataTransmission));\n');
fprintf(fid,'write(filename+"Transmission.txt",num2str(dataTransmission));\n');
fprintf(fid,'reflectionData = transmission("monitor"); \n');
fprintf(fid,'dataReflection = [transpose(frequencyTransmission); transpose(reflectionData)]; \n');
%fprintf(fid,'write("ThinFilmHole"+"Reflection.txt",num2str(dataReflection)); \n');
fprintf(fid,'write(filename+"Reflection.txt",num2str(dataReflection)); \n');
fprintf(fid,'matlabsave("InputVariables",filename); \n');
fprintf(fid,'exit; \n');
system(('"C:\Program Files\Lumerical\FDTD\bin\fdtd-solutions.exe" -run runFDTD.lsf'));