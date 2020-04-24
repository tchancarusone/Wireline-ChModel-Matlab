function s = impedance(z)
%
% function s = impedance(z)
% 
% 2-port network for a series impedance, z (possibly a row vector
% if frequency-dependent)
%
% Returns a structure containing the 2-port A,B,C,D matrix entries
% s.A, s.B, s.C, s.D

l = length(z);
s.A = ones(1,l);
s.B = z;
s.C = zeros(1,l);
s.D = ones(1,l);