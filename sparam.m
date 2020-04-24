function s = sparam(s11,s12,s21,s22,z0,f);
%
% function s = sparam(s11,s12,s21,s22,f);
% 
% ABCD matrix description of a 2-port network with S-parameters
% specified at the frequencies f in row vectors s11,s12,s21,s22
%
% f should be a row vector
% 
% z0 is the characteristic impedance used for the S-parameter
% measurements
%
% Returns a structure containing the 2-port A,B,C,D matrix entries
% at the frequencies in f: s.A, s.B, s.C, s.D

s.A = (1 + s11 - s22 - (s11.*s22 - s12.*s21))./(2*s21);
s.B = (z0*(1+s11 + s22 + (s11.*s22 - s12.*s21)))./(2*s21);
s.C = (1 - s11 - s22 + (s11.*s22 - s12.*s21))./(2.*z0.*s21);
s.D = (1 - s11 + s22 - (s11.*s22 - s12.*s21))./(2*s21);