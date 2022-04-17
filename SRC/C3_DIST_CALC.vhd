library	IEEE;
use ieee.std_logic_1164.all;	  
use ieee.numeric_std.all;

entity C3_DIST_CALC is
	
	port(					
		DIST:IN STD_LOGIC_VECTOR (7 downto 0);
		Q1: out STD_LOGIC_VECTOR (15 downto 0)		  
	);
	
end C3_DIST_CALC;			   

architecture MIXT of C3_DIST_CALC is

	component STD_M
		port(
			A	: in STD_LOGIC_VECTOR (7 downto 0);
			B	: in STD_LOGIC_VECTOR (7 downto 0);
			REZ	: out STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;

signal ZECE: STD_LOGIC_VECTOR(7 downto 0);
begin
	ZECE<="00001010"; 			   
	C1: STD_M port map(ZECE, DIST, Q1);
	
--	process(EN1)
--	begin
--		if(EN1='0')then
--			Q<="XXXXXXXXXXXXXXXX";
--		elsif EN1='1' and EN1'event then
--			Q<="1111111111111111";
--		end if;
--	end process;
--									   

end architecture;