function K=bass_gura(A,B,p)
    % A: Matriz del sistema
    % B: Matriz de entrada
    % p: Autovalores deseados en forma de arreglo P=[l1 l2 l3 ...ln]
    % li: cada autovalor deseado
    n=length(B); % Averigua el orden del sistema
    a1=poly(p); %Polinomio deseado
    a=poly(A); % Polinomio del sistema en lazo abierto
    C=ctrb(A,B); % Matriz de controlabilidad
    if rank(C)< n
        return; %Sale si el sistema no es controlable
    end
    CI=inv(C); %Inversa de la matriz de controlabilidad
    q1=CI(n,:); %Última fila de la inversa de la matriz de controlabilidad
    for i=1:n
        Q(i,:)=q1*A^(i-1); %Matriz de transformación al sistema controlable
    end
    K=(a1(n+1:-1:2)-a(n+1:-1:2))*Q; %Ganancia de retroalimentación
end