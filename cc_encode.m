function c = cc_encode(u, trellis)
    % Entrées
    % u vecteur de K symboles d'entrées
    % trellis : une structure représentant le treillis
    % Sortie
    % c : le mot de code
    
    K = length(u);
    states = trellis.numStates;
    L = log2(states);
    n = log2(trellis.numOutputSymbols);
    c = zeros(1,n*(K+L));
 
    nextStates = trellis.nextStates;
    outputs = trellis.outputs;
    n = log2(trellis.numOutputSymbols);
    s_i = 0;
    for i=1:K
        u_i = u(i);
        output_sym = outputs(s_i + 1, u_i + 1);
        binary_sym = de2bi(output_sym, n);
        c(2*i-1) = binary_sym(2);
        c(2*i) = binary_sym(1);
        s_i = nextStates(s_i + 1, u_i + 1);
    end
    % Fermeture
    % s_i est quelconque
    s_p = s_i;
    for i=1:L
        u_i = 0;
        for u=0:1
            u_i = u;
            s_i = nextStates(s_p + 1, u_i + 1);
            if (s_i < s_p || s_i == 0)
                break;
            end
        end

        output_sym = outputs(s_p + 1, u_i + 1);
        binary_sym = de2bi(output_sym, n);
        c(2*(K+i)-1) = binary_sym(2);
        c(2*(K+i)) = binary_sym(1);
        s_p = s_i;
    end
end