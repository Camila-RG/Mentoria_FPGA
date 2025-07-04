-- Entidade para o contador de 8 bits com tipo INTEGER
library ieee;
use ieee.std_logic_1164.all;

entity integer_counter is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        count : out integer range -128 to 127 -- Saída do contador com o range especificado
    );
end entity integer_counter;

architecture behavioral of integer_counter is
    signal current_count : integer range -128 to 127 := 0; -- Sinal interno para a contagem
begin

    process (clk, reset)
    begin
        if reset = '1' then
            current_count <= 0; -- Reseta o contador para 0
        elsif rising_edge(clk) then
            -- Incrementa o contador, com tratamento para overflow/underflow se necessário
            if current_count = 127 then
                current_count <= -128; -- Volta ao mínimo após atingir o máximo
            else
                current_count <= current_count + 1;
            end if;
        end if;
    end process;

    count <= current_count; -- Atribui o valor do sinal interno à porta de saída
end architecture behavioral;
