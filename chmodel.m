% Lossy transmission line modeling

% electrical loss parameters
w_0 = 2*pi*10e9; % All AC parameters are specified at this frequency
theta_0 = 0.022; % loss tangent = theta_0/(2*pi)
k_r = 87; % skin-effect scaling factor [ohms/m @ w_0]
RDC = 0.0001;% % dc resistance [ohm/m]

% frequency vector
k = 14; % length of frequency vector
fmax = 100e9; % fmax=100e9 -> Ts=5ps
f = linspace(0,fmax,2^k+1);
w = 2*pi*f;

% Constants
c = 2.998e8; % speed of light [m/s]
eps_0 = 8.85*1e-12; % [F/m] 

% transmission line parameters
eps_r = 4.9; % effective relative dielectric constant
v0 = sqrt(1/eps_r)*c; % propagation velocity of the transmission line [m/s]
Z0 = 50; % characteristic impedance [ohm]

% transmission line parameters
L0 = Z0/v0; %[H/m]
C0 = 1/(Z0*v0); %[F/m]
G0 = 1e-12; %[S/m]
RAC = (k_r*(1+j)*sqrt(w/w_0)); %[ohm/m]

% Generate frequency-dependent RLGC for the lossy transmission line
R=sqrt(RDC^2 + RAC.^2);
L=L0*ones(1,length(f));
G=G0*ones(1,length(f));
C=C0*(j*w./w_0).^(-2*theta_0/pi);
if (f(1)==0)
   C(1) = C(2);
end

% transmission line length [m]
d = 0.15;

% create transmission line model
tline = rlgc(R,L,G,C,d,f);

% bondwire package
len = 0.5e-3;
pad1 = admittance(j*2*pi*f*0.45e-12);
bwire = impedance(j*2*pi*f*len*9.6e-7);
pad2 = admittance(j*2*pi*f*0.45e-12);
% pad1 = admittance(j*2*pi*f*0.45e-25);
% bwire = impedance(j*2*pi*f*len*9.6e-20);
% pad2 = admittance(j*2*pi*f*0.45e-25);
pkg = series(pad1,series(bwire,pad2));

% source impedance
source = impedance(60*ones(1,length(f)));

% termination
termination = admittance(ones(1,length(f))./40);

% channel is the series connection of the source, package, transmission
% line, package, and termination
channel = series(source,series(series(pkg,series(tline,pkg)),termination));

% frequency domain response
Hchannel = 1./channel.A;

% time domain response
[h,t,hstep] = freq2impulse(Hchannel,f);
Tpulse=8; hpulse = [- hstep(1:end-Tpulse) + hstep(Tpulse+1:end) zeros(1,Tpulse)];
preemph = 0.2; hfir = ((1-preemph)*hpulse + (-preemph*[zeros(1,Tpulse) hpulse(1:end-Tpulse)]));

% plot results in time and frequency domain
figure(1)
subplot(2,1,1);
plot(1e-9*f,20*log10(abs(Hchannel)),'linewidth',2);
set(gca,'xlim',[0 20]);
set(gca,'fontsize',18,'linewidth',2);
grid on
xlabel('Frequency [GHz]');
ylabel('Mag. Response [dB]');
subplot(2,1,2);
plot(t*1e9,hstep,'r-','linewidth',2);
set(gca,'xlim',[0 20],'ylim',[-.02 .62]);
set(gca,'fontsize',18,'linewidth',2);
grid on
xlabel('Time [ns]');
ylabel('Step Response')

% plot impulse and pulse responses
figure(4)
% subplot(2,1,1);
plot(t*1e9,hpulse,'r-','linewidth',3);
set(gca,'xlim',[0 5],'ylim',[-.01 .05]);
set(gca,'fontsize',22,'linewidth',3);
xlabel('Time [ns]');
ylabel('Impulse Response')
grid on
% subplot(2,1,2);
% plot(t*1e9,hfir,'r-','linewidth',3);
% set(gca,'xlim',[0 5],'ylim',[-.02 .62]);
% set(gca,'fontsize',22,'linewidth',3);
% grid on
% xlabel('Time [ns]');
% ylabel('Pulse Response')

% % plot R,L,G,C parameters
% figure(2)
% subplot(4,1,1)
% plot(f./1e9,real(R),'b','linewidth',3)
% ylabel('Res [\Omega/m]')
% set(gca,'fontsize',18);
% grid on
% subplot(4,1,2);
% plot(f./1e9,1e9*imag(R+j*w.*L)./w,'b','linewidth',3)
% set(gca,'fontsize',18);
% ylabel('Ind [nH/m]')
% grid on
% subplot(4,1,3)
% plot(f./1e9,1e12*real(C),'b','linewidth',3);
% ylabel('Cap [pF/m]')
% set(gca,'fontsize',18);
% grid on
% subplot(4,1,4)
% plot(f./1e9,-imag(C).*w,'b','linewidth',3);
% %ylabel('-Im(C)\cdot\omega [\Omega/m]')
% ylabel('Cond [1/\Omegam]')
% set(gca,'fontsize',18);
% grid on
% xlabel('Frequency [GHz]');
% 
% plot mag resp on log scale
figure(3)
semilogx(1e-9*f,20*log10(abs(Hchannel)),'linewidth',3);
set(gca,'xlim',[1 20]);
set(gca,'fontsize',22,'linewidth',3);
grid on
xlabel('Frequency [GHz]');
ylabel('Mag Response [dB]');

