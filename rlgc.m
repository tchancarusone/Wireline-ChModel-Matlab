function s = rlgc(r,l,g,c,d,f);
%
% function s = rlgc(r,l,g,c,d,f);
% 
% 2-port network for a transmission line of length d with R, L, G, C
% per unit length specified by r,l,g,c (which may be constants or
% vectors if frequency-dependent)
%
% d is the transmission line length
%
% Returns a structure containing the 2-port A,B,C,D matrix entries
% at the frequencies in f: s.A, s.B, s.C, s.D
%
% f should be a row vector

w = 2*pi*f;
gammad = d*sqrt((r+j*w.*l).*(g+j*w.*c));
z0 = sqrt((r+j*w.*l)./(g+j*w.*c));
z0(1) = sqrt((r(1)+j*w(1).*l(1))./(g(1)+j*w(1).*c(1)));
s.A = cosh(gammad);
s.B = z0.*sinh(gammad);
s.C = sinh(gammad)./z0;
s.D = s.A;
