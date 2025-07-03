library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_exercicio1 is
-- Entidade vazia, pois é um testbench
end tb_exercicio1;

architecture Behavioral of tb_exercicio1 is

    -- Declaração do componente a ser testado
    component exercicio1
        Port ( 
            a : in  STD_LOGIC;
            b : inout STD_LOGIC;
            c : inout STD_LOGIC;
            d : out STD_LOGIC
        );
    end component;

    -- Sinais para conectar ao componente
    signal s_a : STD_LOGIC := '0';
    signal s_b : STD_LOGIC;
    signal s_c : STD_LOGIC;
    signal s_d : STD_LOGIC;

begin

    -- Instanciação do componente (DUT)
    uut: exercicio1
        Port Map (
            a => s_a,
            b => s_b,
            c => s_c,
            d => s_d
        );

    -- Processo de estímulo para simulação
    stimulus_process: process
    begin
        report "Inicio da simulacao do Exercicio 1.";

        -- ----------------------------------------------------
        -- Teste 1: Modo a = '0' (c -> b)
        -- ----------------------------------------------------
        report "Teste 1: a = '0'. O valor de c deve ser passado para b.";
        s_a <= '0';
        s_b <= 'Z'; -- Coloca 'b' em alta impedância para receber dados de 'c'

        -- Força c = '1'
        s_c <= '1';
        wait for 10 ns;
        -- Verificação esperada: s_b deve ser '1', s_d deve ser '0'
        assert (s_b = '1') report "Falha no Teste 1a: b deveria ser 1" severity error;
        assert (s_d = '0') report "Falha no Teste 1a: d deveria ser 0" severity error;

        -- Força c = '0'
        s_c <= '0';
        wait for 10 ns;
        -- Verificação esperada: s_b deve ser '0', s_d deve ser '1'
        assert (s_b = '0') report "Falha no Teste 1b: b deveria ser 0" severity error;
        assert (s_d = '1') report "Falha no Teste 1b: d deveria ser 1" severity error;

        report "Teste 1 concluido com sucesso.";
        wait for 20 ns;

        -- ----------------------------------------------------
        -- Teste 2: Modo a = '1' (b -> c)
        -- ----------------------------------------------------
        report "Teste 2: a = '1'. O valor de b deve ser passado para c.";
        s_a <= '1';
        s_c <= 'Z'; -- Coloca 'c' em alta impedância para receber dados de 'b'

        -- Força b = '1'
        s_b <= '1';
        wait for 10 ns;
        -- Verificação esperada: s_c deve ser '1', s_d deve ser '0'
        assert (s_c = '1') report "Falha no Teste 2a: c deveria ser 1" severity error;
        assert (s_d = '0') report "Falha no Teste 2a: d deveria ser 0" severity error;

        -- Força b = '0'
        s_b <= '0';
        wait for 10 ns;
        -- Verificação esperada: s_c deve ser '0', s_d deve ser '1'
        assert (s_c = '0') report "Falha no Teste 2b: c deveria ser 0" severity error;
        assert (s_d = '1') report "Falha no Teste 2b: d deveria ser 1" severity error;
        
        report "Teste 2 concluido com sucesso.";
        report "Simulacao finalizada.";

        wait; -- Fim da simulação
    end process;

end Behavioral;
