function [s_quantifie, q]= quantification(s, vmin, vmax, Nbit)
D = vmax - vmin;                    % Dynamique du CAN
b = Nbit;                           % Nombre de bit de decodage
N =2.^b;                            % Nombre de niveau de quantification du CAN
q = D/(N-1);                        % Quantum
Echelle_possible = (vmin:q:vmax);   % Ensemble de valeurs possibles

N_s = length(s);                    % Nombre d'echantillons
s_quantifie = zeros(1,N_s);         % Signal quantifie

for k=1:N_s;
    erreur = abs(s(k)-Echelle_possible);
    [val_min, indice_min] = min(erreur);
    s_quantifie(k) = Echelle_Possible(indice_min);  
end

