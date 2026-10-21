SELECT
  COALESCE(u.uf, 'NI') AS uf,
  u.fonte,
  COUNT(DISTINCT u.sk_usina) AS usinas,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh,
  ROUND(SUM(f.energia_potencial_mwh), 3) AS potencial_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
GROUP BY COALESCE(u.uf, 'NI'), u.fonte
