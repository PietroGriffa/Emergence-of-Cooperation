function [mat] = test_fun(mat)  % [inputs], (outputs)
   % if I want to change the struct parameters globally, I have to also
   % passe them as outputs in addition to the struct itself
   mat = 2*mat;
