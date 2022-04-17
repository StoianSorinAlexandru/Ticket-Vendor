library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity TEST_COND is
	
	port(
		X,Y,Z:in STD_LOGIC;
		A, B: in STD_LOGIC_VECTOR(7 downto 0);
		Q1, Q2, Q3:out STD_LOGIC
	);
	
end entity;	  

architecture MIXT of TEST_COND is

signal NX, NY, NZ, GRT: STD_LOGIC;
begin	   
	
NX<=not(X);	 
NY<=not(Y);
NZ<=not(Z);	

process(A, B)
begin
	if(A>B)then
		GRT<='1';
	elsif(A=B)then 
		GRT<='1';
	elsif (A<B) then
		GRT<='0';
	else GRT<='Z';
	end if;
end process;	

Q1<=NX and Y and NZ;	 
Q2<=X and Y and NZ and GRT;
Q3<= not(GRT);

end architecture;