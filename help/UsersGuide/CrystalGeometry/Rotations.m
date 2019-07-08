%% Rotations
% Explains how to define rotations and how to switch between different Euler
% angle conventions.
%
%% Open in Editor
%
%% Contents
%
%% Description
%
% Rotations are represented in MTEX by the class *rotation* which is an
% inheritant of the class <quaternion_index.html quaternion> and allow to
% work with rotations as with matrixes in MTEX. 
%
%% Euler Angle Conventions
%
% There are several ways to specify a rotation in MTEX. A
% well known possibility are the so called *Euler angles*. In texture
% analysis the following conventions are commonly used
%
% * Bunge (phi1,Phi,phi2)       - ZXZ
% * Matthies (alpha,beta,gamma) - ZYZ
% * Roe (Psi,Theta,Phi)
% * Kocks (Psi,Theta,phi)
% * Canova (omega,Theta,phi)
%
% *Defining a Rotation by Bunge Euler Angles*
%
% The default Euler angle convention in MTEX are the Bunge Euler angles.
% Here a rotation is determined by three consecutive rotations,
% the first about the z-axis, the second about the y-axis, and the third
% again about the z-axis. Hence, one needs three angles two define an
% rotation by Euler angles. The following command defines a rotation by its
% three Bunge Euler angles

o = rotation('Euler',30*degree,50*degree,10*degree)


%%
% *Defining a Rotation by Other Euler Angle Conventions*
%
% In order to define a rotation by a Euler angle convention different to
% the default Euler angle convention you to specify the convention as an
% additional parameter, e.g.

o = rotation('Euler',30*degree,50*degree,10*degree,'Roe')


%% 
% *Changing the Default Euler Angle Convention*
%
% The default euler angle convention can be changed by the command
% <set_mtex_option.html set_mtex_option>, for a permanent change the
% <matlab:edit('mtex_settings.m') mtex_settings> should be edited. Compare

set_mtex_option('EulerAngleConvention','Roe')
o

%%
set_mtex_option('EulerAngleConvention','Bunge')
o

%% Other Ways of Defining a Rotation
% 
% *The axis angle parametrisation*
%
% A very simple posibility to specify a rotation is to specify the 
% rotational axis and the rotational angle.

o = rotation('axis',xvector,'angle',30*degree)

%%
% *Four vectors defining a rotation*
%
% Given four vectors u1, v1, u2, v2 there is a unique rotations q such that
% q u1 = v1 and q u2 = v2.

o = rotation('map',xvector,yvector,zvector,zvector)

%%
% If only two vectors are specified the rotation with the smalles angle is
% returned that maps the first vector onto the second one.

o = rotation('map',xvector,yvector)

%%
% *A fibre of rotations*
%
% The set of all rotations that rotate a certaion vector u onto a certain 
% vector v define a fibre in the rotation space. A discretisation of such
% an fibre is defined by

u = xvector;
v = yvector;
o = rotation('fibre',u,v)


%%
% *Defining an rotation by a 3 times 3 matrix*

o = rotation('matrix',eye(3))

%%
% *Defining an rotation by a quaternion*
%
% A last possibility is to define a rotation by a quaternion, i.e., by its
% components a,b,c,d.


o = rotation('quaternion',1,0,0,0)

%%
% Actually, MTEX represents internally every rotation as a quaternion.
% Hence, one can write

q = quaternion(1,0,0,0)
o = rotation(q)


%% Calculating with Rotations
%
% *Rotating Vectors*
%
% Let

o = rotation('Euler',90*degree,90*degree,0*degree)

%%
% a certain rotation. Then the rotation of the xvector is computed via

v = o * xvector

%%
% The inverse rotation is computed via the <rotation_mldivide.html backslash operator>

o \ v

%%
% *Concatenating Rotations*
%
% Let

rot1 = rotation('Euler',90*degree,0,0);
rot2 = rotation('Euler',0,60*degree,0);

%%
% be two rotations. Then the rotation defined by applying first rotation
% one and then rotation two is computed by

rot = rot2 * rot1

%%
% *Computing the rotation angle and the rotational axis*
%
% Then rotational angle and the axis
% of rotation can be computed via then commands
% <quaternion_angle.html angle(rot)> and
% <quaternion_axis.html axis(rot)>

angle(rot)/degree

axis(rot)

%%
% If two rotations are specifies the command 
% <quaternion_angle.html angle(rot1,rot2)> computes the rotational angle
% between both rotations

angle(rot1,rot2)/degree


%%
% *The inverse Rotation*
%
% The inverse rotation you get from the command
% <quaternion_inverse.html inverse(rot)>

inverse(rot)

%% Conversion into Euler Angles and Rodrigues Parametrisation
%
% There are methods to transform quaternion in almost any other
% parameterization of rotations as they are:
%
% * <quaternion_Euler.html, Euler(rot)>   in Euler angle
% * <quaternion_Rodrigues.html, Rodrigues(rot)>  in Rodrigues parameter
%

[alpha,beta,gamma] = Euler(rot,'Matthies')


%% Plotting Rotations
%
% The <quaternion_plot.html plot> function allows you to visualize an
% rotation by plotting how the standard basis x,y,z transforms under the
% rotation.

cla reset;set(gcf,'position',[43   362   400   300])
plot(rot)


