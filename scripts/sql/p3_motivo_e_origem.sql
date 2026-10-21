SELECT
  u.fonte,
  r.cod_razao,
  r.natureza,
  r.cod_origem,
  r.nome_origem,
  COUNT(*) AS intervalos,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_restricao AS r ON f.sk_restricao = r.sk_restricao
WHERE f.flag_restrito
GROUP BY u.fonte, r.cod_razao, r.natureza, r.cod_origem, r.nome_origem
