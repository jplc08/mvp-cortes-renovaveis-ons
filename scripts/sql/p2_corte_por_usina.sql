SELECT
  u.sk_usina,
  u.id_ons,
  u.nom_usina,
  u.fonte,
  COALESCE(u.uf, 'NI') AS uf,
  COALESCE(u.id_subsistema, 'NI') AS subsistema,
  u.nom_agenteoperador,
  u.potencia_disponivel_max_mw,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh,
  ROUND(SUM(f.energia_potencial_mwh), 3) AS potencial_mwh,
  ROUND(100 * SAFE_DIVIDE(SUM(f.energia_cortada_mwh), SUM(f.energia_potencial_mwh)), 2) AS pct_cortado,
  COUNTIF(f.flag_restrito) AS intervalos_restritos
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
GROUP BY u.sk_usina, u.id_ons, u.nom_usina, u.fonte, u.uf, u.id_subsistema, u.nom_agenteoperador, u.potencia_disponivel_max_mw
ORDER BY cortada_mwh DESC
