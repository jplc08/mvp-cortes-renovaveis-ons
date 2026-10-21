# Catálogo de Dados — Data Warehouse `ons_cortes_dw`

Gerado automaticamente pelo notebook a partir da definição única do catálogo (Seção 7.2). As mesmas descrições estão gravadas nas colunas das tabelas do BigQuery.

Colunas: **Tipo (BigQuery)**, **Tipo lógico** (numérico, categórico, texto, data, booleano), **Domínio** (faixa mínima e máxima esperada, lista de valores válidos ou padrão), **Obrigatório**, **Significado do nulo** e **Linhagem** (coluna de origem no ONS e regras de transformação, ver [regras_transformacao.md](regras_transformacao.md)).

Modelo: [modelo_dados.md](modelo_dados.md) · Diagrama: [modelo_dimensional.png](modelo_dimensional.png)

## dim_usina

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_usina | INT64 | numérico | Chave substituta da usina (PK). | 1 a 9999 | Sim | Não admite nulo. | Sequencial por (fonte, id_ons) (R11). |
| id_ons | STRING | texto | Identificador da usina (ou conjunto de usinas) no ONS (chave natural, junto com a fonte). | Texto livre | Sim | Não admite nulo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): id_ons (R02). |
| nom_usina | STRING | texto | Nome da usina ou do conjunto de usinas. | Texto livre | Sim | Não admite nulo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): nom_usina, valor mais recente; nulo → id_ons (R10). |
| fonte | STRING | categórico | Fonte de geração (código). | eolica, solar | Sim | Não admite nulo. | Conjunto de dados de origem (eólica ou fotovoltaica). |
| nome_fonte | STRING | categórico | Fonte de geração (nome). | Eólica, Solar fotovoltaica | Sim | Não admite nulo. | Derivado de `fonte`. |
| ceg | STRING | texto | Código Único de Empreendimentos de Geração (CEG) da ANEEL. | Texto livre | Não | Conjunto de usinas sem CEG único ou CEG não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): ceg, valor mais recente (R10). |
| uf | STRING | categórico | Unidade federativa onde a usina está (sigla). | 27 valores: AC, AL, AM, AP … TO | Não | UF não informada na origem. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): id_estado, valor mais recente (R02, R10). |
| nom_estado | STRING | texto | Nome da unidade federativa. | Texto livre | Não | UF não informada na origem. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): nom_estado (R10). |
| id_subsistema | STRING | categórico | Subsistema do SIN: N (Norte), NE (Nordeste), SE (Sudeste/Centro-Oeste), S (Sul). | N, NE, SE, S | Não | Subsistema não informado na origem. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): id_subsistema (R02, R10). |
| nom_subsistema | STRING | texto | Nome do subsistema. | Texto livre | Não | Subsistema não informado na origem. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): nom_subsistema (R10). |
| id_pontoconexao | STRING | texto | Identificador do ponto de conexão da usina à rede. | Texto livre | Não | Ponto de conexão não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): id_pontoconexao (R10). |
| nom_pontoconexao | STRING | texto | Nome do ponto de conexão (subestação/barramento). | Texto livre | Não | Ponto de conexão não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): nom_pontoconexao (R10). |
| nom_agenteoperador | STRING | texto | Agente responsável pela operação da usina (pessoa jurídica). | Texto livre | Não | Agente não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): nom_agenteoperador (R10). |
| potencia_disponivel_max_mw | FLOAT64 | numérico | Maior disponibilidade declarada no ano (MW). Aproxima a capacidade operativa. | 0 a 2500 | Não | Disponibilidade nunca informada. | MAX(val_disponibilidade) por usina (R10). |
| primeiro_registro | DATETIME | data | Primeiro intervalo registrado da usina no ano. | 2025-01-01 a 2025-12-31 | Sim | Não admite nulo. | MIN(din_instante) por usina. |
| ultimo_registro | DATETIME | data | Último intervalo registrado da usina no ano. | 2025-01-01 a 2025-12-31 | Sim | Não admite nulo. | MAX(din_instante) por usina. |
| flag_atributo_alterado | BOOL | booleano | Verdadeiro se estado, subsistema, agente ou ponto de conexão mudou durante o ano. | verdadeiro, falso | Sim | Não admite nulo. | Contagem de valores distintos por usina (R10). |
| atributos_alterados | STRING | texto | Lista dos atributos que mudaram no ano. | Texto livre | Não | Nenhum atributo alterado. | Regra R10. |

