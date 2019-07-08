function o = get_LAMPsolar_option(varargin)
% get mtex option

LAMPsolar = getappdata(0,'LAMPsolar_options');
o = get_option(LAMPsolar,varargin{:});
