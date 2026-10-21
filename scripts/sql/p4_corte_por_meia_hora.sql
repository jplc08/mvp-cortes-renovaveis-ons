SELECT
  u.fonte,
  h.sk_horario,
  h.indice_meia_hora,
  h.hora_minuto,
  h.janela_meio_dia,
  COUNTIF(f.flag_restrito) AS intervalos_restritos,
  ROUND(SUM(f.energia_cortada_mwh), 3) AS cortada_mwh
FROM `mvp-olist-entregas.ons_cortes_dw`.fato_restricao AS f
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_usina AS u ON f.sk_usina = u.sk_usina
JOIN `mvp-olist-entregas.ons_cortes_dw`.dim_horario AS h ON f.sk_horario = h.sk_horario
GROUP BY u.fonte, h.sk_horario, h.indice_meia_hora, h.hora_minuto, h.janela_meio_dia
ORDER BY u.fonte, h.indice_meia_hora
