function [output] = set_check_box(value)
  if value == 0 || value == 1
    output = value;
  else
    error('Check box must have value of 0 (off) or 1 (on)');
  end