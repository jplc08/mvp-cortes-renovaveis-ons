SELECT
  u.fonte,
  d.mes,
  h.hora,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON f.sk_data = d.sk_data
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_horario AS h ON f.sk_horario = h.sk_horario
GROUP BY u.fonte, d.mes, h.hora