## dim_data

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_data | INT64 | numérico | Chave substituta da data, no formato AAAAMMDD (PK). | 20250101 a 20251231 | Sim | Não admite nulo. | Gerada a partir de `data` (R11). |
| data | DATE | data | Data do calendário. | 2025-01-01 a 2025-12-31 | Sim | Não admite nulo. | Calendário contínuo do ano analisado. |
| ano | INT64 | numérico | Ano civil. | 2025 a 2025 | Sim | Não admite nulo. | Derivado de `data`. |
| semestre | INT64 | numérico | Semestre do ano. | 1 a 2 | Sim | Não admite nulo. | Derivado de `data`. |
| trimestre | INT64 | numérico | Trimestre do ano. | 1 a 4 | Sim | Não admite nulo. | Derivado de `data`. |
| mes | INT64 | numérico | Mês do ano. | 1 a 12 | Sim | Não admite nulo. | Derivado de `data`. |
| nome_mes | STRING | categórico | Nome do mês em português. | janeiro, fevereiro, março, abril, maio, junho, julho, agosto, setembro, outubro, novembro, dezembro | Sim | Não admite nulo. | Derivado de `data`. |
| dia | INT64 | numérico | Dia do mês. | 1 a 31 | Sim | Não admite nulo. | Derivado de `data`. |
| dia_semana | INT64 | numérico | Dia da semana ISO 8601 (1 = segunda-feira … 7 = domingo). | 1 a 7 | Sim | Não admite nulo. | Derivado de `data`. |
| nome_dia_semana | STRING | categórico | Nome do dia da semana em português. | segunda-feira, terça-feira, quarta-feira, quinta-feira, sexta-feira, sábado, domingo | Sim | Não admite nulo. | Derivado de `data`. |
| fim_de_semana | BOOL | booleano | Verdadeiro para sábado e domingo. | verdadeiro, falso | Sim | Não admite nulo. | Derivado de `dia_semana`. |
| feriado | BOOL | booleano | Verdadeiro em feriado nacional ou ponto facultativo nacional (Carnaval, Corpus Christi). | verdadeiro, falso | Sim | Não admite nulo. | Feriados fixos e móveis (Páscoa) (R14). |
| nome_feriado | STRING | texto | Nome do feriado ou ponto facultativo. | Texto livre | Não | Dia sem feriado. | Regra R14. |
| dia_util | BOOL | booleano | Verdadeiro se não é fim de semana nem feriado. | verdadeiro, falso | Sim | Não admite nulo. | Regra R14. |
| tipo_dia | STRING | categórico | Classificação usada no setor elétrico para a carga: dia útil, sábado, domingo ou feriado. | dia útil, sábado, domingo ou feriado | Sim | Não admite nulo. | Regra R14. |

## dim_horario

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_horario | INT64 | numérico | Chave do intervalo de meia hora no formato HHMM (0, 30, 100 … 2330) (PK). | 48 valores: 0, 30, 100, 130 … 2330 | Sim | Não admite nulo. | Hora e minuto de din_instante (R11). |
| hora_minuto | STRING | categórico | Início do intervalo no formato HH:MM. | Padrão ^([01]\d\|2[0-3]):(00\|30)$ | Sim | Não admite nulo. | Derivado de `sk_horario`. |
| hora | INT64 | numérico | Hora do dia (0 a 23). | 0 a 23 | Sim | Não admite nulo. | Derivado de `sk_horario`. |
| minuto | INT64 | numérico | Minuto de início do intervalo (0 ou 30). | 0, 30 | Sim | Não admite nulo. | Derivado de `sk_horario`. |
| indice_meia_hora | INT64 | numérico | Posição do intervalo no dia (0 = 00:00 … 47 = 23:30). | 0 a 47 | Sim | Não admite nulo. | Derivado de `sk_horario`. |
| periodo_dia | STRING | categórico | Madrugada (0h–5h), manhã (6h–11h), tarde (12h–17h) ou noite (18h–23h). | madrugada, manhã, tarde, noite | Sim | Não admite nulo. | Derivado de `hora`. |
| janela_meio_dia | BOOL | booleano | Verdadeiro entre 09h00 e 15h59 (pico solar e menor carga líquida). | verdadeiro, falso | Sim | Não admite nulo. | Regra R14 (parâmetros HORA_INICIO_MEIO_DIA e HORA_FIM_MEIO_DIA). |

