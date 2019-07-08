function test_LAMPsolar

%tic
disp('testing LAMP-Solar installation');
disp('this might take some time');
disp(' ');

local_path = get_LAMPsolar_option('LAMPsolar_path');
test_path = {local_path, 'tests'};
files = dir(fullfile(test_path{:}, 'test_*.m'));


for k=1:length(files)
  if ~strcmp(files(k).name, 'test_LAMPsolar.m')
    run(fullfile(test_path{:}, files(k).name));
  end
end