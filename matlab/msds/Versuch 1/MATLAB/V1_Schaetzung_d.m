Auslenkung_max = Amplitude(1); % [deg]
Auslenkung_min = Amplitude(end); % [deg]

Auslenkung_max_rad = Auslenkung_max * (pi/180); % [rad]
Auslenkung_min_rad = Auslenkung_min * (pi/180); % [rad]

Amplitude_rad = Amplitude .* (pi/180);

omega = diff(Amplitude_rad) ./ diff(Zeit);
omega_integral = sum(omega.^2 .* diff(Zeit));

daempfungsbeiwert = (m * g * l * (cos(Auslenkung_min_rad) - cos(Auslenkung_max_rad))) / omega_integral;