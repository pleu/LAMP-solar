%% Average Material Tensors
% how to calculate average material tensors from ODF and EBSD data
%
%% Open in Editor
%
%% Abstract
% MTEX offers several ways to compute average material tensors from ODFs or EBSD data.
%
%% Contents

% set up a nice colormap
set_mtex_option('defaultColorMap',seismicColorMap);

%% Import EBSD Data
% We start by importing some ebsd data of Glaucophane and Epidote.

ebsd = loadEBSD([mtexDataPath '/EBSDData/data.ctf'],...
  'ignorePhase',[0 3 4])

%%
% Lets visualize the data

plot(ebsd,'colorcoding','hkl','region',[2000 0 3400 375])


%% Data Correction
% next we correct the data by excluding orientations with large MAD value

% define maximum acceptable MAD value
MAD_MAXIMUM= 1.3;

% extract MAD
MAD = get(ebsd,'mad');

% eliminate all meassurements with MAD larger than MAD_MAXIMUM
ebsd = delete(ebsd,MAD>MAD_MAXIMUM)

%% Define Elastic Stiffness Tensors for Glaucophane and Epidote
%
% Glaucophane elastic stiffness (Cij) Tensor in GPa
% Bezacier, L., Reynard, B., Bass, J.D., Wang, J., and Mainprice, D. (2010)
% Elasticity of glaucophane and seismic properties of high-pressure low-temperature
% oceanic rocks in subduction zones. Tectonophysics, 494, 201-210.

% define the tensor coefficients
MGlaucophane =....
  [[122.28   45.69   37.24   0.00   2.35   0.00];...
  [  45.69  231.50   74.91   0.00  -4.78   0.00];...
  [  37.24   74.91  254.57   0.00 -23.74   0.00];...
  [   0.00    0.00    0.00  79.67   0.00   8.89];...
  [   2.35   -4.78  -23.74   0.00  52.82   0.00];...
  [   0.00    0.00    0.00   8.89   0.00  51.24]];

% define the reference frame
csGlaucophane = symmetry('2/m',[9.5334,17.7347,5.3008],...
  [90.00,103.597,90.00]*degree,'X||a*','Z||c','mineral','Glaucophane');

% define the tensor
CGlaucophane = tensor(MGlaucophane,csGlaucophane)

%%
% Epidote elastic stiffness (Cij) Tensor in GPa
% Aleksandrov, K.S., Alchikov, U.V., Belikov, B.P., Zaslavskii, B.I. and Krupnyi, A.I.: 1974
% 'Velocities of elastic waves in minerals at atmospheric pressure and
% increasing precision of elastic constants by means of EVM (in Russian)',
% Izv. Acad. Sci. USSR, Geol. Ser.10, 15-24.

% define the tensor coefficients
MEpidote =....
  [[211.50    65.60    43.20     0.00     -6.50     0.00];...
  [  65.60   239.00    43.60     0.00    -10.40     0.00];...
  [  43.20    43.60   202.10     0.00    -20.00     0.00];...
  [   0.00     0.00     0.00    39.10      0.00    -2.30];...
  [  -6.50   -10.40   -20.00     0.00     43.40     0.00];...
  [   0.00     0.00     0.00    -2.30      0.00    79.50]];
  
% define the reference frame
csEpidote= symmetry('2/m',[8.8877,5.6275,10.1517],...
  [90.00,115.383,90.00]*degree,'X||a*','Z||c','mineral','Epidote');

% define the tensor
CEpidote = tensor(MEpidote,csEpidote)

%% The Average Tensor from EBSD Data
% The Voigt, Reuss, and Hill averages for all phases are computed by

[CVoigt,CReuss,CHill] =  calcTensor(ebsd,CGlaucophane,CEpidote)

%% 
% for a single phase the syntax is 

[CVoigtEpidote,CReussEpidote,CHillEpidote] =  calcTensor(ebsd,CEpidote,'phase',2)


%% ODF Estimation
% Next we estimate an ODF for the Epidote phase

odfEpidote = calcODF(ebsd,'phase',2,'halfwidth',10*degree)


%% The Average Tensor from an ODF
% The Voigt, Reuss, and Hill averages for the above ODF are computed by

[CVoigtEpidote, CReussEpidote, CHillEpidote] =  ...
  calcTensor(odfEpidote,CEpidote)

% set back the colormap
set_mtex_option('defaultColorMap',WhiteJetColorMap);

