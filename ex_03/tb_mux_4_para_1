library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_4_para_1 is
end tb_mux_4_para_1;

architecture Behavioral of tb_mux_4_para_1 is
    -- Declaração do componente a ser testado
    component mux_4_para_1
        Port ( 
            entrada_0 : in  STD_LOGIC_VECTOR(7 downto 0);
            entrada_1 : in  STD_LOGIC_VECTOR(7 downto 0);
            entrada_2 : in  STD_LOGIC_VECTOR(7 downto 0);
            entrada_3 : in  STD_LOGIC_VECTOR(7 downto 0);
            sel       : in  STD_LOGIC_VECTOR(1 downto 0);
            saida     : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Sinais de estímulo para as entradas
    signal s_in_0, s_in_1, s_in_2, s_in_3 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal s_sel : STD_LOGIC_VECTOR(1 downto 0) := "00";

    -- Sinais para observar as saídas de cada arquitetura
    signal s_out_case, s_out_if, s_out_when, s_out_with : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instanciação 1: Testando a arquitetura 'arch_case'
    UUT_case: entity work.mux_4_para_1(arch_case)
        port map (
            entrada_0 => s_in_0, entrada_1 => s_in_1,
            entrada_2 => s_in_2, entrada_3 => s_in_3,
            sel       => s_sel,
            saida     => s_out_case
        );

    -- Instanciação 2: Testando a arquitetura 'arch_if_elsif'
    UUT_if: entity work.mux_4_para_1(arch_if_elsif)
        port map (
            entrada_0 => s_in_0, entrada_1 => s_in_1,
            entrada_2 => s_in_2, entrada_3 => s_in_3,
            sel       => s_sel,
            saida     => s_out_if
        );
        
    -- Instanciação 3: Testando a arquitetura 'arch_when_else'
    UUT_when: entity work.mux_4_para_1(arch_when_else)
        port map (
            entrada_0 => s_in_0, entrada_1 => s_in_1,
            entrada_2 => s_in_2, entrada_3 => s_in_3,
            sel       => s_sel,
            saida     => s_out_when
        );
        
    -- Instanciação 4: Testando a arquitetura 'arch_with_select'
    UUT_with: entity work.mux_4_para_1(arch_with_select)
        port map (
            entrada_0 => s_in_0, entrada_1 => s_in_1,
            entrada_2 => s_in_2, entrada_3 => s_in_3,
            sel       => s_sel,
            saida     => s_out_with
        );

    -- Processo de estímulo para variar as entradas e o seletor
    stimulus_process: process
    begin
        report "Inicio da simulacao do MUX 4:1.";
        
        -- Atribui valores distintos para cada entrada
        s_in_0 <= x"AA"; -- 10101010
        s_in_1 <= x"BB"; -- 10111011
        s_in_2 <= x"CC"; -- 11001100
        s_in_3 <= x"DD"; -- 11011101
        
        -- Testa cada valor do seletor
        report "Testando sel = 00";
        s_sel <= "00";
        wait for 10 ns;
        assert (s_out_case = s_in_0) report "Falha na saida do CASE para sel=00" severity error;
        assert (s_out_if = s_in_0) report "Falha na saida do IF para sel=00" severity error;
        assert (s_out_when = s_in_0) report "Falha na saida do WHEN para sel=00" severity error;
        assert (s_out_with = s_in_0) report "Falha na saida do WITH para sel=00" severity error;

        report "Testando sel = 01";
        s_sel <= "01";
        wait for 10 ns;
        assert (s_out_case = s_in_1) report "Falha na saida do CASE para sel=01" severity error;
        -- Adicione asserts para as outras saídas também

        report "Testando sel = 10";
        s_sel <= "10";
        wait for 10 ns;
        assert (s_out_case = s_in_2) report "Falha na saida do CASE para sel=10" severity error;
        
        report "Testando sel = 11";
        s_sel <= "11";
        wait for 10 ns;
        assert (s_out_case = s_in_3) report "Falha na saida do CASE para sel=11" severity error;
        
        report "Simulacao finalizada.";
        wait;
    end process;

end Behavioral;
