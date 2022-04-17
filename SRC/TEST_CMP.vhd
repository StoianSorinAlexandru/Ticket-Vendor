library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	

entity TEST_CMP is
	
	port
	(
	
	A, B:in STD_LOGIC_VECTOR(7 downto 0);
	
	QL, QE, QG: out STD_LOGIC
	
	);
	
end entity;					 

architecture MIXT of TEST_CMP is

begin
	
	process (A, B)
	begin
		if(A>B)then
			QG<='1';
			QL<='0';
			QE<='0';
		elsif A=B then
			QG<='0';
			QL<='0';
			QE<='1';
		else
			QG<='0';
			QL<='1';
			QE<='0';
					 
		end if;
	end process;

end architecture;