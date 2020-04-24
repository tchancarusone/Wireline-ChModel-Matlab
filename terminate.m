function H = terminate(s,zl);

% function H = terminate(s,zl);
%
% s is a structure containing the A,B,C,D matrix parameters
% 
% Return transfer function H = V2/V1 for 2-port network s
% terminated with an impedance of zl which may be a constant
% or a frequency-dependent row vector of length equal to
% length(s.A)

H = 1./(s.A + s.B./zl);
