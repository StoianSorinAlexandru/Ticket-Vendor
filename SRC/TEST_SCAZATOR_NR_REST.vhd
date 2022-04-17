library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity TEST_REST_CALC is
	
	port(									
		EN, CLK:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);	 
		BD: in STD_LOGIC_VECTOR(7 downto 0);
		D: in STD_LOGIC_VECTOR(7 downto 0);	
		W: out STD_LOGIC_VECTOR(7 downto 0);
		POS: out STD_LOGIC_VECTOR(7 downto 0); 	
		OK:out STD_LOGIC
	);
	
end entity;	 													   


architecture MIXT of TEST_REST_CALC is  

component MEM_AND_DIFF
	
	port(									
		SEL1, SEL2, SEL3:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);
		Y: in STD_LOGIC_VECTOR(7 downto 0);
		W: out STD_LOGIC_VECTOR(7 downto 0);	
		POS:out STD_LOGIC_VECTOR(7 downto 0);
		CONDFIN:out STD_LOGIC		
	);
	
end component;

signal STARE, NXSTARE: STD_LOGIC_VECTOR(1 downto 0); 
signal SEL1, SEL2, SEL3, CONDFIN, M: STD_LOGIC;	 
signal MONEY: STD_LOGIC_VECTOR(7 downto 0);
begin
	
	C1:MEM_AND_DIFF port map(SEL1,SEL2,SEL3,X,D,W,POS,CONDFIN); 
	
	ACTUALIZARE_STARE: process(EN, CLK)
	begin	   
		if(EN='1')then
			STARE<="00";
		elsif CLK'EVENT and CLK	='1'then
			STARE<=NXSTARE;
		end if;
		
	end process;	
	
	IDENTIFICARE_STARE: process(STARE, CONDFIN)
	begin							   
		
		case STARE is
			when "00" =>	
				MONEY<=BD;
				if(X="00000000" or BD="00000000")then
					NXSTARE<="10";
				end if;
					NXSTARE<="01";
					SEL1<='0';
					SEL2<='1';
					SEL3<='0';	
						  
			when "01" =>  	 	 
				if(MONEY="00000000")then   
					NXSTARE <= "10"; 
				else
					NXSTARE<="11";
					SEL1<='1';
					SEL2<='0';
					SEL3<='1';	
				end if;	
			when "11" =>  
				SEL1<='1';
				SEL2<='1';
				SEL3<='0';	
				MONEY<=MONEY-1;
				
				if(CONDFIN = '0')then
					NXSTARE <= "01";
				else
					NXSTARE <= "10";   
				end if;	   
				if(MONEY="00000000")then   
					NXSTARE <= "10"; 
				end if;
			when "10" => 
				OK<='1';	   
			when others =>
		end case;  
		
		if(CONDFIN='1')then NXSTARE<="10";
		end if;
	end process;
end architecture;