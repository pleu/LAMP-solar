%% ODF Characteristics
% Explains how to analyze ODFs, i.e. how to compute modal orientations,
% texture index, volume portions, Fourier coefficients and pole figures.
%
%% Open in Editor
%
%% Contents
%
%%
% *Some Sample ODFs*
%
% Let us first begin with some constructed ODFs to be analyzed below

%%
% A bimodal ODF:
cs = symmetry('orthorhombic');ss = symmetry('triclinic');
odf1 = unimodalODF(orientation('Euler',0,0,0,cs,ss)) + ...
  unimodalODF(orientation('Euler',30*degree,0,0,cs,ss))

%% 
% A fibre ODF:
odf2 = fibreODF(Miller(0,0,1),xvector,cs,ss)

%%
% An ODF estimated from diffraction data:
cs = symmetry('-3m',[1.4,1.4,1.5]);
ss = symmetry('triclinic');

fname = {...
  [mtexDataPath '/dubna/Q(10-10)_amp.cnv'],...
  [mtexDataPath '/dubna/Q(10-11)(01-11)_amp.cnv'],...
  [mtexDataPath '/dubna/Q(11-22)_amp.cnv']};
h = {Miller(1,0,-1,0,cs),[Miller(0,1,-1,1,cs),Miller(1,0,-1,1,cs)],Miller(1,1,-2,2,cs)};
c = {1,[0.52 ,1.23],1};

pf = loadPoleFigure(fname,h,cs,ss,'superposition',c,...
  'comment','Dubna Tutorial pole figures');

odf3 = calcODF(pf,'resolution',5*degree,'iter_max',10)


%% Modal Orientations
% The modal orientation of an ODF is the crystallographic prefered
% orientation of the texture. It is characterized as the maximum of the
% ODF. In MTEX it can be computed by the command 
% [[ODF_modalorientation.html,modalorientation]]

%%
% Determine the modalorientation as an
% [[quaternion_index.html,quaternion]]:
center = modalorientation(odf3)

%% 
% Lets mark this prefered orientation in the pole figures

plotpdf(odf3,h,'antipodal');
annotate(center,'marker','s','MarkerFaceColor','black')

%% Texture Characteristics
%
% Texture characteristics are used for a rough classification of ODF into
% sharp and weak ones. The two most common texture characteristcs are the
% [[ODF_entropy.html,entropy]] and the 
% [[ODF_textureindex.html,texture index]]. 

%%
% Compute the texture index:
textureindex(odf1)                   

%%
% Compute the entropy:
entropy(odf2)


%% Volume Portions
%
% Volume portions describes the relative volume of crystals having a
% certain orientation. The relative volume of crystals having a orientation
% close to a given orientation is computed by the command
% [[ODF_volume.html,volume]] and the relative volume of crystals having a 
% orientation close to a given fibre is computed by the command
% [[ODF_fibrevolume.html,fibrevolume]]

%%
% The relative volume of crystals with missorientation maximum 30 degree
% from the modal orientation:
volume(odf3,modalorientation(odf3),30*degree)  

%%
% The relative volume of crystals with missorientation maximum 20 degree
% from the prefered fibre:
fibrevolume(odf2,Miller(0,0,1),xvector,20*degree)  


%% Fourier Coefficients
% 
% The Fourier coefficients allow for a complete characterization of the
% ODF. The are of particular importance for the calcuation of mean
% macroscopic properties e.g. the second order Fourier coefficients 
% characterize thermal expansion, optical refraction index, and 
% electrical conductivity whereas the fourth order Fourier
% coefficients characterize the elastic properties of the specimen.
% Moreover, the decay of the Fourier coefficients is directly related to
% the smoothness of the ODF. The decay of the Fourier coefficients might
% also hint for the presents of a ghost effect. See 
% [[ghost_demo.html,ghost effect]].

%%
% The Fourier coefficients of order 2:
Fourier(odf2,'order',2)              

%%
% The decay of the Fourier coefficients:
close all;
plotFourier(odf3,'bandwidth',32)

%% Pole Figures and Values at Specific Orientations
%
% Using the command <ODF_eval.html eval> any ODF can be evaluated at any
% (set of) orientation(s).

eval(odf1,orientation('Euler',0*degree,20*degree,30*degree))

%%
% For a more complex example let us define a fibre and plot the ODF there.

fibre = orientation('fibre',Miller(1,0,0),yvector);

plot(eval(odf2,fibre));

%%
% Evaluation of the corresponding pole figure or inverse pole figure is
% done using the command <ODF_pdf.html pdf>.

pdf(odf2,Miller(1,0,0),xvector)

%% Extract Internal Representation
%
% As allway the <ODF_get.html> and <ODF_set.html set> offers a simple way
% to addres the internal ODF representation of MTEX.

get(odf3,'center')
