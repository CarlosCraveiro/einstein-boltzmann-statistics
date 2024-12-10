#import "./poster.typ": *

#show: poster.with(
  size: "36x24",
  title: "Determinação da Constante de Boltzmann analisando Ruído Térmico",
  authors: "Carlos Henrique C.A.Veras - 12547187",
  departments: "Engenharia de Computação",
  univ_logo: "./images/icmc_usp_logo.png",
  univ_logo_scale: 85,
  footer_text: "SME0123 - Estatística",
  footer_url: "Dezembro - 2024",
  footer_url_email_font_size: 28,
  footer_email_ids: "carlos.craveiro@usp.br",
//footer_color: "23477C", // EESC
  footer_color: "72849D", // ICMC
  footer_text_color: "FFFFFF",
  body_text_size: 18,

  keywords: ("Regressão Linear", "Ruído Térmico", "Constante de Boltzmann", "Densidade Espectral de Potência", "Aproximação de Padé"),
)

= Introdução

Em 1902, Albert Einstein sugeriu em um periódico da época que seria teoricamente possível medir a constante de Stefan-Boltzmann, fundamental nos fenômenos termodinâmicos, observando os efeitos da energia térmica em componentes eletrônicos. Em 2017, 115 anos depois, Todor M. Mishonov, do Laboratório de Medidas de Constantes Fundamentais, e seus colegas da Universidade de Sofia, na Bulgária, decidiram colocar as ideias de Einstein em prática em um experimento para estudantes durante a 5ª Olimpíada de Física Experimental dos Bálcãs. Curiosamente, essa proposta nunca havia sido implementada de forma direta até então.

A abordagem utilizada, embora engenhosa, foi bastante simples. Ela explorou o fato de que o movimento aleatório dos elétrons (movimento browniano), uma manifestação de energia térmica, em uma resistência elétrica gera o que é conhecido como Ruído de Johnson-Nyquist, ou simplesmente Ruído Térmico: um ruído gaussiano de média zero. Assim, ao mensurar esse ruído, seria possível, em teoria, relacionar a energia elétrica com a energia térmica e calcular a constante de Boltzmann. Mas, como extrair informações úteis de uma variável aleatória com média nula? Estatisticamente, é simples: basta observar sua variância! Afinal, apesar da média ser zero, a variância do ruído está diretamente relacionada à sua energia—aquilo que, ao refletir um pouco, faz perfeito sentido.

Para implementar essa ideia, o experimento envolve acoplar um capacitor ($C$ [F]) em paralelo com uma resistência ($R$ [Ω]). Quando o sistema está em equilíbrio térmico, a potência quadrática média ($<U^2>$ [$V^2$]) nos terminais do circuito pode ser expressa como:

#v(0.5cm)

#align(center)[
#text(size: 25pt)[
$<U^2> = (k_b T)/(C)$ <eq-mestra>,
]]

#v(0.5cm)

onde $T$ é a temperatura em Kelvin e $k_b$ é a constante de Boltzmann e Joule por Kelvin ($J.K^(-1)$). Essa relação estabelece que, para uma temperatura constante, a tensão quadrática média é inversamente proporcional à capacitância do sistema. Isso significa que, ao variar a capacitância e medir a tensão quadrática média em uma série de experimentos, é possível determinar o valor de $k_b$. Um ponto interessante desse modelo é que a resistência $R$ não influencia o resultado final—ela "se cancela" matematicamente durante as deduções, deixando a resposta dependente apenas da capacitância e da temperatura. Uma dedução mais detalhada dessa expressão pode ser encontrada na seção de Probabilidade do Livro de Telecomunicações do Lathi (consultar as Referências) e poderá também ser encontrada na #link("https://github.com/CarlosCraveiro/einstein-boltzmann/wiki/Noise-Source-Derivation")[Wiki] do projeto da placa.


= Reprodução do Experimento

Em 2024, o autor buscou reproduzir os resultados de Mishonov ao replicar a placa de circuito descrita no artigo publicado em 2019 pelo físico búlgaro. O projeto, que pode ser observado em @projeto, foi desenvolvido sob a licença CERN-OHL-S-2.0 de Hardware Livre e apresentado no Fórum de Tecnologias Livres (FOSS-FÓRUMS 2024) em agosto do mesmo ano.

#figure(
  image("./images/main_board_3d_front_raytraced.png", 
        width: 75%),
  caption: [Modelo 3D da placa desenvolvida para o experimento]
) <projeto>

