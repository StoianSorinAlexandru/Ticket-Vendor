library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	
use ieee.std_logic_UNSIGNED.all;
											 
entity TEST_CIRC_SUM_FROM_MEM is
	
	port
	(
	
		A1, A2, A3, A4, A5: in STD_LOGIC_VECTOR(7 downto 0);
	
		SUM: out STD_LOGIC_VECTOR(7 downto 0)
	
	);
	
end entity;


architecture MIXT of TEST_CIRC_SUM_FROM_MEM is

component TEST_CIRC_SUM5
	
	port
	(
	
		A1, A2, A3, A4, A5: in STD_LOGIC_VECTOR(7 downto 0);
	
		SUM: out STD_LOGIC_VECTOR(7 downto 0)
	
	);
	
end component;

component TEST_CIRC_MULTIPLIER
	 port(
	
		X1, X2: in STD_LOGIC_VECTOR(7 downto 0);
	
		W: out STD_LOGIC_VECTOR(7 downto 0)
		
	);
end component;

signal AUX1, AUX2, AUX3, AUX4: STD_LOGIC_VECTOR(7 downto 0);

begin  
	
	C1: TEST_CIRC_MULTIPLIER port map(A1, "00110010", AUX1);--50	
	C2: TEST_CIRC_MULTIPLIER port map(A2, "00001010", AUX2);--10
	C3: TEST_CIRC_MULTIPLIER port map(A3, "00000101", AUX3);--5
	C4: TEST_CIRC_MULTIPLIER port map(A4, "00000010", AUX4);--2   
	
	C5: TEST_CIRC_SUM5 port map(AUX1, AUX2, AUX3, AUX4, A5, SUM);

end architecture;