function [] = write_lsf_comment(fid, comment, commentType)
%WRITE_LSF_SET_COMMENT
%
commentTypes = {'inline', 'line', 'header'};
if nargin == 1
  commentType = 'inline';
end
commentType = set_value_from_list(commentTypes, commentType);

if strcmp(commentType, commentTypes(1))
  fprintf(fid, ['# ', comment]);
elseif strcmp(commentType, commentTypes(2))
  fprintf(fid, ['\n # ', comment]);
else
  fprintf(fid, '#######################\n');
  fprintf(fid, ['# ', comment, '\n']);
  fprintf(fid, '#######################\n');
end

