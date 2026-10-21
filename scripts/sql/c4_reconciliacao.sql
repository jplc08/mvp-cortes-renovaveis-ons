SELECT
  (SELECT COUNT(*) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao) AS linhas_fato_restricao,
  (SELECT COUNT(DISTINCT sk_usina) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao) AS usinas_com_registro,
  (SELECT COUNTIF(flag_restrito) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao) AS intervalos_restritos,
  (SELECT ROUND(SUM(energia_gerada_mwh), 3) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao) AS energia_gerada_mwh,
  (SELECT ROUND(SUM(energia_cortada_mwh), 3) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao) AS energia_cortada_mwh,
  (SELECT COUNT(*) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte) AS eventos,
  (SELECT ROUND(SUM(energia_cortada_mwh), 3) FROM `mvp-olist-entregas.ons_cortes_dw`.fato_evento_corte) AS energia_cortada_eventos_mwh
