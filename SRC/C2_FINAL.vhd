library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity C2_FINAL is
	
	port(  	 
		INC1, DEC1: in STD_LOGIC;		  
		SEL: in STD_LOGIC_VECTOR(4 downto 0);
			  
		PL1:in STD_LOGIC_VECTOR(7 downto 0); 
		PL2:in STD_LOGIC_VECTOR(7 downto 0); 
		PL3:in STD_LOGIC_VECTOR(7 downto 0); 
		PL4:in STD_LOGIC_VECTOR(7 downto 0); 
		PL5:in STD_LOGIC_VECTOR(7 downto 0);
		
		Q1:inout STD_LOGIC_VECTOR(7 downto 0); 
		Q2:inout STD_LOGIC_VECTOR(7 downto 0);
		Q3:inout STD_LOGIC_VECTOR(7 downto 0);
		Q4:inout STD_LOGIC_VECTOR(7 downto 0);
		Q5:inout STD_LOGIC_VECTOR(7 downto 0)
	);
end C2_FINAL;				  

architecture MIXT of C2_FINAL is

	component CIRC_MAC_FINAL 
	
	port(
		INC, DEC: in STD_LOGIC; 	 
		EN: in STD_LOGIC_VECTOR(1 downto 0); 
		PL: in STD_LOGIC_VECTOR(7 downto 0);  
		Q: inout STD_LOGIC_VECTOR(7 downto 0)
	);
	
		
	end component;
	
signal I1, I2, I3, I4, I5, D1, D2, D3, D4, D5: STD_LOGIC; 
signal EN1, EN2, EN3, EN4, EN5: STD_LOGIC_VECTOR(1 downto 0);
begin
	 	   
	C1: CIRC_MAC_FINAL port map(I1, D1, EN1, PL1, Q1);	
	C2: CIRC_MAC_FINAL port map(I2, D2, EN2, PL2, Q2); 
	C3: CIRC_MAC_FINAL port map(I3, D3, EN3, PL3, Q3);	
	C4: CIRC_MAC_FINAL port map(I4, D4, EN4, PL4, Q4);					   
	C5: CIRC_MAC_FINAL port map(I5, D5, EN5, PL5, Q5);
	  
  	process(INC1, DEC1, SEL)
	
	begin
		
		case SEL is
			
		when "00001" =>	 
			I1<=INC1;
			D1<=DEC1;  
			
			EN1<="01";  
			EN2<="00"; 
			EN3<="00"; 
			EN4<="00"; 
			EN5<="00";
			
		when "00010" =>	 
			I2<=INC1;
			D2<=DEC1; 
			
			EN1<="00";  
			EN2<="01"; 
			EN3<="00"; 
			EN4<="00"; 
			EN5<="00";
			
		when "00100" =>	  
			I3<=INC1;
			D3<=DEC1; 
			
			EN1<="00";  
			EN2<="00"; 
			EN3<="01"; 
			EN4<="00"; 
			EN5<="00";
			
		when "01000" =>	 
			I4<=INC1;
			D4<=DEC1;  
			
			EN1<="00";  
			EN2<="00"; 
			EN3<="00"; 
			EN4<="01"; 
			EN5<="00"; 
			
		when "10000" =>		 	
			I5<=INC1;
			D5<=DEC1; 
			
			
			EN1<="00";  
			EN2<="00"; 
			EN3<="00"; 
			EN4<="00"; 
			EN5<="01";	
			
		when "10101" =>		 	  
			
			EN1<="11";  
			EN2<="11"; 
			EN3<="11"; 
			EN4<="11"; 
			EN5<="11";
			
		when "11111"=> 
		
			EN1<="10";  
			EN2<="10"; 
			EN3<="10"; 
			EN4<="10"; 
			EN5<="10";	
			
		when others	=>	 
			EN1<="00";  
			EN2<="00"; 
			EN3<="00"; 
			EN4<="00"; 
			EN5<="00";
		end case;
	end process;
													 
end architecture;