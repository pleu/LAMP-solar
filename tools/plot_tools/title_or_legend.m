function [legendHandle] = title_or_legend(name)
% TITLE_OR_LEGEND
% Adds title or legend to figure depending on length of name

  if length(name) == 1
    legendHandle = title(name);
  else
    legendHandle = legend(name);
    legend('boxoff');
  end
end

