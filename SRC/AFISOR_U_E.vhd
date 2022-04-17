library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity AFIS_UE is
	
	port(												   									  
	CLK, EN: in STD_LOGIC;
	NRU, NRZ, NRS, NRM: in STD_LOGIC_VECTOR(0 to 6);
	ANOD: out STD_LOGIC_VECTOR(0 to 3);
	CATOD: out STD_LOGIC_VECTOR(0 to 6));
	
end AFIS_UE;

architecture comportamentala of AFIS_UE is

signal CLK_ANOD: STD_LOGIC;
signal CLK_DIV_FREQ: STD_LOGIC_VECTOR(7 downto 0);

begin						 
	process (EN, CLK)	 
	variable i: integer:=3;
	begin	
		if(EN = '1') then
			CLK_DIV_FREQ <= "00000000";	   	 
		elsif EN = '0' then
			ANOD <= x"F";
			CATOD <= "0000000";
		end if;
		
		if(EN='1')then
			if(rising_edge(CLK))then
				if(i=3) then
						ANOD<="0111";
						CATOD<=NRM;
						i:=2;
					elsif(i=2) then
						ANOD<="1011";
						CATOD<=NRS;
						i:=1;
					elsif(i=1) then
		 				ANOD<="1101";
						CATOD<=NRZ;
						i:=0;
					else
						ANOD<="1110";
						CATOD<=NRU;
						i:=3;
				end if;
			end if;
		end if;
		
	end process;			  	  
 
	
end architecture;