No mês seguinte, a montagem da placa e a realização do experimento ocorreram no Laboratório Aberto da SEL (SEL - Departamento de Engenharia Elétrica e de Computação da Escola de Engenharia de São Carlos), um espaço voltado ao desenvolvimento de projetos estudantis, coordenado pelo Prof. Dr. José Marcos Alves.

= Metodologia Experimental

O experimento foi dividido em três etapas. Primeiro, as capacitâncias foram medidas usando um medidor LCR de 100 kHz (LCR-600 da _Global Specialities_®), conforme registrado na @capacitances. Na segunda etapa, ilustrada em @etapa2, foi caracterizado o ganho do estágio responsável pela operação quadrática média do circuito. Para isso, o estágio ruidoso foi desligado, e o estágio de interesse foi submetido a tensões conhecidas enquanto sua saída era registrada (@squared).

Por fim, realizou-se o experimento para determinar a constante de Stefan-Boltzmann ($k_b$). Cada capacitor medido na primeira etapa foi instalado na placa, aguardando-se 1 minuto e meio para que o circuito atingisse o regime estacionário. Em seguida, registrou-se o valor da saída do circuito, além disso a temperatura ambiente foi monitorada com um sensor DHT-11 em anotada para cada medição, a fim de mitigar possíveis variações térmicas na sala devido à longa duração do procedimento (@raw-measures).

#figure(
  image("./images/experimento.jpg", 
        width: 60%),
  caption: [Foto da configuração experimental da segunda etapa (fontes de tensão omitidas)]
) <etapa2>

= Resultados Obtidos
// Configuração das tabelas
#show table.cell.where(y: 0): strong

#figure(
  caption: [Capacitâncias em $n F$ medidas durante a primeira etapa do experimento],
  table(
    columns: 8,
    align: center,
    table.header[Classes $C_n$ [$n F$]][Média][Mediana][Moda][Desvio Padrão][Mínimo][Máximo][F. Abs],
    [\(4.573 - 18.652\]], [11.508], [11.302], [4.755], [4.981], [4.755], [17.711], [12],
    [\(18.652 - 32.732\]], [29.410], [29.410], [28.780], [0.891], [28.780], [30.040], [2],
    [\(32.732 - 46.811\]], [36.570], [36.950], [35.710], [0.746], [35.710], [37.050], [3],
    [\(46.811 - 60.891\]], [51.690], [50.805], [48.290], [4.204], [48.290], [59.620], [6],
    [\(60.891 - 74.97\]], [66.288], [63.770], [62.640], [5.814], [62.640], [74.970], [4],
    [*Geral*], [31.661], [29.410], [4.573], [22.242], [4.573], [74.970], [28],
  )
) <capacitances>


#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
   *Observação*: Todos os gráficos e algumas das tabelas apresentadas foram produzidos por um script em Python que está disponível #link("https://github.com/CarlosCraveiro/einstein-boltzmann-statistics/tree/main")[*nesse repositório*]
  ]
)

Através da análise da @capacitances observa-se que o rol de capacitores possui uma clara assimetria à direita.

#figure(
  caption: [Valores medidos de $U_1$ e $U_2$ durante a segunda etapa],
  table(
    columns: 6,
    align: center,
    table.header[Nº][$U_1$ [$V$]][$U_2$ [$V$]][Nº][$U_1$ [$V$]][$U_2$ [$V$]],
   [1],[0.645], [0.0460], [10],[-0.645], [0.0461],
   [2],[0.753], [0.0622], [11],[-0.751], [0.0625],
   [3],[0.860], [0.0809], [12],[-0.859], [0.0814],
   [4],[0.965], [0.1022], [13],[-0.964], [0.1026],
   [5],[1.071], [0.1259], [14],[-1.071], [0.1261],
   [6],[1.190], [0.1522], [15],[-1.178], [0.1526],
   [7],[1.287], [0.1809], [16],[-1.285], [0.1816],
   [8],[1.392], [0.2118], [17],[-1.391], [0.2126],
   [9],[1.500], [0.2457], [18],[-1.497], [0.2497],
 )
)<squared>

A fim de calcular o ganho do estágio quadrático médio, realizou-se uma linearização dos dados apresentados na @squared, plotando $U_1^2$ por $U_2$ e observou-se a dispersão produzida, indicada ao lado esquerdo do Gráfico em @squared-analysis.


