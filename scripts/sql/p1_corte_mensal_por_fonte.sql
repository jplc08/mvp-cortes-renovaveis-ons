SELECT
  u.fonte,
  d.mes,
  COUNT(DISTINCT f.sk_usina) AS usinas,
  COUNT(*) AS intervalos,
  COUNTIF(f.flag_restrito) AS intervalos_restritos,
  ROUND(SUM(f.energia_gerada_mwh), 3) AS gerada_mwh,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh,
  ROUND(SUM(f.energia_potencial_mwh), 3) AS potencial_mwh,
  ROUND(100 * SAFE_DIVIDE(SUM(f.energia_cortada_mwh), SUM(f.energia_potencial_mwh)), 2) AS pct_cortado
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON f.sk_data = d.sk_data
GROUP BY u.fonte, d.mes
ORDER BY u.fonte, d.mes
