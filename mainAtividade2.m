function mainAtividade2()
  clc;
  x0 = [1.5;3.5];
  iter = 1000;
  tol = 0.00001;
  [x1, todosY, todosXR, xx] = newtonRaphson(x0, iter, tol);
  plotaGraficosConvergencia(iter, todosXR, todosY);

  maiorValor = max(max(todosXR));
  menorValor = min(min(todosXR));
  intervalo = menorValor - 10:0.1:maiorValor + 10;

  plotgrafico3D(intervalo, todosXR, xx, todosY);
  fprintf("Levou %i iteracoes para achar a raiz \n",xx);
end

function [x1, todosY, todosXR, xx] = newtonRaphson(x0, maxIter, tol)
  todosY = zeros(maxIter, 2);
  todosXR = zeros(maxIter, 2);

  for xx = 1:maxIter
    x1 = x0 - (inv(jacobiana(x0)) * sistema(x0));
    todosXR(xx, :) = x1; % todos valores de x
    todosY(xx,:) = sistema(x1); % todos os valores f(x) na função

    if max(abs(x1 - x0)) <= tol
      x0=x1;
      break;
    end
    x0 = x1;
  end

  todosY = todosY(1:xx, :);
  todosXR = todosXR(1:xx, :);

end

function z = sistema(x0)
    x = x0(1);
    y = x0(2);
    z = [x*cos(x) + y; 2*x^2 + 1/5*y^2];
end

function jacob = jacobiana(x0)
    x = x0(1);
    y = x0(2);
    jacob = [cos(x) - x*sin(x), 1;
           4*x, 2/5*y];
end

function plotgrafico3D(intervalo, todosXR, xx, todosY)
  todosInterv = numel(intervalo);
  valoresFxy = zeros(todosInterv, todosInterv, 2);
  for pp = 1:todosInterv
    for qq = 1:todosInterv
      valoresFxy(pp, qq, 1:2) = sistema([intervalo(pp), intervalo(qq)]);
    end
  end
  for tt = 1:xx
    figure(3);
    subplot(211);
    surf(intervalo, intervalo, valoresFxy(:,:,1));
    hold on;
    pontoX = todosXR(tt,1);
    pontoY = todosXR(tt,2);
    pontoZ = sistema([pontoX, pontoY]);
    plot3(pontoX, pontoY, pontoZ(1), 'markersize', 10, 'o', 'color', 'r', 'markerfacecolor', 'm');
    set(gca, 'fontsize',16);
    title('Equação 1: z = x*cos(x) + y');
    legend('grafico da funcao', 'ponto de convergencia da raiz','Location', 'northwest');
    hold off;

    subplot(212);
    surf(intervalo, intervalo, valoresFxy(:,:,2));
    hold on;
    pontoX = todosXR(tt,1);
    pontoY = todosXR(tt,2);
    pontoZ = sistema([pontoX, pontoY]);
    plot3(pontoX, pontoY, pontoZ(2), 'markersize', 10, 'o', 'color', 'b', 'markerfacecolor', 'b');
    set(gca, 'fontsize', 16);
    title('Equação 2: z = 2*x^2 + 1/5*y^2');
    legend('grafico da funcao', 'ponto de convergencia da raiz','Location', 'northwest');
    view([-90, 30]);
    hold off;
  end
end

function plotaGraficosConvergencia(iter, todosXR, todosY)
  % variáveis
  figure(1);
  iter = size(todosXR, 1);
  indiceIter = 1:iter;

  % Plote x1 e x2 em subplots separados
  subplot(2, 1, 1);
  plot(indiceIter, todosXR(:, 1), 'linewidth', 2);
  set(gca, 'fontsize', 16);
  grid on;
  xlabel('Nº de iterações', 'fontsize', 14);
  ylabel('Valor estimado de x1', 'fontsize', 14);
  title('Gráfico de convergência de x1', 'fontsize', 15);

  subplot(2, 1, 2);
  plot(indiceIter, todosXR(:, 2), 'linewidth', 2);
  set(gca, 'fontsize', 16);
  grid on;
  xlabel('Nº de iterações', 'fontsize', 14);
  ylabel('Valor estimado de x2', 'fontsize', 14);
  title('Gráfico de convergência de x2', 'fontsize', 15);

  figure(2);
  plot(indiceIter, todosY(:, 1), 'linewidth', 2, 'DisplayName', 'Equação 1: z = x*cos(x) + y');
  hold on;
  plot(indiceIter, todosY(:, 2), 'linewidth', 2, 'DisplayName', 'Equação 2: z = 2*x^2 + 1/5*y^2');
  set(gca, 'fontsize', 16);
  grid on;
  xlabel('Nº de iterações', 'fontsize', 14);
  ylabel('Valor estimado do sistema', 'fontsize', 14);
  title('Gráfico de convergência do sistema', 'fontsize', 15);
  legend('Location', 'northwest');
  hold off;
end









