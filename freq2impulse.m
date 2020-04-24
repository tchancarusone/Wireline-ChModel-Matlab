function [h,t,hstep] = freq2impulse(H,f);
%
% function [h,t,hstep] = freq2impulse(H,f);
%
%  Returns the impulse response, h, and (optionally) the step response,
%  hstep, for a system with complex frequency response stored in the row
%  vector H and corresponding frequency vector f.  The time vector is
%  returned in t.  The frequency vector must be linearly spaced.

Hd = [H conj(H(end-1:-1:2))];
h = real(ifft(Hd));
hstep = conv(h,ones(1,length(h)));
hstep = hstep(1:length(h));
t = linspace(0,1/f(2),length(h)+1); t = t(1:end-1);
