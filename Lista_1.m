function Lista_1
  xr = 0;
  xl = 0;
  xu = 1;
  xrold = NaN;
  torelancia = 1e-5;
  nMaxIteracoes = 1000;

  vetorDeXr = zeros(nMaxIteracoes,1);
  vetorDeFxr = zeros(nMaxIteracoes,1);

  for cont = 1:nMaxIteracoes
    xr = (xl + xu)/2;
    vetorDeXr(cont) = xr;

    fzxl = fz(xl);
    fzxr = fz(xr);
    test = fzxl * fzxr;
    vetorDeFxr(cont) = fzxr;

    if test < 0
      xu = xr;
    elseif test > 0
      xl = xr;
    else
      break;
    end

    if abs(xr-xrold)<=torelancia
      break;
    endif

    xrold = xr;
  endfor

  vetorDeXr = vetorDeXr(1:cont);
  vetorDeFxr = vetorDeFxr(1:cont);
  clc
  printf(" Em %i iterações obtive\n valor da raiz %5f\n da função\n", cont, xr)

  plotConvergencia(vetorDeXr, vetorDeFxr);
  graficoAnimado(vetorDeXr, vetorDeFxr);

endfunction

function y = fz(x)
  y = (x^3)+(2*(x^2))-2;
end

function plotConvergencia(xrValores, fxrValores)
  subplot(2, 1, 1);
  plot(xrValores, 'linewidth', 2);
  grid;
  ylabel("xr",'FontSize', 18);
  xlabel("iteração",'FontSize', 18);
  title('Convergência de xr','FontSize', 18);

  subplot(2, 1, 2);
  plot(fxrValores, 'linewidth', 2);
  grid;
  ylabel("f(xr)",'FontSize', 18);
  xlabel("iteração",'FontSize', 18);
  title('Convergência de f(xr)','FontSize', 18);
  drawnow;
end

function graficoAnimado(xrValores, fxrValores)
  figure(2);
  x = linspace(min(xrValores) - 0.1, max(xrValores) + 0.1, 500);
  y = (x.^3) + (2*(x.^2)) - 2;
  plot(x, y, 'linewidth', 2);
  grid;
  hold on;

  h = plot(xrValores(1), fxrValores(1), 'o', 'markersize', 7, 'markerfacecolor', 'magenta');
  legend('f(x) = x^3 + 2x^2 - 2', 'Ponto da Convergência', 'Location', 'NorthWest', 'FontSize', 18);
  xlabel('xr', 'FontSize', 18);
  ylabel('f(xr)', 'FontSize', 18);

  for i = 2:length(xrValores)
    set(h, 'XData', xrValores(i), 'YData', fxrValores(i));
    title(sprintf("%d iterações", i),'FontSize', 18);
    drawnow;
    pause(0.8);
  end

  hold off;
end



