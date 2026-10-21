# Resultados — leitura automática

_Gerado em 21/10/2026 09:45 (UTC-3) a partir da execução do notebook (dados de 2025, coletados em 21/10/2026)._

## P1

Em 2025, as usinas eólicas e solares do conjunto analisado deixaram de gerar **37,22 TWh** por cortes, **20,7% da energia que poderiam ter produzido**. Isso equivale a uma usina de **4.249 MW médios** parada o ano inteiro. 37,0% dos intervalos usina × meia hora tiveram alguma restrição. **Eólica:** 26,22 TWh cortados, **19,1% do potencial**; pico em outubro (29,8%); 14,1% no 1º semestre e 22,6% no 2º; sem tendência significativa (ρ = 0,51, p = 0,090). **Solar:** 11,00 TWh cortados, **25,7% do potencial**; pico em agosto (36,8%); 21,3% no 1º semestre e 29,5% no 2º; sem tendência significativa (ρ = 0,47, p = 0,124). De janeiro a agosto, o percentual cortado das duas fontes juntas foi 18,1%; a estimativa de mercado citada na Seção 1.1 era de 17,6% para o mesmo período, o que confirma a ordem de grandeza.

## P2

**RN** concentra **31,4%** da energia cortada, seguida de BA (29,2%) e MG (13,5%); as três primeiras somam 74,1%. O subsistema Nordeste responde por **84,3%** do corte. Entre as UFs com pelo menos 1% do potencial, a de maior percentual cortado é MG (27,3% do seu potencial). Das 235 usinas (ou conjuntos) com registros, 235 tiveram algum corte. **107 usinas (45,5% do total) respondem por 80% da energia cortada**, e as 10 mais afetadas por 17,6%. A mais afetada é Conj. Janaúba (Solar, MG), com 1,13 TWh cortados (33,5% do seu potencial). O agente operador com mais energia cortada responde por 10,0% do total.

## P3

No ano, o motivo **Energético (ENE)** lidera, com **53,9%** da energia cortada. O motivo energético (ENE, excesso de oferta) responde por **53,9%**, e os motivos elétricos (confiabilidade CNF + indisponibilidade externa REL) por **46,1%**; parecer de acesso (PAR) por 0,0% e intervalos sem motivo informado por 0,0%. Eólica: ENE 50,8%, elétricos 49,2%. Solar: ENE 61,3%, elétricos 38,7%. Quanto à origem, 84,4% da energia foi cortada em restrições **sistêmicas** e 15,6% em restrições **locais**. A participação do motivo energético foi de 45,7% no 1º semestre e 58,0% no 2º, variando de 13,1% (fevereiro) a 74,5% (maio).

## P4

**61,7% da energia cortada** nas duas fontes aconteceu entre 09h00 e 15h59, janela que tem 29% das horas do dia. Eólica: 55,6% no meio-dia, pico às 10:00, 21,3% entre 18h e 6h. Solar: 76,3% no meio-dia, pico às 10:00, 0,0% entre 18h e 6h. Em média, um domingo ou feriado tem **1,64 vez(es)** o corte de um dia útil, e um sábado 1,23 vez(es) — o corte cresce quando a carga cai.

## P5

Foram identificados **64.439 eventos de corte** com perda de energia. **10,7% dos eventos duram até 4 h**, mas eles concentram só **1,4% da energia cortada**: os eventos longos são poucos e pesam muito. Eólica: duração mediana de 10,0 h, P90 de 17,5 h e máximo de 477 h; 1,4% da energia em eventos de até 4 h. Solar: duração mediana de 8,5 h, P90 de 10,5 h e máximo de 43 h; 1,5% da energia em eventos de até 4 h. As durações das duas fontes diferem significativamente (Mann-Whitney, p < 0,001). Uma bateria de 4 h junto a cada usina recuperaria, no limite teórico, **524,7 GWh** por ano.

## Avaliação das hipóteses

| hipotese | criterio | resultado | veredito |
|---|---|---|---|
| H1 — o corte é relevante | energia cortada ≥ 10% do potencial em pelo menos uma fonte | eólica 19,1% · solar 25,7% | Confirmada |
| H2 — o corte é concentrado em poucas usinas | ≤ 20% das usinas respondem por 80% da energia cortada | 107 de 235 usinas (45,5%) | Não confirmada |
| H3 — predomina o motivo energético | motivo ENE ≥ 50% da energia cortada | ENE 53,9% · elétricos (REL + CNF) 46,1% | Confirmada |
| H4 — o corte se concentra no meio do dia | ≥ 70% da energia cortada entre 09h00 e 15h59 | 61,7% da energia cortada | Não confirmada |
| H5 — baterias de 4 h absorveriam a maior parte | ≥ 50% da energia cortada em eventos de até 4 h | 1,4% da energia (10,7% dos eventos) | Não confirmada |

## Síntese

Em 2025, 37,22 TWh de energia eólica e solar deixaram de ser gerados (20,7% do potencial; eólica 19,1%, solar 25,7%). O corte é geograficamente concentrado (RN responde por 31,4%, o Nordeste por 84,3%) e pouco concentrado entre usinas (45,5% das usinas somam 80% do corte). O motivo energético responde por 53,9% e os elétricos por 46,1%: a alavanca de maior peso é **gestão de oferta e demanda e armazenamento**. 61,7% do corte acontece entre 09h e 16h, e domingos e feriados têm 1,64 vez(es) o corte de um dia útil. Eventos de até 4 h são 10,7% dos eventos, mas só 1,4% da energia: baterias de curta duração ajudam, mas não resolvem sozinhas; os eventos longos pedem rede ou armazenamento de longa duração.

## Custo de operação

Uma execução completa processa **1.395,1 MB** no BigQuery e ocupa **556,6 MB** de armazenamento: 0,133% e 5,44% das franquias gratuitas. Mesmo com 30 execuções por mês, o consumo seria de 3,99% da franquia de consultas. **Custo operacional: US$ 0,00.** Sem franquia, uma execução custaria cerca de US$ 0,0083 em consultas e o armazenamento, US$ 0,0109 por mês: valores irrelevantes diante de um problema medido em milhões de MWh e bilhões de reais.
