function s = series(s1,s2);
% 
% function s = series(s1,s2);
%
% Series combination of two 2-port networks, s1 followed by s2
%
% s, s1, and s2 are structures containing the A,B,C,D matrix parameters

s.A = s1.A.*s2.A + s1.B.*s2.C;
s.B = s1.A.*s2.B + s1.B.*s2.D;
s.C = s1.C.*s2.A + s1.D.*s2.C;
s.D = s1.C.*s2.B + s1.D.*s2.D;