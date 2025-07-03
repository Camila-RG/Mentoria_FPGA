library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do circuito 
entity exercicio1 is
    Port ( 
        a : in  STD_LOGIC;         -- Sinal de controle da direção 
        b : inout STD_LOGIC;       -- Sinal bidirecional 
        c : inout STD_LOGIC;       -- Sinal bidirecional 
        d : out STD_LOGIC          -- Saída lógica 
    );
end exercicio1;

-- Arquitetura do circuito 
architecture Behavioral of exercicio1 is
begin

    -- Implementação dos buffers 3-state 
    -- Se a = '0', o valor de 'c' deve ser passado para 'b'.
    -- Para isso, 'b' atua como saída, recebendo o valor de 'c'.
    -- Quando 'a' não for '0', o buffer que direciona para 'b' fica em alta impedância ('Z').
    b <= c when a = '0' else 'Z';

    -- Se a = '1', o valor de 'b' deve ser passado para 'c'.
    -- 'c' atua como saída, recebendo o valor de 'b'.
    -- Quando 'a' não for '1', o buffer que direciona para 'c' fica em alta impedância ('Z').
    c <= b when a = '1' else 'Z';

    -- A saída 'd' deve ser sempre o inverso do sinal presente em 'c'. 
    d <= not c;

end Behavioral;
