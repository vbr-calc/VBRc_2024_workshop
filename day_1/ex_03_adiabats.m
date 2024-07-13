% properties along adiabats
clear; close all
% 1. initialize the VBRc
path_to_top_level_vbr=getenv('vbrdir');
addpath(path_to_top_level_vbr)
% use the VBRc a lot? add the above to
% startup.m for matlab (https://www.mathworks.com/help/matlab/ref/startup.html)
% or ~/.octaverc for octave (https://docs.octave.org/interpreter/Startup-Files.html)
vbr_init

addpath("./extra_functions")

% build our 1d model
T_pots = linspace(1200, 1500,10);
nz = 150;
max_z_km = 300;
T_K = zeros(nz, numel(T_pots));
P_GPa = zeros(nz, numel(T_pots));
rho_z = zeros(nz, numel(T_pots));

for i_T_pot = 1:numel(T_pots)
    [T_K_i, P_GPa_i, rho_z_i, z_km] = get_adiabat(max_z_km, T_pots(i_T_pot), nz);
    T_K(:, i_T_pot) = T_K_i;
    P_GPa(:, i_T_pot) = P_GPa_i;
    rho_z(:, i_T_pot) = rho_z_i;
end

figure()
subplot(1,3,1)
plot(T_K-273, z_km)
xlabel('T [C]')
subplot(1,3,2)
plot(rho_z, z_km)
xlabel('\rho [kg/m^3]')
% set up VBRc
VBR.in.elastic.methods_list={'anharmonic';};
VBR.in.anelastic.methods_list={'eburgers_psp';};

VBR.in.SV.rho = rho_z;
VBR.in.SV.P_GPa = P_GPa;
VBR.in.SV.T_K = T_K;

% needed for anelastic calculation
sz = size(T_K);
VBR.in.SV.sig_MPa = 0.1 * ones(sz); % differential stress [MPa]
VBR.in.SV.phi = 0.0 * ones(sz); % melt fraction
VBR.in.SV.dg_um = 0.01 * 1e6 * ones(sz); % grain size [um]

VBR.in.SV.f = logspace(-2.2,-1.3,4); % frequency [Hz]

% calculate
VBR = VBR_spine(VBR);


% TO DO: plot frequency dependence vs depth
subplot(1,3,3)
for i_T_pot = 1:numel(T_pots)
    hold all
    plot(VBR.out.anelastic.eburgers_psp.Vave/1e3, z_km)
end


% note
% https://chrishavlin.github.io/post/vbrc_moduli/
%% The moduli are specified in a slightly different location.
%% the moduli at elevated temperature and pressure are set in VBR.in.elastic:
%VBR.in.elastic.Gu_TP = G;
%VBR.in.elastic.Ku_TP = K;
%VBR = VBR_spine(VBR);

