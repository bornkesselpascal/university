% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.1

function [tone] = Aufgabe2_Tonleiter(basis)
tone.a   = basis;                     % [Hz]
tone.b   = tone.a   * nthroot(2, 12); % [Hz]
tone.h   = tone.b   * nthroot(2, 12); % [Hz]
tone.c   = tone.h   * nthroot(2, 12); % [Hz]
tone.cis = tone.c   * nthroot(2, 12); % [Hz]
tone.d   = tone.cis * nthroot(2, 12); % [Hz]
tone.dis = tone.d   * nthroot(2, 12); % [Hz]
tone.e   = tone.dis * nthroot(2, 12); % [Hz]
tone.f   = tone.e   * nthroot(2, 12); % [Hz]
tone.fis = tone.f   * nthroot(2, 12); % [Hz]
tone.g   = tone.fis * nthroot(2, 12); % [Hz]
tone.gis = tone.g   * nthroot(2, 12); % [Hz]
end

