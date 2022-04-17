library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity CIRC_UE_REST_CALC is
	
	port(
	
		EN, CLK: in STD_LOGIC;
		X: in STD_LOGIC_VECTOR (7 downto 0);					  
		BD1, BD2, BD3, BD4, BD5: in STD_LOGIC_VECTOR(7 downto 0); 
		SEL1, SEL2, SEL3, SEL4, SEL5: in STD_LOGIC;
		
		W:out STD_LOGIC_VECTOR (7 downto 0);
		POS1, POS2, POS3, POS4, POS5: out STD_LOGIC_VECTOR (7 downto 0);  
		CF1, CF2, CF3, CF4, CF5: out STD_LOGIC;
		
		OK:out STD_LOGIC
	
	);
	
end entity;		 

architecture MIXT of CIRC_UE_REST_CALC is

component TEST_REST_CALC
	 port(									
		EN, CLK:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);	   
		BD: in STD_LOGIC_VECTOR(7 downto 0);
		D: in STD_LOGIC_VECTOR(7 downto 0);
		W: out STD_LOGIC_VECTOR(7 downto 0);
		POS: out STD_LOGIC_VECTOR(7 downto 0);
		OK:out STD_LOGIC
	);
end component;

signal AUX1, AUX2, AUX3, AUX4: STD_LOGIC_VECTOR (7 downto 0); 
signal D1, D2, D3, D4, D5: STD_LOGIC_VECTOR(7 downto 0);
begin
	
	D5<="00110010";
	D4<="00001010";
	D3<="00000101";
	D2<="00000010";
	D1<="00000001";
	
	C1: TEST_REST_CALC port map(SEL1, CLK, X   , BD5, D5, AUX1, POS1, CF1);
	C2: TEST_REST_CALC port map(SEL2, CLK, AUX1, BD4, D4, AUX2, POS2, CF2);
	C3: TEST_REST_CALC port map(SEL3, CLK, AUX2, BD3, D3, AUX3, POS3, CF3);
	C4: TEST_REST_CALC port map(SEL4, CLK, AUX3, BD2, D2, AUX4, POS4, CF4);
	C5: TEST_REST_CALC port map(SEL5, CLK, AUX4, BD1, D1, W	 , POS5, CF5);
	
end architecture;