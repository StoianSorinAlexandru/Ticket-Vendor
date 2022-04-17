library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C8_FINAL is
	
	port(
		SEL: in STD_LOGIC_VECTOR(1 downto 0);	
		W	: in STD_LOGIC_VECTOR(11 downto 0);-- SEL = 00 AFISAM DIN MEMORIA DE BANI
		DIST: in STD_LOGIC_VECTOR(15 downto 0);-- SEL = 01 AFISAM DIN C3	
		TK  : in STD_LOGIC_VECTOR(7  downto 0);-- SEL = 10 AFISAM DIN C6	 
		
		X  : out STD_LOGIC_VECTOR(11 downto 0)
	);
	
end C8_FINAL;	

architecture MIXT of C8_FINAL is

begin
	
	process(SEL)
	begin
		
		case SEL is
			
		when "00"=>
			X<=W; 	
		
		when "01"=>
			X<=DIST(11 downto 0);
			
		when "10"=>
			X<= "0000" & Tk;
			
		when others =>
			X<= "000000000000";
		
		end case;
		
	end process;

end architecture;