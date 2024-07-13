function [T_K, P_GPa, rho_z, z_km] = get_adiabat(max_z_km, mantle_Tpot_C, nz)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [T_K, P_GPa, rho_z, z_km] = get_adiabat(max_z_km, mantle_Tpot_C, nz)
    %
    % constructs an adiabatic temperature profile.
    %
    % Parameters
    % ----------
    % max_z_km
    %     the maximum depth in km to go to
    % mantle_Tpot_C
    %     the mantle potential termpature in C
    % nz
    %     number of points in depth array
    %
    % Returns
    % -------
    % T_K
    %    temperature array in K
    % P_GPa
    %    pressure array in GPa
    % rho_z
    %    density array in kg/m3
    % z_km
    %    depth array in km
    %
    % uses the following VBRc functions
    %   adiabatic_gradient
    %   san_carlos_density_from_pressure
    %   Density_Thermal_Expansion
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    z_km = linspace(0, max_z_km, nz);
    T_K = zeros(size(z_km));
    rho_z = zeros(size(z_km));
    P_GPa = zeros(size(z_km));

    % set initial node
    T_K(1) = mantle_Tpot_C + 273;
    P_GPa(1) = .1;
    rho_z(1) = san_carlos_density_from_pressure(P_GPa(1));
    rho_z(1) = Density_Thermal_Expansion(rho_z(1), T_K(1), 0.9);

    % integrate downward along adiabat
    for iz = 2:numel(T_K)
        dTdz = adiabatic_gradient(T_K(iz-1), rho_z(iz-1), 0.9); % deg K / km
        dz = (z_km(iz) - z_km(iz-1));
        T_K(iz) = T_K(iz-1) + dTdz * dz;
        P_GPa(iz) = P_GPa(iz-1) + 9.8 * rho_z(iz-1) * dz*1e3/1e9;
        rho_z(iz) = san_carlos_density_from_pressure(P_GPa(iz));
        rho_z(iz) = Density_Thermal_Expansion(rho_z(iz), T_K(iz), 0.9);
    end

end