#figure(
  image("./images/squaring_combo.png", 
        width: 100%),
  caption: [Gráficos de Dispersão (à esquerda) e de Regressão linear (à direita) para segunda parte]
) <squared-analysis>

Através da análise da dispersão, conclui-se que a linearização foi adequada e prossegui-se para a análise por Regressão Linear a fim de determinar o coeficiente de ganho do estágio quadrático médio. onde o ganho ($U_0$) do estágio é dado pela relação:

#v(0.25cm)

#align(center)[
#text(size: 25pt)[
$<U_2^2> = U_0^(-1)U_1^2$ <U0>,
]]

#v(0.25cm)

Logo, o coeficiente angular obtido através da regressão linear corresponte ao invérso de $U_0$.

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    - *Coeficiente Angular (a):* $1,098 . 10^(-1) ± 0,005 . 10^(-1)$
    - *Intercepto (b):* $3,797 . 10^(-5) ± 73 . 10^(-5)$
    - *$U_0$:* $9,11 ± 0,04$ [$V^(-1)$]
    - *R²:* $0,9996$
    - *Valor p -> H0: (a) = 0:* $8,35 . 10^(-29)$
  ]
)

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
   *Observação*: Foi utilizada a função *linregress* da biblioteca SciPy para o cálculo da regressão linear e todos os parâmetros listados (com excessão de $U_0$) foram fornecidos diretamente pela função. Mais detalhes podem ser encontrados em #link("https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.linregress.html")[*sua documentação*].
  ]
)

#figure(
  caption: [Valores das capacitâncias utilizadas, e os valores medidos de tensão e temperaturas],
  table(
    columns: 8,
    align: center,
    table.header[Nº][$C_n$ [$n F$]][$U_2$ [$m V$]][$T$ [$K$]][Nº][$C_n$ [$n F$]][$U_2$ [$m V$]][$T$ [$K$]],
    [1], [51.87], [84.4], [301.05],   [15],[37.05], [90.4], [301.35],  
    [2], [17.711], [105.1], [301.05], [16],[63.92], [82.8], [301.35],  
    [3], [28.78], [97.1], [301.15],   [17],[4.976], [169.8], [301.25], 
    [4], [63.62], [82.4], [301.15],   [18],[52.08], [84.8], [301.25], 
    [5], [5.902], [157.8], [301.25],  [19],[16.257], [108.5], [301.35],
    [6], [48.29], [85.5], [301.25],   [20],[9.819], [130.3], [301.35], 
    [7], [16.708], [106.9], [301.25], [21], [36.95], [90.4], [301.35], 
    [8], [12.574], [119.6], [301.25], [22],[74.97], [81.1], [301.35],  
    [9], [35.71], [91.8], [301.25],  [23] ,[7.292], [146.0], [301.25],
    [10], [62.64], [82.6], [301.35],  [24] ,[49.74], [85.1], [301.25], 
    [11], [4.573], [174.8], [301.35], [25] ,[16.299], [108.2], [301.25],
    [12], [48.54], [85.6], [301.35],  [26] ,[30.04], [94.4], [301.25],    
    [13], [15.780], [109.9], [301.25],[27] ,[59.62], [83.0], [301.25],  
    [14], [10.029], [129.1], [301.35],[28] ,[4.755], [173.8], [301.25], 
  )
) <raw-measures>

Para a última parte do experimento, onde é determinado de fato a constante de Boltzmann, os dados constam na @raw-measures. Contudo, a fim de se obter uma relação da forma $y = a.x + b$, faz-se necessário re-escrever as medições em termos de duas variáveis $x_n$ e $y_n$:

#align(center)[
#text(size: 25pt)[
$x_n = (C_n . 10^(-3))^(-1)$   [$u F^(-1)$],
]]

#align(center)[
#text(size: 25pt)[
$y_n = U_2 . 10^(12) . U_(star) . T^(-1)$   [$V^2.K^(-1)$],
]]
onde $U_(star)$ corresponde à:

#align(center)[
#text(size: 25pt)[
$U_(star) = U_0 . Y^(-2)$,
]]

E $Y = 1,01 . 10^(6)$ e corresponde ao ganho do estágio de amplificação assumindo-o independente da frequência. Os valores de $x_n$ e $y_n$ são exibidos em @xyns-no-correction.