## dim_restricao

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_restricao | INT64 | numérico | Chave substituta da combinação motivo × origem (PK). | 1 a 16 | Sim | Não admite nulo. | Sequencial (R11). |
| cod_razao | STRING | categórico | Motivo da restrição: REL, CNF, ENE, PAR; NI = não informado; SEM = intervalo sem restrição. | REL, CNF, ENE, PAR, NI, SEM | Sim | Não admite nulo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): cod_razaorestricao (R02, R09). |
| nome_razao | STRING | categórico | Nome do motivo da restrição. | Indisponibilidade externa, Confiabilidade elétrica, Energética (excesso de oferta), Parecer de acesso, Não informado, Sem restrição | Sim | Não admite nulo. | Dicionário de dados do ONS. |
| natureza | STRING | categórico | Natureza do motivo: elétrica (rede), energética (excesso de oferta) ou de acesso. | acesso, elétrica, energética, não informado, sem restrição | Sim | Não admite nulo. | Classificação deste trabalho a partir do dicionário do ONS. |
| alavanca | STRING | texto | Alavanca de política associada ao motivo (Seção 1.2). | Texto livre | Sim | Não admite nulo. | Classificação deste trabalho. |
| cod_origem | STRING | categórico | Origem da restrição: LOC (local), SIS (sistêmica); NI = não informada; SEM = sem restrição. | LOC, SIS, NI, SEM | Sim | Não admite nulo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): cod_origemrestricao (R02). |
| nome_origem | STRING | categórico | Nome da origem da restrição. | Local, Sistêmica, Não informada, Sem restrição | Sim | Não admite nulo. | Dicionário de dados do ONS. |
| flag_restricao | BOOL | booleano | Falso apenas para a linha 'sem restrição'. | verdadeiro, falso | Sim | Não admite nulo. | Derivado de `cod_razao`. |

