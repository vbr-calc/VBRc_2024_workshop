% 1. initialize the VBRc
addpath(getenv('vbrdir'))
vbr_init

VBR.in.elastic.methods_list={'anharmonic';'anh_poro';};
VBR.in.viscous.methods_list={'HZK2011'};
VBR.in.anelastic.methods_list={'xfit_mxw'};

%  frequencies to calculate at
VBR.in.SV.f = logspace(-14,-2,100); % [Hz]

%  size of the state variable arrays. arrays can be any shape
%  but all arays must be the same shape.
VBR.in.SV.T_K = 1300+273; % temperature [K]
sz = size(VBR.in.SV.T_K);
VBR.in.SV.P_GPa = 2; % pressure [GPa]
VBR.in.SV.rho = 3300; % density [kg m^-3]
VBR.in.SV.sig_MPa = 10; % differential stress [MPa]
VBR.in.SV.phi = 0.0; % melt fraction
VBR.in.SV.dg_um = 0.005 * 1e6; % grain size [um]

VBR = VBR_spine(VBR);

tau_M = VBR.out.anelastic.xfit_mxw.tau_M; % eta_ss / M_inf
omega = 2 * pi * VBR.in.SV.f;
eta_ss = VBR.out.viscous.HZK2011.diff.eta;
M1 = 1./VBR.out.anelastic.xfit_mxw.J1;
M2 = 1./VBR.out.anelastic.xfit_mxw.J2;

M = M1 + M2 * i; % complex modulus

eta_star= -i ./ omega .* M;  % complex viscosity
eta_app = abs(eta_star); % apparent viscosity
eta_maxwell = eta_ss ./ (1 + i * omega * tau_M);
eta_normalized = abs(eta_star) ./ abs(eta_maxwell);

tau_f = 1./ tau_M;
disp(tau_M/(3600*24*365))
figure()
subplot(3,1,1)
loglog(VBR.in.SV.f, eta_app)
hold on
loglog([tau_f, tau_f], [min(eta_app), max(eta_app)],'--k')
ylabel('||\eta*||')

subplot(3,1,2)
Qinv = VBR.out.anelastic.xfit_mxw.Qinv;
loglog(VBR.in.SV.f, Qinv)
hold on
loglog([tau_f, tau_f], [min(Qinv), max(Qinv)],'--k')
ylabel('Q^{-1}')

subplot(3,1,3)
semilogx(VBR.in.SV.f, eta_normalized)
hold on
semilogx([tau_f, tau_f], [min(eta_normalized), max(eta_normalized)],'--k')
semilogx([VBR.in.SV.f(1), VBR.in.SV.f(end)], [1,1],'--k')
ylim([0, 10])
ylabel('normalized ||{\eta}*||')
xlabel('f [Hz]')