#figure(
  caption: [Valores das capacitâncias utilizadas, e os valores calculados de $x_n$ e $y_n$],
  table(
    columns: 6,
    align: center,
    table.header[Nº][$x_n$ [$u F^(-1)$]][$y_n$ [$V^2 K^(-1)$]][Nº][$x_n$ [$u F^(-1)$]][$y_n$ [$V^2 K^(-1)$]],
    [1], [19.279], [2.504],   [15], [26.991], [2.679], 
    [2], [56.462], [3.118],   [16], [15.645], [2.454], 
    [3], [34.746], [2.88],    [17], [200.965], [5.034],
    [4], [15.718], [2.444],   [18], [19.201], [2.514], 
    [5], [169.434], [4.679],  [19], [61.512], [3.216], 
    [6], [20.708], [2.535],   [20], [101.843], [3.862],
    [7], [59.852], [3.169],   [21], [27.064], [2.679], 
    [8], [79.529], [3.546],   [22], [13.339], [2.404], 
    [9], [28.003], [2.722],   [23], [137.137], [4.329],
    [10], [15.964], [2.448],  [24], [20.105], [2.523], 
    [11], [218.675], [5.181], [25], [61.353], [3.208], 
    [12], [20.602], [2.537],  [26], [33.289], [2.799], 
    [13], [63.371], [3.258],  [27], [16.773], [2.461], 
    [14], [99.711], [3.826],  [28], [210.305], [5.153], 
  )
) <xyns-no-correction>

Plotando os dados obtidos em um gráfico de dispersão (@fluctoscopia-dispersao) conclui-se o que assim como esperado, uma regressão linear potencialmente é um bom modelo estatístico a ser utilizado.

#figure(
  image("./images/fluct_n_corr_dispersao.png", 
        width: 80%),
  caption: [Gráfico de dispersão entre $x_n$ e $y_n$ sem correção pela frequência]
) <fluctoscopia-dispersao>

A regressão pode ser observada no Gráfico em @fluctoscopia-regressao e os resultados logo abaixo.

#figure(
  image("./images/fluct_n_corr_regressao.png", 
        width: 80%),
  caption: [Gráfico da regressão linear entre $x_n$ e $y_n$ sem correção pela frequência]
) <fluctoscopia-regressao>

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    - *Coeficiente Angular (a):* $1,39 . 10^(-2) ± 0,02 . 10^(-2)$
    - *Intercepto (b):* $2,30 ± 0,02$
    - *$k_b$ (medido):* $1,39 . 10^(-23) ± 0,02 . 10^(-23) J.K^(-1)$
    - *R²:* $0,9918$
    - *Valor p -> H0: (a) = 0:* $1,246 . 10^(-28)$
    - *$k_b$ (real):* $1,38 . 10^(-23)$
    - *Erro Relativo (%):* $1,0%$
  ]
)

= Análise dos Resultados

Analisando os resultados da regressão obtidos, primeiro pode-se atestar que pelo valor desprezível do valor p, pode-se assegurar que o coeficiente angular não é nulo. Em seguida, pela proximidade do valor de $R^2$ de 1 tem se um forte indicativo de que a regressão linear foi um bom modelo escolhido.

A determinação da constante de Stefan-Boltzmann ($k_b$) se dá através da relação:

#align(center)[
#text(size: 25pt)[
$k_b = a . 10 ^(-21)$ [$J . K^(-1)$],
]]

Fazendo um teste de Hipótese para o coeficiente angular $k_b$ igual à $k_b$ (*real*), usar-se-à estatísitica $T_0$, segundo o livro _Estatísitica Aplicada e Probabilidade para Engenheiros_ (para mais detalhes consultar as Referências):

#align(center)[
#text(size: 25pt)[
$T_0 = (hat(a) - (k_b . 10 ^(21)))/(e p(hat(a)))$ [$J . K^(-1)$],
]]

Dessa forma, aplicando um teste T bilateral ao nível de significância de $0.05$ e (N - 2), ou seja 26 graus de liberdade, tem-se:

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    *Hipóteses:*
    - *H0*: k_b_medido = k_b
    - *H1*: k_b_medido ≠ k_b
    *Resultados:*
    - *Valor crítico t* (alpha = 0.05): 2.055
    - *Estatísica T0*: 0.550
    - *Não rejeitamos H0!*
    *Intervalo de confiança para* $k_b$ *medido*:
    - $1,34 . 10^(-23)$ < ($k_b = 1,39 . 10^(-23)$) < $1,45 . 10^(-23)$
  ]
)

