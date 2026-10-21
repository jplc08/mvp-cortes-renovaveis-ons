SELECT 'Chave duplicada na fato_restricao (sk_usina, din_instante)' AS verificacao, COUNT(*) AS ocorrencias
FROM (SELECT sk_usina, din_instante FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao GROUP BY sk_usina, din_instante HAVING COUNT(*) > 1) AS d
UNION ALL SELECT 'Chave duplicada na fato_evento_corte', COUNT(*) - COUNT(DISTINCT sk_evento) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte
UNION ALL SELECT 'Chave duplicada em dim_usina', COUNT(*) - COUNT(DISTINCT sk_usina) FROM `mvp-olist-entregas.ons_cortes_dw`.dim_usina
UNION ALL SELECT 'Chave natural duplicada em dim_usina (fonte, id_ons)', COUNT(*)
FROM (SELECT fonte, id_ons FROM `mvp-olist-entregas.ons_cortes_dw`.dim_usina GROUP BY fonte, id_ons HAVING COUNT(*) > 1) AS d
UNION ALL SELECT 'Chave duplicada em dim_data', COUNT(*) - COUNT(DISTINCT sk_data) FROM `mvp-olist-entregas.ons_cortes_dw`.dim_data
UNION ALL SELECT 'Chave duplicada em dim_horario', COUNT(*) - COUNT(DISTINCT sk_horario) FROM `mvp-olist-entregas.ons_cortes_dw`.dim_horario
UNION ALL SELECT 'Chave duplicada em dim_restricao', COUNT(*) - COUNT(DISTINCT sk_restricao) FROM `mvp-olist-entregas.ons_cortes_dw`.dim_restricao
UNION ALL SELECT 'FK sem correspondência: fato_restricao.sk_usina', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina WHERE u.sk_usina IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_restricao.sk_data', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON f.sk_data = d.sk_data WHERE d.sk_data IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_restricao.sk_horario', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_horario AS h ON f.sk_horario = h.sk_horario WHERE h.sk_horario IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_restricao.sk_restricao', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_restricao AS r ON f.sk_restricao = r.sk_restricao WHERE r.sk_restricao IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_evento_corte.sk_usina', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON e.sk_usina = u.sk_usina WHERE u.sk_usina IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_evento_corte.sk_data_inicio', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON e.sk_data_inicio = d.sk_data WHERE d.sk_data IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_evento_corte.sk_horario_inicio', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_horario AS h ON e.sk_horario_inicio = h.sk_horario WHERE h.sk_horario IS NULL
UNION ALL SELECT 'FK sem correspondência: fato_evento_corte.sk_restricao_predominante', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e LEFT JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_restricao AS r ON e.sk_restricao_predominante = r.sk_restricao WHERE r.sk_restricao IS NULL
UNION ALL SELECT 'Rateio por motivo diferente do total cortado (> 0,001 MWh)', COUNT(*)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao
WHERE ABS(energia_cortada_rel_mwh + energia_cortada_cnf_mwh + energia_cortada_ene_mwh + energia_cortada_par_mwh
          + energia_cortada_ni_mwh - energia_cortada_mwh) > 0.001
UNION ALL SELECT 'Energia cortada em intervalo não restrito', COUNTIF(NOT flag_restrito AND energia_cortada_mwh > 0)
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao
