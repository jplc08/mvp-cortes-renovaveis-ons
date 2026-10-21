SELECT
  fonte,
  tipo_dia,
  COUNT(*) AS dias,
  ROUND(AVG(cortada_mwh), 3) AS media_diaria_mwh
FROM (
  SELECT u.fonte, d.sk_data, d.tipo_dia, SUM(f.energia_cortada_mwh) AS cortada_mwh
  FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
  JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
  JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_data AS d ON f.sk_data = d.sk_data
  GROUP BY u.fonte, d.sk_data, d.tipo_dia
) AS diario
GROUP BY fonte, tipo_dia
