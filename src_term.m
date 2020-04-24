function H = src_term(s,zs,zl);

% function H = src_term(s,zs,zl);
% 
% Return transfer function H = V2/V1 for 2-port network s
% driven with a source impedance zs and
% terminated with an impedance of zl
%
% s is a structure containing the A,B,C,D matrix parameters

H = 1./(s.A + s.B./zl + s.C.*zs + s.D.*zs./zl);