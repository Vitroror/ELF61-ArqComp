-- ELF61 -> ARQUITETURA E ORGANIZACAO DE COMPUTADORES --
-- UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
-- DEPARTAMENTO ACADEMICO DE ENGENHARIA ELETRONICA
-- O SEGUINTE CODIGO FOI DESENVOLVIDO PELOS ALUNOS:
-- ACYR EDUARDO MARCONATTO : 2358263
-- FABIO ZHAO YUAN WANG : 2358310
-- VICTOR AUGUSTO DEL MONEGO : 2378345

-- DISCLAIMER: O CODIGO A SEGUIR E BASEADO FORTEMENTE NO CODIGO "RAMDisp.vhd" fornecido pelo professor RAFAEL ELEODORO DE GOES


-- INICIO DO CODIGO

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
entity rom is
port( clk :       in std_logic;
	    endereco :  in unsigned(15 downto 0);
	    instr :     out unsigned(15 downto 0)
);
end entity;
------------------------------------------------------------------------
architecture a_rom of rom is
------------------------------------------------------------------------
	type mem is array (0 to 128) of unsigned(15 downto 0);
  constant conteudo_rom : mem := (
  --sejam duas constantes C1 e C2 (o valor nos 5 LSb de 1 e 2), entao
    1  => b"00100_110000_00110", --ADDI R4, C1;
    2  => b"00101_110000_01111", --ADDI R5, C2;
  --pseudo-cod para MUL R1, R4, R5
    3  => b"00001_000000_00101", --MOV R1, R5
    4  => b"00001_010001_00100", --MUL R1, R4
  --soma:
    5  => b"00010_001110_00101", --R2 <= R2 + R5;
    6  => b"00010_001010_11110", --BNE R2, soma;
    7  => b"00000_000011_00111", --JMP 7; (loop infinito)
    others => (others=>'0')
  );
------------------------------------------------------------------------
begin

process(clk)
	begin
		if(rising_edge(clk)) then
			instr <= conteudo_rom(to_integer(endereco));
		end if;
end process;

end architecture;

--FIM DO CODIGO
