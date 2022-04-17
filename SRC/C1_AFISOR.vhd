library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	   

entity C1_AFIS is
	
port
(
	EN1, CLK1: in STD_LOGIC;
	DATA_IN: in STD_LOGIC_VECTOR(0 to 11);
	CATOD1: out STD_LOGIC_VECTOR(0 to 6);
	ANOD1: out STD_LOGIC_VECTOR(0 to 3)
);
	
end entity;			

architecture MIXT of C1_AFIS is

	component DEC_12B_4I
		port(D:in STD_LOGIC_VECTOR(0 to 11);
		NRU, NRZ, NRS, NRM: out STD_LOGIC_VECTOR(0 to 6));
	end component;
	
	component AFIS_UE
		port(CLK, EN: in STD_LOGIC;
		NRU, NRZ, NRS, NRM: in STD_LOGIC_VECTOR(0 to 6);
		ANOD: out STD_LOGIC_VECTOR(0 to 3);
		CATOD: out STD_LOGIC_VECTOR(0 to 6));
	end component;
	
	signal NRU1, NRZ1, NRS1, NRM1: STD_LOGIC_VECTOR(0 to 6);
	begin	

		C1: DEC_12B_4I port map(DATA_IN, NRU1, NRZ1, NRS1, NRM1);			
		C2: AFIS_UE port map(CLK1, EN1, NRU1, NRZ1, NRS1, NRM1, ANOD1, CATOD1);
	
end architecture;					

--entity DEC_12B_4I is
	
	--port(
	--D:in STD_LOGIC_VECTOR(0 to 11);
	--NRU, NRZ, NRS, NRM: out STD_LOGIC_VECTOR(0 to 6));
	
--end DEC_12B_4I;