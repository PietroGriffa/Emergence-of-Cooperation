function [c, d] = test_fun(test)  % [inputs], (outputs)
   % if I want to change the struct parameters globally, I have to also
   % passe them as outputs in addition to the struct itself
c = test.a + test.b
d = test.a - test.b