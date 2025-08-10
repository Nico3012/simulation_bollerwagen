g = 9.81; % [km*m/s^2]

% Gesamtmasse
m = 455; % [kg]


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

% Nutzbare Kapazität Batterie
Cn = 30; % [Ah]
% Nennspannung Batterie
Un = 48; % [V]

%% Regler
Kp = 4000;
Tn = 200;



% Luftdichte
rho=1.2;    % kg/m^3
A=1;      % m^2

% Luftwiderstandsbeiwert cw
Cw=1.1;     % ohne Einheit
fr=0.02;   %Rollwiderstandsbeiwert

% km
stop_distance=10.6182;
