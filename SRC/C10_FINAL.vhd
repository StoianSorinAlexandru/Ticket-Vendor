library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C10_FINAL is
	
	port(
		SEL: in STD_LOGIC_VECTOR(1 downto 0);
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DE BAGAT IN MEMORIE
		B1, B2, B3, B4, B5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DE SCOS DIN MEMORIE
		C1, C2, C3, C4, C5:in STD_LOGIC_VECTOR (7 downto 0);---BANI DEJA IN MEMORIE  
		Q1, Q2, Q3, Q4, Q5: out STD_LOGIC_VECTOR(7 downto 0)
	);
	
end C10_FINAL;	 

architecture MIXT of C10_FINAL is


begin

	process(SEL)
	begin
		
		case SEL is
			
			when "01" =>  
				Q1<=C1+A1-B1; 
				Q2<=C2+A2-B2;  
				Q3<=C3+A3-B3;
				Q4<=C4+A4-B4;  
				Q5<=C5+A5-B5;
			
			when others =>
				Q1<=C1;
				Q2<=C2;
				Q3<=C3;
				Q4<=C4;
				Q5<=C5;
			
		end case;
		
	end process;
	
end architecture;
