SELECT
  u.fonte,
  e.intervalos,
  COUNT(*) AS eventos,
  ROUND(SUM(e.energia_cortada_mwh), 3) AS cortada_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON e.sk_usina = u.sk_usina
WHERE e.energia_cortada_mwh > 0
GROUP BY u.fonte, e.intervalos
ORDER BY u.fonte, e.intervalos