O que indica que pela estatística nossa Hipótese ainda se sustenta! Contudo, ao observar com atenção o gráfico em @fluctoscopia-regressao nota-se que os pontos não estão tão homogeneamente distribuidos nos arredores da reta de _fitting_ o que é ainda mais evidenciado pelo Gráfico dos resíduos @fluctoscopia-residuos.

#figure(
  image("./images/fluct_n_corr_residuos.png", 
        width: 80%),
  caption: [Gráfico normalizado dos resíduos da regressão entre $x_n$ e $y_n$ sem correção pela frequência]
) <fluctoscopia-residuos>

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
   *Observação*: Para o cálculo do desvio padrão (σ) foi utilizado o estimador da variância:
   #v(0.25cm) 
   - #text(size: 25pt)[$hat(σ^2) = (S Q)_E/(n-2)$,]
   #v(0.1cm)
    onde $S Q_E$ é a soma do quadrado dos erros.
  ]
)

O comportamento do gráfico de dispersão dos resíduos, segundo a literatura (mesmo livro já citado de Estatística) indica um possível dependência não linear entre $x_n$ e $y_n$.

= Ajuste de não linearidade

A suspeita de dependência não linear não é inesperada, pois foi assumido, por simplicidade, que o ganho do estágio de amplificação do circuito era independente da frequência — o que não é totalmente correto. No Apêndice A de seu artigo de 2019, Mishonov apresenta uma derivação para o fator de correção $Z$, baseada em aproximações de Padé para o ganho em frequência de amplificadores operacionais em malha aberta. Este fator, ao ser multiplicado por $x_n$, corrige a não linearidade.

Reproduzindo o cálculo de $Z$ por integração numérica em Python, obtém-se o gráfico de $ε(C) = 1 - Z(C)$, mostrado em @epsilon.


#figure(
  image("./images/erro_n_linear.png", 
        width: 90%),
  caption: [Gráfico de ε(C) em (%)]
) <epsilon>


Após aplicar o coeficiente o gráfico de dispersão é apresentado em @disp-pade e a regressão linear em @reg-pade.

#figure(
  image("./images/fluct_corr_dispersao.png", 
        width: 80%),
  caption: [Gráfico de dispersão entre $x_n$ e $y_n$ com correção pela frequência]
) <disp-pade>

#figure(
  image("./images/fluct_corr_regressao.png", 
        width: 80%),
  caption: [Gráfico da regressão linear entre $x_n$ e $y_n$ com correção pela frequência]
) <reg-pade>

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    - *Coeficiente Angular (a):* $1,918 . 10^(-2) ± 0,012 . 10^(-2)$
    - *Intercepto (b):* $2,181 ± 0,008$
    - *$k_b$ (medido):* $1,918 . 10^(-23) ± 0,012 . 10^(-23) J.K^(-1)$
    - *R²:* $0,9990$
    - *Valor p -> H0: (a) = 0:* $1,707 . 10^(-40)$
    - *$k_b$ (real):* $1,38 . 10^(-23)$
    - *Erro Relativo (%):* $38,9%$
  ]
)

Analisando os resultados obtidos, conclui-se novamente que *(a)* não é nulo devido ao valor p irrisório e que o modelo apresenta fortes indícios de adequação para a análise, dado o valor de $R^2$ muito próximo da unidade. Além disso, ao observar o novo gráfico normalizado dos resíduos @residuo-pade, verifica-se que a correção pelo fator $Z$ teve o impacto desejado, pois os resíduos estão agora muito mais próximos do comportamento esperado para um modelo satisfatório.


#figure(
  image("./images/fluct_corr_residuos.png", 
        width: 80%),
  caption: [Gráfico normalizado dos resíduos da regressão entre $x_n$ e $y_n$ com correção pela frequência]
) <residuo-pade>

#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    *Hipóteses:*
    - *H0*: k_b_medido = k_b
    - *H1*: k_b_medido ≠ k_b
    *Resultados:*
    - *Valor crítico t* (alpha = 0.05): 2,055
    - *Estatísica T0*: 44,96
    - *Rejeitamos H0!*
    *Intervalo de confiança para* $k_b$ *medido*:
    - $1,893 . 10^(-23)$ < ($k_b = 1,918 . 10^(-23)$) < $1,942 . 10^(-23)$
  ]
)

Entretanto, ao observar o teste de hipótese para $\hat{k_b} = k_b$, conclui-se que, apesar da correção ter contribuído para um modelo melhor, é necessário rejeitar a hipótese de que o valor esperado corresponde ao valor real de $k_b$. Esse resultado, contudo, pode estar relacionado a uma disparidade entre o gráfico obtido pelo autor e o apresentado no artigo de 2019 de Mishonov.

