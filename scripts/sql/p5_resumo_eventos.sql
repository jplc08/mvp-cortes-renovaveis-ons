SELECT
  u.fonte,
  COUNT(*) AS eventos,
  COUNTIF(e.flag_cabe_bateria) AS eventos_cabem_bateria,
  APPROX_QUANTILES(e.duracao_h, 100)[OFFSET(50)] AS duracao_mediana_h,
  APPROX_QUANTILES(e.duracao_h, 100)[OFFSET(90)] AS duracao_p90_h,
  MAX(e.duracao_h) AS duracao_maxima_h,
  ROUND(SUM(e.energia_cortada_mwh), 3) AS cortada_mwh,
  ROUND(SUM(CASE WHEN e.flag_cabe_bateria THEN e.energia_cortada_mwh ELSE 0 END), 3) AS cortada_cabe_bateria_mwh,
  APPROX_QUANTILES(e.corte_maximo_mw, 100)[OFFSET(50)] AS corte_maximo_mediano_mw
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON e.sk_usina = u.sk_usina
WHERE e.energia_cortada_mwh > 0
GROUP BY u.fonte
