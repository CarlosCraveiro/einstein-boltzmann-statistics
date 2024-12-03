#import "./poster.typ": *

#show: poster.with(
  size: "36x24",
  title: "TODO...",
  authors: "Carlos H.C.A.Veras - 12547187",
  departments: "Engenharia de Computação",
  univ_logo: "./images/icmc_usp_logo.png",
  univ_logo_scale: 90,
  footer_text: "SME0123 - Estatística",
  footer_url: "Dezembro - 2024",
  footer_url_email_font_size: 28,
  footer_email_ids: "carlos.craveiro@usp.br",
//footer_color: "23477C", // EESC
  footer_color: "72849D", // ICMC
  footer_text_color: "FFFFFF",
  body_text_size: 18,

  keywords: ("Regressão Linear", "Ruído Térmico", "Constante de Boltzmann", "Densidade Espectral de Potência"),
)

= Introdução

Em 1902, Albert Einstein sugeriu em um periódico da época que seria teoricamente possível medir a constante de Stefan-Boltzmann, fundamental nos fenômenos termodinâmicos, observando os efeitos da energia térmica em componentes eletrônicos. Em 2017, 115 anos depois, Todor M. Mishonov, do Laboratório de Medidas de Constantes Fundamentais, e seus colegas da Universidade de Sofia, na Bulgária, decidiram colocar as ideias de Einstein em prática em um experimento para estudantes durante a 5ª Olimpíada de Física Experimental dos Bálcãs. Curiosamente, essa proposta nunca havia sido implementada de forma direta até então.

A abordagem utilizada, embora engenhosa, foi bastante simples. Ela explorou o fato de que o movimento aleatório dos elétrons (movimento browniano), uma manifestação de energia térmica, em uma resistência elétrica gera o que é conhecido como Ruído de Johnson-Nyquist, ou simplesmente Ruído Térmico: um ruído gaussiano de média zero. Assim, ao mensurar esse ruído, seria possível, em teoria, relacionar a energia elétrica com a energia térmica e calcular a constante de Boltzmann. Mas, como extrair informações úteis de uma variável aleatória com média nula? Estatisticamente, é simples: basta observar sua variância! Afinal, apesar da média ser zero, a variância do ruído está diretamente relacionada à sua energia—aquilo que, ao refletir um pouco, faz perfeito sentido.

Para implementar essa ideia, o experimento envolve acoplar um capacitor ($C$ [F]) em paralelo com uma resistência ($R$ [Ω]). Quando o sistema está em equilíbrio térmico, a potência quadrática média ($<U^2>$ [$V^2$]) nos terminais do circuito pode ser expressa como:

#v(0.5cm)

#align(center)[
#text(size: 25pt)[
$<U^2> = (k_b T)/(C)$,
]]

#v(0.5cm)

onde $T$ é a temperatura em Kelvin e $k_b$ é a constante de Boltzmann e Joule por Kelvin ($J.K^(-1)$). Essa relação estabelece que, para uma temperatura constante, a tensão quadrática média é inversamente proporcional à capacitância do sistema. Isso significa que, ao variar a capacitância e medir a tensão quadrática média em uma série de experimentos, é possível determinar o valor de $k_b$. Um ponto interessante desse modelo é que a resistência $R$ não influencia o resultado final—ela "se cancela" matematicamente durante as deduções, deixando a resposta dependente apenas da capacitância e da temperatura. Dessa forma, o experimento se torna não apenas engenhoso, mas também direto e eficiente.

= Analise dos dados


#show table.cell.where(y: 0): strong
#figure(
caption: [A table],
table(
  columns: 8,
  align: center,
  table.header[Classes $C_n$ [$n F$]][Média][Mediana][Moda][Desvio Padrão][Mínimo][Máximo][F. Abs],
  [\[4.573 - 18.652\)], [11.459], [10.870], [4.755], [4.772], [4.755], [17.711], [13],
  [\[18.652 - 32.732\)], [29.410], [29.410], [28.780], [0.891], [28.780], [30.040], [2],
  [\[32.732 - 46.811\)], [36.570], [36.950], [35.710], [0.746], [35.710], [37.050], [3],
  [\[46.811 - 60.891\)], [51.690], [50.805], [48.290], [4.204], [48.290], [59.620], [6],
  [\[60.891 - 74.97\)], [66.287], [63.770], [62.640], [5.814], [62.640], [74.970], [4],
  [Geral], [30.944], [28.780], [4.573], [22.180], [4.573], [74.970], [29],
))

#figure(
  image("./images/grafico_ganho.png", 
        width: 80%),
  caption: [An Image]
)
#figure(
caption: [A table],
table(
  columns: 4,
  align: center,
  table.header[Classes $U_1^2$ [$ m V^2$]][Média $U_2$ [$V$]][Desvio Padrão [$V$]][Frequência Absoluta],
  [\[416.025 - 782.82\)], [0.072], [0.011],[4],
  [\[782.82 - 1149.615\)], [0.114], [0.014], [4],
  [\[1149.615 - 1516.41\)], [0.152], [0.000], [2],
  [\[1516.41 - 1883.205\)], [0.181], [0.000], [2],
  [\[1883.205 - 2250.0\)], [0.230], [0.021], [4],
)
)
= Regressão Linear
Os parâmetros...
#figure(
caption: [A table],
table(
  columns: 4,
  align: center,
  table.header[Classes $C_n^(-1)$ [$10^6 F^(-1)$]][Média ($U_2^(2)T^(-1)$) [$10^(-6) V^2 K^(-1)$]][Desvio Padrão [$10^(-6) V^2 K^(-1)$]][Freq. Absoluta],
  [\[13.3 - 54.4\)], [25,059], [2,864], [15],
  [\[54.4 - 95.5\)], [42,410], [7,223], [7],
  [\[95.5 - 136.5\)], [55,824], [0,730], [2],
  [\[136.5 - 177.6\)], [76,708], [8,414], [2],
  [\[177.6 - 218.7\)], [99,124], [3,011], [3],
))

#figure(
  image("./images/fluctoscopia.png", 
        width: 80%),
  caption: [An Image]
)

#figure(
  caption: [*Resultados da Regressão Linear*],
block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    - *Coeficiente Angular (a):* $1,401 . 10^(-2)$
    - *$k_b$ (medido):* $1,40 . 10^(-23) ± 3,0 . 10^(-25) J.K^(-1)$
    - *R²:* $0,9881$
    - *$k_b$ (real):* $1,38 . 10^(-23)$
    - *Erro Relativo (%):* $1,5%$
  ]
)
)
= Referências
- T. M. Mishonov, V. N. Gourev, I. M. Dimitrova, N. S. Serafimov, A. A. Stefanov, E. G. Petkov, and A. M. Varonov, "Determination of the Boltzmann constant by the equipartition theorem for capacitors," *European Journal of Physics*, vol. 40, no. 3, p. 035102, Apr. 2019. doi: [10.1088/1361-6404/ab07e0](https://doi.org/10.1088/1361-6404/ab07e0).

- B. P. Lathi and Z. Ding, *Modern Digital and Analog Communication Systems*, Oxford series in electrical and computer engineering. Oxford University Press, 2019. Available: [https://books.google.com.br/books?id=KZpnswEACAAJ](https://books.google.com.br/books?id=KZpnswEACAAJ).

