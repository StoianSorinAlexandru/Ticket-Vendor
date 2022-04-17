library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	    
use ieee.numeric_std.all;   

entity C11_ALU_SUM is
	
	port(
		EN: in STD_LOGIC;
		A1, A2, A3, A4, A5:in STD_LOGIC_VECTOR (7 downto 0);  	 
		Q:out STD_LOGIC_VECTOR(11 downto 0)
	);
	
end C11_ALU_SUM;	  

architecture MIXT of C11_ALU_SUM is

component STD_M
	port(
		A	: in STD_LOGIC_VECTOR (7 downto 0);
		B	: in STD_LOGIC_VECTOR (7 downto 0);
		REZ	: out STD_LOGIC_VECTOR (15 downto 0)
	);
end component;

component SUM1	 
	port(
		X1: in STD_LOGIC_VECTOR(15 downto 0);
		Y1: in STD_LOGIC_VECTOR(11 downto 0);
		W1: out STD_LOGIC_VECTOR(11 downto 0)
	);
end component; 

signal D1: STD_LOGIC_VECTOR(7 downto 0);	
signal D2: STD_LOGIC_VECTOR(7 downto 0);	
signal D3: STD_LOGIC_VECTOR(7 downto 0);	 
signal D4: STD_LOGIC_VECTOR(7 downto 0);	
signal D5: STD_LOGIC_VECTOR(7 downto 0);	  
signal AUX1: STD_LOGIC_VECTOR(15 downto 0);	
signal AUX2: STD_LOGIC_VECTOR(15 downto 0);	
signal AUX3: STD_LOGIC_VECTOR(15 downto 0);	 
signal AUX4: STD_LOGIC_VECTOR(15 downto 0);	
signal AUX5: STD_LOGIC_VECTOR(15 downto 0);	
signal AUX6: STD_LOGIC_VECTOR(11 downto 0);	 
signal AUX7: STD_LOGIC_VECTOR(11 downto 0);		 
signal AUX8: STD_LOGIC_VECTOR(11 downto 0);	 
signal AUX9: STD_LOGIC_VECTOR(11 downto 0);		 
signal AUXA: STD_LOGIC_VECTOR(11 downto 0);	 

begin								   
	AUX6<="000000000000"; 		  
	
	D1<="00000001";
	D2<="00000010";	
	D3<="00000101";	 
	D4<="00001010";
	D5<="00110010";			  		 		 		 		  
	
	C1: STD_M port map(D1, A1, AUX1); 		   
	C2: SUM1  port map(AUX1, AUX6, AUX7);
	
	C3: STD_M port map(D2, A2, AUX2);     
	C4: SUM1  port map(AUX2, AUX7, AUX8);
	
	C5: STD_M port map(D3, A3, AUX3);	
	C6: SUM1  port map(AUX3, AUX8, AUX9); 
	
	C7: STD_M port map(D4, A4, AUX4); 
	C8: SUM1  port map(AUX4, AUX9, AUXA); 
	
	C9: STD_M port map(D5, A5, AUX5); 
	CA: SUM1  port map(AUX5, AUXA, Q);	 
	
end architecture;