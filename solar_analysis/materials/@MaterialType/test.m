function [] = test()
  clear all;
  
  md = MaterialType.create('Ag');
  assert(is_numerically_equal(md.Rho,1.58e-8))

  display('test complete');
end

