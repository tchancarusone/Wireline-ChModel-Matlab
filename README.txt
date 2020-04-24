************
Matlab ABCD two-port analysis functions
Version: 2.0
Date: April 1, 2007
Author: Tony Chan Carusone, ECE Dept, U. of Toronto
************

The files in this package are intended for simulating 2-port electrical systems and channel models in Matlab.  They use frequency-dependent transmission (ABCD) matrices to describe the behavior of two-port networks.  Help for each particular function is accessible by typing "help <function-name>" at the matlab command prompt.  Here are some general instructions.

All vectors passed to functions in this package should be row vectors.

A frequency vector, f, should be defined storing the frequency points at which you would like the two-port network defined.  The frequency points need not be linearly spaced (or even in increasing order), although this is useful if you later wish to perform an FFT to get a time-domain step response.

Two-port network descriptions are stored in structures with 4 elements:  x.A, x.B, x.C, x.D

Each element of the structure is a row vector, of length equal to length(f), containing the A, B, C, and D parameters (respectively) at each frequency in f.

The structures may be passed to functions without reference to the underlying ABCD elements.  For example:

%% --------
f = linspace(0,1e9,1000);
x = impedance(10,f);
y = admittance(0.5,f);
z = series(x,y);
%% --------

This structures x & y are two-port networks consisting of simple impedances and admittances.  The structure z is a series combination of x & y.

To get the frequency response of a two-port network, there are 2 options:

1. Use the "terminate" or "src_term" functions, which allow you to terminate the 2-port in a fixed impedances.

2. If the two-port has an open-circuit output, the frequency response for V2/V1 is simply "1./z.A"

Functions are also provided to create 2-port descriptions from (frequency-dependent) transmission line RLGC parameters or from S-parameters.

The file "chmodel.m" provides an example of creating a channel model, in both the frequency-domain and time-domain, using the package.  It starts from a lossy tansmission line description including skin effect and dielectric loss, calculates frequency-dependent RLGC parameters, creates transmission matrices for the transmission line and a simple package model, then combines them and plots the resulting channel response in the time and frequency domains.

LIST OF FILES:
--------------

admittance.m
chmodel.m
freq2impulse.m
impedance.m
rlgc.m
series.m
src_term.m
terminate.m
sparam.m
