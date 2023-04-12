% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.2

mode = 'speichereffizient';

h = animatedline('Color','b','LineWidth',1);
axis([0 1000 -450 450])
xlabel('n');
ylabel('s[n]');

for n=0:1000
    tic

    switch mode
        case 'speichereffizient'
            s_n = signal_speichereffizient(n);
        case 'cpueffizient'
            s_n = signal_cpueffizient(n);
    end

    addpoints(h, n, s_n);
    drawnow

    toc
end