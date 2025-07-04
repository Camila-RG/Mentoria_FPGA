library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_tb is
end entity counter_tb;

architecture tb_arch of counter_tb is

    -- Declaração dos componentes que serão testados.

    component integer_counter
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            count : out integer range -128 to 127
        );
    end component;

    component signed_counter
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            count : out signed(7 downto 0)
        );
    end component;

    component unsigned_counter
        port (
            clk   : in  std_logic;
            reset : in  std_logic;
            count : out unsigned(7 downto 0)
        );
    end component;

    signal tb_clk   : std_logic := '0'; -- Sinal de clock, inicializado em '0'
    signal tb_reset : std_logic := '1'; -- Sinal de reset, inicializado em '1'

    -- Sinais para capturar as saídas de cada contador.
    signal tb_count_integer  : integer range -128 to 127;
    signal tb_count_signed   : signed(7 downto 0);
    signal tb_count_unsigned : unsigned(7 downto 0);

    -- Constante para definir o período do clock (ex: 10 ns = 100 MHz de frequência).
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instância para o contador INTEGER
    UUT_INTEGER : integer_counter
    port map (
        clk   => tb_clk,
        reset => tb_reset,
        count => tb_count_integer
    );

    -- Instância para o contador SIGNED
    UUT_SIGNED : signed_counter
    port map (
        clk   => tb_clk,
        reset => tb_reset,
        count => tb_count_signed
    );

    -- Instância para o contador UNSIGNED
    UUT_UNSIGNED : unsigned_counter
    port map (
        clk   => tb_clk,
        reset => tb_reset,
        count => tb_count_unsigned
    );

    -- Processo para Geração do Clock.
    clk_process : process
    begin
        loop
            tb_clk <= '0';
            wait for CLK_PERIOD / 2; -- Metade do período para '0'
            tb_clk <= '1';
            wait for CLK_PERIOD / 2; -- Metade do período para '1'
        end loop;
    end process clk_process;

    -- Processo para Geração de Estímulos.
    stimulus_process : process
    begin
        -- 1. Teste de Reset Inicial:
        report "--- Iniciando teste de reset ---" severity note;
        wait for CLK_PERIOD * 5;
        tb_reset <= '0';
        report "--- Reset desativado, contadores iniciando ---" severity note;

        -- 2. Contagem Contínua:
        wait for CLK_PERIOD * 300;

        report "--- Observando contagem prolongada ---" severity note;

        report "--- Teste de contadores concluído ---" severity note;

        -- Finaliza a simulação.
        wait;
    end process stimulus_process;

    monitor_integer_count : process(tb_count_integer)
    begin
        report "INTEGER_COUNT: " & integer'image(tb_count_integer) severity note;
    end process;

    monitor_signed_count : process(tb_count_signed)
    begin
        -- Converte o signed para um valor inteiro para exibição mais fácil.
        report "SIGNED_COUNT: " & integer'image(to_integer(tb_count_signed)) severity note;
    end process;

    monitor_unsigned_count : process(tb_count_unsigned)
    begin
        -- Converte o unsigned para um valor inteiro para exibição mais fácil.
        report "UNSIGNED_COUNT: " & integer'image(to_integer(tb_count_unsigned)) severity note;
    end process;

end architecture tb_arch;