## fato_restricao

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_usina | INT64 | numérico | Usina (FK → dim_usina). | 1 a 9999 | Sim | Não admite nulo. | (fonte, id_ons) → dim_usina (R11). |
| sk_data | INT64 | numérico | Data do intervalo (FK → dim_data). | 20250101 a 20251231 | Sim | Não admite nulo. | Data de din_instante (R11). |
| sk_horario | INT64 | numérico | Intervalo de meia hora (FK → dim_horario). | 48 valores: 0, 30, 100, 130 … 2330 | Sim | Não admite nulo. | Hora e minuto de din_instante (R03, R11). |
| sk_restricao | INT64 | numérico | Motivo × origem principal do intervalo (FK → dim_restricao). | 1 a 16 | Sim | Não admite nulo. | cod_razaorestricao × cod_origemrestricao; sem motivo: o de mais minutos; sem restrição: SEM (R06, R09). |
| din_instante | DATETIME | data | Início do intervalo de meia hora (horário de Brasília). Com sk_usina, forma a chave do grão. | 2025-01-01 a 2025-12-31 | Sim | Não admite nulo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): din_instante (R01, R03, R04). |
| geracao_mwmed | FLOAT64 | numérico | Geração verificada no intervalo (MW médios). | 0 a 2500 | Não | Geração não informada ou negativa na origem (R05). | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): val_geracao (R05). |
| geracao_limitada_mwmed | FLOAT64 | numérico | Limite de geração imposto pelo ONS no intervalo (MW médios). | 0 a 2500 | Não | Intervalo sem limitação. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): val_geracaolimitada (R05). |
| disponibilidade_mwmed | FLOAT64 | numérico | Disponibilidade declarada da usina (MW médios). | 0 a 2500 | Não | Disponibilidade não informada. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): val_disponibilidade (R05). |
| geracao_referencia_mwmed | FLOAT64 | numérico | Geração de referência: o que a usina geraria sem restrição, estimado pelo ONS (MW médios). | 0 a 2500 | Não | Referência não calculada pelo ONS no intervalo. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): val_geracaoreferenciafinal, ou val_geracaoreferencia na falta dela (R05, R07). |
| geracao_nao_realizada_apurada_mwmed | FLOAT64 | numérico | Energia não gerada apurada pelo ONS (GNRa), como publicada (MW médios). | 0 a 2500 | Não | Não apurada (intervalo sem restrição ou lacuna da origem). | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): val_geracaonaorealizadaapurada (R05). |
| minutos_restricao | INT64 | numérico | Minutos do intervalo sob restrição. | 0 a 30 | Não | Não informado ou fora de 0 a 30 na origem (R05). | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): num_minutos_restricao (R05). |
| minutos_rel | INT64 | numérico | Minutos restritos por indisponibilidade externa (REL). | 0 a 30 | Não | Não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): num_minutos_rel (R05). |
| minutos_cnf | INT64 | numérico | Minutos restritos por confiabilidade elétrica (CNF). | 0 a 30 | Não | Não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): num_minutos_cnf (R05). |
| minutos_ene | INT64 | numérico | Minutos restritos por razão energética (ENE). | 0 a 30 | Não | Não informado. | Colunas do ONS (restricao_coff_eolica_tm / restricao_coff_fotovoltaica_tm): num_minutos_ene (R05). |
| energia_gerada_mwh | FLOAT64 | numérico | Energia gerada no intervalo (MWh). Medida aditiva. | 0 a 1250 | Não | Geração não informada. | geracao_mwmed × 0,5 h (R08). |
| energia_cortada_mwh | FLOAT64 | numérico | Energia que deixou de ser gerada por restrição (MWh). Medida aditiva. | 0 a 1250 | Sim | Não admite nulo. | GNRa × 0,5 h; sem GNRa, max(0, referência − geração) × 0,5 h (R07, R08). |
| energia_potencial_mwh | FLOAT64 | numérico | Energia que a usina poderia ter gerado: gerada + cortada (MWh). Denominador do % cortado. | 0 a 1250 | Sim | Não admite nulo. | energia_gerada_mwh (nulo = 0) + energia_cortada_mwh (R08). |
| energia_cortada_rel_mwh | FLOAT64 | numérico | Parcela da energia cortada atribuída a indisponibilidade externa (REL) (MWh). As cinco parcelas somam energia_cortada_mwh. | 0 a 1250 | Sim | Não admite nulo. | Rateio pelos minutos por motivo (R09). |
| energia_cortada_cnf_mwh | FLOAT64 | numérico | Parcela da energia cortada atribuída a confiabilidade elétrica (CNF) (MWh). As cinco parcelas somam energia_cortada_mwh. | 0 a 1250 | Sim | Não admite nulo. | Rateio pelos minutos por motivo (R09). |
| energia_cortada_ene_mwh | FLOAT64 | numérico | Parcela da energia cortada atribuída a razão energética (ENE) (MWh). As cinco parcelas somam energia_cortada_mwh. | 0 a 1250 | Sim | Não admite nulo. | Rateio pelos minutos por motivo (R09). |
| energia_cortada_par_mwh | FLOAT64 | numérico | Parcela da energia cortada atribuída a parecer de acesso (PAR) (MWh). As cinco parcelas somam energia_cortada_mwh. | 0 a 1250 | Sim | Não admite nulo. | Rateio pelos minutos por motivo (R09). |
| energia_cortada_ni_mwh | FLOAT64 | numérico | Parcela da energia cortada atribuída a motivo não informado (NI) (MWh). As cinco parcelas somam energia_cortada_mwh. | 0 a 1250 | Sim | Não admite nulo. | Rateio pelos minutos por motivo (R09). |
| flag_restrito | BOOL | booleano | Verdadeiro se o intervalo teve restrição (minutos, motivo ou energia não gerada). | verdadeiro, falso | Sim | Não admite nulo. | Regra R06. |
| flag_energia_recalculada | BOOL | booleano | Verdadeiro se a energia cortada foi recalculada porque a GNRa estava ausente. | verdadeiro, falso | Sim | Não admite nulo. | Regra R07. |
| flag_geracao_acima_disponibilidade | BOOL | booleano | Verdadeiro se a geração superou a disponibilidade declarada em mais de 1 MW. | verdadeiro, falso | Sim | Não admite nulo. | Regra R08. |

