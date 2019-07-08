function addattribute(obj, name, attribute_value)
% 
  obj.addprop(name);
  eval(['obj.', name, ' = attribute_value']);
end

