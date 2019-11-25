function [b] = test_fun(a)  % [inputs], (outputs)
   % if I want to change the struct parameters globally, I have to also
   % passe them as outputs in addition to the struct itself
b = a +2;