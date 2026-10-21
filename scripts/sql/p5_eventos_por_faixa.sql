SELECT
  u.fonte,
  e.faixa_duracao,
  COUNT(*) AS eventos,
  ROUND(SUM(e.energia_cortada_mwh), 3) AS cortada_mwh,
  ROUND(AVG(e.duracao_h), 2) AS duracao_media_h,
  ROUND(AVG(e.corte_maximo_mw), 2) AS corte_maximo_medio_mw
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte AS e
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON e.sk_usina = u.sk_usina
WHERE e.energia_cortada_mwh > 0
GROUP BY u.fonte, e.faixa_duracao
