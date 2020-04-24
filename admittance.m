function s = admittance(y)
%
% function s = admittance(y)
%
% 2-port network for a shunt admittance, y (possibly a row vector
% if frequency-dependent)
%
% Returns a structure containing the 2-port A,B,C,D matrix entries
% s.A, s.B, s.C, s.D

l = length(y);
s.A = ones(1,l);
s.B = zeros(1,l);
s.C = y;
s.D = ones(1,l);