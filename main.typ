#import "./poster.typ": *

#show: poster.with(
  size: "36x24",
  title: "TODO...",
  authors: "Carlos H.C.A.Veras - 12547187",
  departments: "Engenharia de Computação",
  univ_logo: "./images/eesc_usp_logo.png",
  univ_logo_scale: 90,
  footer_text: "SME0123 - Estatística",
  footer_url: "Dezembro - 2024",
  footer_url_email_font_size: 28,
  footer_email_ids: "carlos.craveiro@usp.br",
  footer_color: "23477C",
  footer_text_color: "FFFFFF",
  body_text_size: 18,

  keywords: ("Regressão Linear", "Ruído Térmico", "Constante de Boltzmann", "Densidade Espectral de Potência"),
)

= TODO...

Lorem Ipsum...

O sistema de classificação pode ser melhor entendido por meio da Figura 1.

#figure(
  image("./images/flynns_taxonomy.png", 
        width: 100%),
  caption: [Diagrama esquemático das diferentes classes propostas por Flynn]
)

Ressalta-se que o sistema proposto por Flynn, apesar da idade, ainda é utilizado como ferramenta para design de processadores modernos. Sua última alteração foi em 1972, no artigo "_Some Computer Organizations and Their Effectiveness_" onde Flynn propôs três sub-classificações para a Arquitetura SIMD: Processamento Matricial (SIMT), Processamento com Pipeline (_packed SIMD_), Processamento Associativo (_predicated/masked SIMD_).

= Múltiplos Fluxos de Instruções, Múltiplos Fluxos de Dados (MIMD)
 
A classe MIMD de arquitetura paralela é a forma mais familiar e possivelmente a mais básica de processador paralelo: consiste em múltiplas unidades de processamento (núcleos), cada um com sua unidade lógico aritimética (ULA), conjunto de registradores (REG) e unidade de controle (UC), interconectadas, como pode ser visto na Figura 2. Ao contrário dos processadores SIMD, cada CPU executa de forma completamente independente (embora, tipicamente, o mesmo programa seja executado). Embora não haja um requisito para que todas os núcleos sejam idênticas, a maioria das configurações MIMD são homogêneas, com todas os núcleos sendo idênticas.

Quando a comunicação entre os núcleos é realizada por meio de um espaço de endereçamento de memória compartilhada (seja global ou distribuída entre os núcleos, chamada de memória compartilhada distribuída para diferenciá-la da memória distribuída), dois problemas significativos surgem. O primeiro é manter a consistência da memória—os efeitos de ordenação visíveis ao programador das referências de memória, tanto dentro de um núcleo quanto entre diferentes núcleos. O segundo é manter a coerência de cache—o mecanismo invisível ao programador para garantir que todas os núcleos vejam o mesmo valor para uma determinada posição de memória. O problema da consistência de memória é geralmente resolvido através de uma combinação de técnicas de hardware e software. O problema da coerência de cache é geralmente resolvido exclusivamente por meio de técnicas em hardware, como a implementação de algum protocolo de coerência de cache, como o protocolo MESI, por meio de estratégias como _Snooping_ de Barramento ou Sistema de Diretório.

#figure(
  image("./images/mimd.svg", 
        width: 90%),
  caption: [Diagrama esquemático da arquitetura MIMD - Autoral]
)

= Usos e aplicações de máquinas MIMD
#block(
  fill: luma(230),
  inset: 8pt,
  radius: 4pt,
  [
    - Exemplos de uso: simulações científicas, inteligência artificial, computação distribuída.
    - Tendências futuras: maior uso em processamento paralelo e sistemas distribuídos.
  ]
)

= Referências
- M. J. Flynn, "Very high-speed computing systems" in Proceedings of the IEEE, vol. 54, no. 12, pp. 1901-1909, Dec. 1966, doi: 10.1109/PROC.1966.5273.

- M. J. Flynn, "Some Computer Organizations and Their Effectiveness" in IEEE Transactions on Computers, vol. C-21, no. 9, pp. 948-960, Sept. 1972, doi: 10.1109/TC.1972.5009071.

- M. J. Flynn, K. W. Rudd,  "Parallel architectures" in ACM Computing Surveys, vol. 28, pp. 67-70, 1996, doi: 10.1145/234313.234345
