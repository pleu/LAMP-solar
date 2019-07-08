function set_LAMPsolar_option(varargin)
% set LAMP-solar option

LAMPsolar_options = getappdata(0,'LAMPsolar_options');
if isempty(LAMPsolar_options), LAMPsolar_options={};end

LAMPsolar_options = set_option(LAMPsolar_options,varargin{:});
setappdata(0,'LAMPsolar_options',LAMPsolar_options);
