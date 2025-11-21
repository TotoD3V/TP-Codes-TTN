function c = bpsk(u, RSB)
    c = 1 - 2*u;
    N = length(c);

    Ps = 1/N * sum(abs(c.^2));
    
    b = randn(1, N);
    Pb = 1/N * sum(abs(b.^2));

    rapport = Ps/Pb;

    sigma = sqrt(rapport*10^(-RSB/10));

    c = c + sigma * b;
end