## fato_evento_corte

| Atributo | Tipo (BigQuery) | Tipo lógico | Descrição | Domínio | Obrigatório | Significado do nulo | Linhagem |
|---|---|---|---|---|---|---|---|
| sk_evento | INT64 | numérico | Chave do evento de corte (PK). | 1 a 10000000 | Sim | Não admite nulo. | Sequencial (R12). |
| sk_usina | INT64 | numérico | Usina (FK → dim_usina). | 1 a 9999 | Sim | Não admite nulo. | fato_restricao.sk_usina. |
| sk_data_inicio | INT64 | numérico | Data de início do evento (FK → dim_data). | 20250101 a 20251231 | Sim | Não admite nulo. | Data do primeiro intervalo (R12). |
| sk_horario_inicio | INT64 | numérico | Meia hora de início do evento (FK → dim_horario). | 48 valores: 0, 30, 100, 130 … 2330 | Sim | Não admite nulo. | Horário do primeiro intervalo (R12). |
| sk_restricao_predominante | INT64 | numérico | Motivo × origem com mais energia cortada no evento (FK → dim_restricao). | 1 a 16 | Sim | Não admite nulo. | Maior soma por motivo e por origem; sem energia, a do primeiro intervalo (R12). |
| inicio | DATETIME | data | Início do primeiro intervalo restrito do evento. | 2025-01-01 a 2025-12-31 | Sim | Não admite nulo. | MIN(din_instante) do evento (R12). |
| fim | DATETIME | data | Fim do último intervalo restrito do evento (início + 30 min). | 2025-01-01 a 2026-01-01 | Sim | Não admite nulo. | MAX(din_instante) + 30 min (R12). |
| intervalos | INT64 | numérico | Quantidade de meias horas consecutivas restritas. | 1 a 17568 | Sim | Não admite nulo. | COUNT de intervalos do evento (R12). |
| duracao_h | FLOAT64 | numérico | Duração do evento em horas. | 0.5 a 8784 | Sim | Não admite nulo. | intervalos × 0,5 h (R12). |
| minutos_restritos | INT64 | numérico | Soma dos minutos restritos informados nos intervalos do evento. | 0 a 527040 | Sim | Não admite nulo. | SUM(minutos_restricao) (R12). |
| energia_cortada_mwh | FLOAT64 | numérico | Energia cortada no evento (MWh). Medida aditiva. | 0 a 1000000 | Sim | Não admite nulo. | SUM(fato_restricao.energia_cortada_mwh) (R12). |
| corte_maximo_mw | FLOAT64 | numérico | Maior potência média cortada num intervalo do evento (MW): a potência que uma bateria precisaria ter. | 0 a 2500 | Sim | Não admite nulo. | MAX(energia_cortada_mwh × 2) (R12). |
| faixa_duracao | STRING | categórico | Faixa de duração do evento. | até 1 h, 1 a 2 h, 2 a 4 h, 4 a 8 h, 8 a 12 h, mais de 12 h | Sim | Não admite nulo. | Derivado de `duracao_h` (R12). |
| flag_cabe_bateria | BOOL | booleano | Verdadeiro se o evento dura até 4 h (parâmetro DURACAO_BATERIA_H), o que uma bateria dessa duração cobriria. | verdadeiro, falso | Sim | Não admite nulo. | duracao_h ≤ DURACAO_BATERIA_H (R12). |

