library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tipos_pacote.all;

entity tb_multiplicador_pares is
end tb_multiplicador_pares;

architecture Behavioral of tb_multiplicador_pares is
    component multiplicador_pares
        Port ( 
            clk      : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            en       : in  STD_LOGIC;
            entradas : in  t_integer_array(0 to 7);
            saidas   : out t_integer_array(0 to 3);
            pronto   : out STD_LOGIC
        );
    end component;

    signal s_clk, s_rst, s_en, s_pronto_p, s_pronto_s : STD_LOGIC := '0';
    signal s_entradas : t_integer_array(0 to 7);
    signal s_saidas_p, s_saidas_s : t_integer_array(0 to 3);

    constant CLK_PERIOD : time := 10 ns;
begin
    -- Instanciação da VersaoA (Paralela)
    UUT_Paralela: entity work.multiplicador_pares(VersaoA)
        port map (
            clk => s_clk, rst => s_rst, en => s_en,
            entradas => s_entradas,
            saidas => s_saidas_p,
            pronto => s_pronto_p
        );
        
    -- Instanciação da VersaoB (Sequencial)
    UUT_Sequencial: entity work.multiplicador_pares(VersaoB)
        port map (
            clk => s_clk, rst => s_rst, en => s_en,
            entradas => s_entradas,
            saidas => s_saidas_s,
            pronto => s_pronto_s
        );

    clk_process: process
    begin
        s_clk <= '0';
        wait for CLK_PERIOD / 2;
        s_clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    stimulus_process: process
    begin
        report "Inicio da simulacao do Exercicio 4.";
        
        s_rst <= '1';
        s_en <= '0';
        s_entradas <= (others => 0);
        wait for CLK_PERIOD * 2;
        s_rst <= '0';
        wait for CLK_PERIOD;
        
        report "Teste 1: Aplicando primeiro conjunto de entradas.";
        s_entradas <= (10, 2, 5, 4, 3, 6, 7, 8);
        s_en <= '1';
        wait for CLK_PERIOD;
        s_en <= '0';
        
        wait until s_pronto_s = '1';
        
        assert s_saidas_p(0) = 20 and s_saidas_s(0) = 20 report "Falha no resultado 0" severity error;
        assert s_saidas_p(1) = 20 and s_saidas_s(1) = 20 report "Falha no resultado 1" severity error;
        assert s_saidas_p(2) = 18 and s_saidas_s(2) = 18 report "Falha no resultado 2" severity error;
        assert s_saidas_p(3) = 56 and s_saidas_s(3) = 56 report "Falha no resultado 3" severity error;

        report "Teste 1 Concluido com Sucesso!";
        
        wait for CLK_PERIOD * 5;
        
        report "Simulacao Finalizada.";
        wait;
    end process;
end Behavioral;