= Conclusão

Neste trabalho, foi reproduzido o experimento proposto por Mishonov em 2017, incorporando uma análise estatística mais robusta para compreender melhor a relação entre os dados experimentais obtidos e o modelo teórico. Inicialmente, a reprodução dos resultados foi bem-sucedida ao assumir o ganho do circuito como constante, com suporte no elevado valor de $R^2$ e no teste de hipótese realizado. No entanto, ao aplicar a correção pela frequência, o teste de hipótese indicou a necessidade de rejeitar a correspondência direta entre o valor estimado de $k_b$ e seu valor real. Apesar disso, melhorias significativas foram observadas no gráfico de resíduos e no valor de $R^2$, sugerindo que a correção teve impacto positivo na qualidade do modelo. A discrepância nos resultados pode estar associada a fatores externos ou a diferenças metodológicas. Este estudo destaca a relevância de revisitar modelos experimentais, considerando ajustes necessários, para aprimorar sua precisão e confiabilidade.

= Trabalhos Futuros e Agradecimentos

Como trabalhos futuros, pretende-se revisitar a reprodução do cálculo do coeficiente de correção $Z$ descrito no artigo de Mishonov, buscando refinar a metodologia e reduzir possíveis discrepâncias observadas. Além disso, planeja-se desenvolver uma versão 2 da placa de circuito, aprimorada para realizar outros experimentos idealizados por Mishonov, ampliando o escopo de análise e aplicação do modelo.

Gostaria de expressar minha gratidão a todas as pessoas que contribuíram para este projeto. À minha namorada Jade, pelo apoio constante e encorajador durante todas as etapas do projeto. Ao meu amigo Prof. Me. Edney Melo, cuja ideia inicial tornou possível o desenvolvimento da placa de circuito. Ao Prof. Dr. João Navarro, pela consultoria teórica e pelas discussões enriquecedoras. Ao meu amigo e engenheiro Júlio Calandrin, pela consultoria no projeto de hardware da placa. Também agradeço ao Prof. Dr. José Marcos Alves e ao Laboratório Aberto da SEL (LA-SEL), onde a montagem e a realização dos experimentos foram possíveis. À Prof. Dra. Daiane de Souza, sou grato pela oportunidade de usar este projeto como trabalho em sua disciplina de estatística, o que foi essencial para conectar os conceitos teóricos à prática experimental. 

Finalmente, agradeço a todos os meus amigos que me suportaram falando deste projeto que, no fundo, só eu me interesso. A todos vocês, meu mais sincero agradecimento!


= Referências
- T. M. Mishonov, V. N. Gourev, I. M. Dimitrova, N. S. Serafimov, A. A. Stefanov, E. G. Petkov, and A. M. Varonov, "Determination of the Boltzmann constant by the equipartition theorem for capacitors," *European Journal of Physics*, vol. 40, no. 3, p. 035102, Apr. 2019. doi: [10.1088/1361-6404/ab07e0](https://doi.org/10.1088/1361-6404/ab07e0).

- C. H. C. A. Veras, "Einstein-Boltzmann Board," *GitHub* repository, https://github.com/CarlosCraveiro/einstein-boltzmann/tree/main, accessed Dec. 5, 2024.

- B. P. Lathi and Z. Ding, *Modern Digital and Analog Communication Systems*, Oxford series in electrical and computer engineering. Oxford University Press, 2019. Available: [https://books.google.com.br/books?id=KZpnswEACAAJ](https://books.google.com.br/books?id=KZpnswEACAAJ).

- D. C. Montgomery and G. C. Runger, *Applied Statistics and Probability for Engineers*. John Wiley & Sons, 2010. Available: [https://books.google.com.br/books?id=_f4KrEcNAfEC](https://books.google.com.br/books?id=_f4KrEcNAfEC).

- "Aluno da EESC apresenta projeto de Open Hardware no FOSFORUMS 2024," *Escola de Engenharia de São Carlos*, Universidade de São Paulo, 3 de setembro de 2024. [Online]. Disponível em: https://eesc.usp.br/ppgs/stt/post.php?guidp=aluno-da-eesc-apresenta-projeto-de-open-hardware-no-fosforums-2024&catid=noticias. [Acessado: 5 de dezembro de 2024]. 

