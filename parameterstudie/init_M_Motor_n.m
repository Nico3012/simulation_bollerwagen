g = 9.81; % [m/s^2]

% Gesamtmasse
m = 455; % [kg]

M_Motor = 4.62; % [Nm] //10% Nm höhere Leistung

% Radradius
rR = 0.2434; % [m]
% Massenträgheitsmoment Rad
Jrad = 0.2; % [kg*m^2]

% Massenträgheitsmoment
Jachse_unten = 0.052; % [kg*m^2] - Kettenblatt, rest wird vernachlässigt
Jachse_mitte = 0.003; % [kg*m^2] - großes Kettenblatt, rest wird vernachlässigt
Jmotor = 0.001; % [kg*m^2]

% Übersetzungsverhältnis Motor - Zwischenwelle
i1 = 74/9;
% Übersetzungsverhältnis Zwischenwelle - Antriebswelle
i2 = 58/10;

%% Vergleichsmassen:
% Formel: m_eq = J * i^2 / r^2
m_raeder = 4 * Jrad / (rR*rR); % [kg]
m_achse_unten = Jachse_unten / (rR*rR); % [kg]
m_achse_mitte = Jachse_mitte * i2*i2 / (rR*rR); % [kg]
m_motor = Jmotor * i1*i1*i2*i2 / (rR*rR); % [kg]

%% Equivalenzmasse
% Rotierende Masse in Gewichtsäquivalent umrechnen: https://chatgpt.com/share/68552f58-d298-800c-abd2-5a7b1e80aca3
m_eq = m+m_raeder+m_achse_unten+m_achse_mitte+m_motor;

% Nutzbare Kapazität Batterie
Cn = 108000; % [As] (30 Ah)
% Nennspannung Batterie
Un = 48; % [V]

%% Regler
Kp = 4000;
Tn = 200;



% Luftdichte
rho=1.2;    % [kg/m^3]
A=1;      % [m^2]

% Luftwiderstandsbeiwert cw
Cw=1.1;     % ohne Einheit
fr=0.02;   %Rollwiderstandsbeiwert
f_reibwert=0.5; % Reibwert bei Vollbremsung

stop_distance=10.6182; % [km]

% Effizienzen
Eta_Motor=0.85; % [1]
Eta_Getriebe=0.9; % [1]
Eta_Inverter=0.9; % [1]
