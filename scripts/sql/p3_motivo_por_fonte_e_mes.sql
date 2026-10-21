SELECT
  u.fonte,
  d.mes,
  ROUND(SUM(f.energia_cortada_ene_mwh), 3) AS ene_mwh,
  ROUND(SUM(f.energia_cortada_cnf_mwh), 3) AS cnf_mwh,
  ROUND(SUM(f.energia_cortada_rel_mwh), 3) AS rel_mwh,
  ROUND(SUM(f.energia_cortada_par_mwh), 3) AS par_mwh,
  ROUND(SUM(f.energia_cortada_ni_mwh), 3) AS ni_mwh,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS total_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON f.sk_data = d.sk_data
WHERE f.flag_restrito
GROUP BY u.fonte, d.mes
ORDER BY u.fonte, d.mes
