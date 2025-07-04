library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.tipos_pacote.all;

entity multiplicador_pares is
    Port ( 
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        en      : in  STD_LOGIC;
        entradas : in  t_integer_array(0 to 7);
        saidas   : out t_integer_array(0 to 3);
        pronto   : out STD_LOGIC
    );
end multiplicador_pares;

-- Arquitetura Paralela
architecture VersaoA of multiplicador_pares is
    signal s_saidas_reg : t_integer_array(0 to 3);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            s_saidas_reg <= (others => 0);
            pronto <= '0';
        elsif rising_edge(clk) then
            s_saidas_reg(0) <= entradas(0) * entradas(1);
            s_saidas_reg(1) <= entradas(2) * entradas(3);
            s_saidas_reg(2) <= entradas(4) * entradas(5);
            s_saidas_reg(3) <= entradas(6) * entradas(7);
            pronto <= '1';
        end if;
    end process;
    saidas <= s_saidas_reg;
end VersaoA;

-- Arquitetura Sequencial
architecture VersaoB of multiplicador_pares is
    type t_estado is (IDLE, COMPUTE, DONE);
    signal estado : t_estado;
    signal contador_ciclos : integer range 0 to 3;
    signal s_saidas_reg : t_integer_array(0 to 3);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            estado <= IDLE;
            contador_ciclos <= 0;
            s_saidas_reg <= (others => 0);
            pronto <= '0';
        elsif rising_edge(clk) then
            case estado is
                when IDLE =>
                    pronto <= '0';
                    if en = '1' then
                        estado <= COMPUTE;
                        contador_ciclos <= 0;
                    end if;
                when COMPUTE =>
                    pronto <= '0';
                    case contador_ciclos is
                        when 0 => s_saidas_reg(0) <= entradas(0) * entradas(1);
                        when 1 => s_saidas_reg(1) <= entradas(2) * entradas(3);
                        when 2 => s_saidas_reg(2) <= entradas(4) * entradas(5);
                        when 3 => s_saidas_reg(3) <= entradas(6) * entradas(7);
                    end case;
                    if contador_ciclos = 3 then
                        estado <= DONE;
                    else
                        contador_ciclos <= contador_ciclos + 1;
                    end if;
                when DONE =>
                    pronto <= '1';
                    if en = '0' then
                        estado <= IDLE;
                    end if;
            end case;
        end if;
    end process;
    saidas <= s_saidas_reg;
end VersaoB;
