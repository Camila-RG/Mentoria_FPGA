library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidade do multiplexador 4:1 com entradas de 8 bits.
entity mux_4_para_1 is
    Port ( 
        -- Entradas de dados de 8 bits
        entrada_0 : in  STD_LOGIC_VECTOR(7 downto 0);
        entrada_1 : in  STD_LOGIC_VECTOR(7 downto 0);
        entrada_2 : in  STD_LOGIC_VECTOR(7 downto 0);
        entrada_3 : in  STD_LOGIC_VECTOR(7 downto 0);
        
        -- Sinal de seleção de 2 bits
        sel       : in  STD_LOGIC_VECTOR(1 downto 0);
        
        -- Saída de 8 bits
        saida     : out STD_LOGIC_VECTOR(7 downto 0)
    );
end mux_4_para_1;

-- Arquitetura 1: Usando a estrutura CASE
architecture arch_case of mux_4_para_1 is
begin
    -- Um processo é sensível ao sinal de seleção e a todas as entradas de dados.
    process(sel, entrada_0, entrada_1, entrada_2, entrada_3)
    begin
        case sel is
            when "00" =>
                saida <= entrada_0;
            when "01" =>
                saida <= entrada_1;
            when "10" =>
                saida <= entrada_2;
            when "11" =>
                saida <= entrada_3;
            when others => -- Caso padrão para cobrir todos os outros possíveis valores de sel
                saida <= (others => 'X'); -- 'X' representa um valor desconhecido
        end case;
    end process;
end arch_case;

-- Arquitetura 2: Usando a estrutura IF-ELSIF
architecture arch_if_elsif of mux_4_para_1 is
begin
    process(sel, entrada_0, entrada_1, entrada_2, entrada_3)
    begin
        if sel = "00" then
            saida <= entrada_0;
        elsif sel = "01" then
            saida <= entrada_1;
        elsif sel = "10" then
            saida <= entrada_2;
        else -- Cobre o caso "11" e outros possíveis
            saida <= entrada_3;
        end if;
    end process;
end arch_if_elsif;

-- Arquitetura 3: Usando a atribuição condicional WHEN-ELSE
architecture arch_when_else of mux_4_para_1 is
begin
    saida <= entrada_0 when sel = "00" else
             entrada_1 when sel = "01" else
             entrada_2 when sel = "10" else
             entrada_3; -- O último 'else' cobre o caso "11" e outros
end arch_when_else;

-- Arquitetura 4: Usando a atribuição selecionada WITH-SELECT
architecture arch_with_select of mux_4_para_1 is
begin
    with sel select
        saida <= entrada_0 when "00",
                 entrada_1 when "01",
                 entrada_2 when "10",
                 entrada_3 when others; -- 'others' cobre "11" e qualquer outro valor
end arch_with_select;
