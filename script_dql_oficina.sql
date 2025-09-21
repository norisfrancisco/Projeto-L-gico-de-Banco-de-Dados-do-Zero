-- Pergunta 1: Qual o valor total de cada Ordem de Serviço (peças + serviços)?
-- Cláusulas: SELECT, FROM, JOIN, LEFT JOIN, GROUP BY, ORDER BY, WITH (CTE), SUM (Atributo Derivado)

WITH TotalPecas AS (
    -- CTE para calcular o total de peças por OS
    SELECT
        idOS,
        SUM(p.valor * op.quantidade) AS ValorPecas
    FROM OS_Peca op
    JOIN Peca p ON op.idPeca = p.idPeca
    GROUP BY idOS
),
TotalServicos AS (
    -- CTE para calcular o total de mão de obra por OS
    SELECT
        idOS,
        SUM(s.valorMaoDeObra) AS ValorServicos
    FROM OS_Servico oss
    JOIN Servico s ON oss.idServico = s.idServico
    GROUP BY idOS
)
-- Consulta principal que junta tudo
SELECT
    os.idOS,
    os.dataEmissao,
    os.statusOS,
    c.nome AS NomeCliente,
    v.placa AS PlacaVeiculo,
    COALESCE(tp.ValorPecas, 0) AS ValorTotalPecas,
    COALESCE(ts.ValorServicos, 0) AS ValorTotalServicos,
    -- Atributo derivado final
    (COALESCE(tp.ValorPecas, 0) + COALESCE(ts.ValorServicos, 0)) AS ValorTotalOS
FROM
    Ordem_Servico os
JOIN Veiculo v ON os.idVeiculo = v.idVeiculo
JOIN Cliente c ON v.idCliente = c.idCliente
LEFT JOIN TotalPecas tp ON os.idOS = tp.idOS
LEFT JOIN TotalServicos ts ON os.idOS = ts.idOS
ORDER BY
    os.idOS;