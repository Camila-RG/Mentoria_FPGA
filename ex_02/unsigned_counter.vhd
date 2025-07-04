-- Entidade para o contador de 8 bits com tipo UNSIGNED
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity unsigned_counter is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        count : out unsigned(7 downto 0) -- Saída do contador como um vetor de 8 bits UNSIGNED
    );
end entity unsigned_counter;

architecture behavioral of unsigned_counter is
    signal current_count : unsigned(7 downto 0) := (others => '0'); -- Sinal interno, inicializado com 0
begin

    process (clk, reset)
    begin
        if reset = '1' then
            current_count <= (others => '0'); -- Reseta o contador para 0
        elsif rising_edge(clk) then
            current_count <= current_count + 1; -- Incrementa o contador
        end if;
    end process;

    count <= current_count; -- Atribui o valor do sinal interno à porta de saída
end architecture behavioral;
