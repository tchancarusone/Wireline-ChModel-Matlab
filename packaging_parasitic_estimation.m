% height of bump/via or length of wire
h = 2e-3;

% separation between neighbouring bumps/vias or wires
s = 85e-6;

% diameter of the anti-pad
D2 = 1e6;
D = D2;

% radium of bump/via/wire
D1 = 15e-6;
r = D1/2;

mu0 = 4*pi*1e-7;
mur = 1;
mu = mu0*mur;

ep0 = 8.85418e-12;
epr = 1;
ep = ep0*epr;

Ls = (mu*h)/(2*pi) * (log((h/r) + sqrt((h/r)^2 + 1)) - sqrt((r/h)^2 + 1) + (r/h) + 0.25)
Lm = (mu*h)/(2*pi) * (log((h/s) + sqrt((h/s)^2 + 1)) - sqrt((s/h)^2 + 1) + (s/h))

Cs = 2.82*ep*r*h / (D - 2*r)
Cm = (pi*ep*h) / log((2*r+s)/(2*r) + sqrt((2*r+s)/(2*r) - 1))
