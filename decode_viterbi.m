function u = decode_viterbi(y, trellis)
    n = trellis.numStates;
    L = length(y)/log2(n) + 1;
    memory = [];

    y = reshape(y, log2(n), [])';

    ei = [1];
    for i=1:L-1
        for j=1:length(ei)
            next_state_0 = trellis.nextStates(ei(j), 1) + 1; % envoi 0
            next_state_1 = trellis.nextStates(ei(j), 2) + 1; % envoi 1
            
            output_0 = trellis.outputs(ei(j), 1);
            output_1 = trellis.outputs(ei(j), 2);

            val_0 = de2bi(output_0, 2, "left-msb");
            val_1 = de2bi(output_1, 2, "left-msb");

            metrique_0 = sum(val_0.* y(i, :)); % + metrique precedente;
            metrique_1 = sum(val_1.* y(i, :)); % + metrique precedente;

            if next_state_0 == next_state_1
                memory = [memory; [ei(j) next_state_0 min(metrique_0, metrique_1)]];
            else
                ei = [next_state_0 next_state_1];
                memory = [memory; [ei(j) next_state_0 metrique_0]];
                memory = [memory; [ei(j) next_state_1 metrique_1]];
            end
        end
    end

    u = memory
end