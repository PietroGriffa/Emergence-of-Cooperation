%% tabula rasa

close all
clear all
clc


%% test structure

test.a = 1;
test.b = 2; % each time the struct is chaneged it prints out the entire thin => ";"
%test_fun(test);  % passes entire struct to function
%[test.c, test.d] = test_fun(test);
%f = game.c
%fprintf('test.a = %d\ntest.b = %d\ntest.c = %d\n' ,test.a, test.b, test.c)
%n = 8;
%p_coop = 0.8;
%p_loners = 0.1;
%N = 4;
% => p_defectors = 0.2
%pop_composition = rand(n,n);   % generate random composition
%composition =  0.5*(pop_composition < p_loners) + ...
%    (pop_composition > 1-p_coop);
% 0 = defectors
%0.5 = loners
%1 = cooperators

%idx = randperm(n*n, N);

%A = zeros(4);
%A(3) = 1; % accessed 3rd value in matrix, going column wise top to bottom
%=> [ 1 4 7;
%     2 5 8;
%     3 6 9]
%A(5) = 2;
%A([3 5]); % gets values of indexes 3 and 5

A = [ 1 2 3 4 5;
      2 3 4 5 6;
      3 4 5 6 7;
      4 5 6 7 8];
disp(A([ 1 2 3],[ 4 5 1]))

