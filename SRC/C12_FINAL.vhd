library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C12_FINAL is
	
	port(
		SEL:in STD_LOGIC_VECTOR(1 downto 0);	 	  
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);--BB 
		B1, B2, B3, B4, B5:in STD_LOGIC_VECTOR (7 downto 0);--REST
		D1, D2, D3, D4, D5:in STD_LOGIC_VECTOR (7 downto 0);--BD	 								  
		Q1, Q2, Q3, Q4, Q5:out STD_LOGIC_VECTOR(7 downto 0)
	);
	
end entity;	 

architecture MIXT of C12_FINAL is
begin
	
	process(SEL) 
	begin
		
		case SEL is
			
			when "00" =>  
				Q1<=A1;
				Q2<=A2;
				Q3<=A3;
				Q4<=A4;
				Q5<=A5;
			
			when "01" =>  
				Q1<=B1;
				Q2<=B2;
				Q3<=B3;
				Q4<=B4;
				Q5<=B5;
			
			when "10" => 
				Q1<=D1;
				Q2<=D2;
				Q3<=D3;
				Q4<=D4;
				Q5<=D5;
			
			when "11" => 
				Q1<="00000000";
				Q2<="00000000";
				Q3<="00000000";
				Q4<="00000000";
				Q5<="00000000";
			
			when others=>  
				Q1<="00000000";
				Q2<="00000000";
				Q3<="00000000";
				Q4<="00000000";
				Q5<="00000000";
			
		end case;
		
	end process;

end architecture;
