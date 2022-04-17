library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity MEM_AND_DIFF is
	
	port(				
		
		SEL1, SEL2, SEL3:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);
		Y: in STD_LOGIC_VECTOR(7 downto 0);
		W: out STD_LOGIC_VECTOR(7 downto 0);	
		POS:out STD_LOGIC_VECTOR(7 downto 0);
		CONDFIN:out STD_LOGIC
	);
	
end entity;	 

architecture MIXT of MEM_AND_DIFF is

component MUX212
	port(									
		SEL:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);
		Y: in STD_LOGIC_VECTOR(7 downto 0);
		W: out STD_LOGIC_VECTOR(7 downto 0)		
	);
end component;	

component CIRC_DIFF
	
	port(		
		X1: in STD_LOGIC_VECTOR(7 downto 0);
		Y1: in STD_LOGIC_VECTOR(7 downto 0);
		W1: out STD_LOGIC_VECTOR(7 downto 0)		
	);	

end component;	 

component MEM_SIMPLE					   				  
	
	port(									
		SEL:in STD_LOGIC;
		X: in STD_LOGIC_VECTOR(7 downto 0);	  
		W: inout STD_LOGIC_VECTOR(7 downto 0)		
	);

end component;
			 
component TEST_COND
  	port(
		X,Y,Z:in STD_LOGIC;
		A, B: in STD_LOGIC_VECTOR(7 downto 0);
		Q1, Q2, Q3:out STD_LOGIC
	);
	
end component;

signal AUX1:STD_LOGIC_VECTOR(7 downto 0);
signal AUX2:STD_LOGIC_VECTOR(7 downto 0);  
signal AUX3:STD_LOGIC_VECTOR(7 downto 0); 
signal AUX4:STD_LOGIC_VECTOR(7 downto 0);
signal AUX5:STD_LOGIC_VECTOR(7 downto 0); 
signal COND1, COND2, COND3: STD_LOGIC;

begin	
	
	C1: MUX212 port map(SEL1, X, AUX1, AUX2); 
	C2: MEM_SIMPLE port map(SEL2, AUX2, AUX3); 	 
	C3: CIRC_DIFF port map(AUX3, Y, AUX4);
	C4: MEM_SIMPLE port map(SEL3, AUX4, AUX1);
	C5: TEST_COND port map(SEL1, SEL2, SEL3, AUX3, Y, COND1, COND2, COND3);
	
	process(COND1, COND2)
	begin			  
		if(COND1='1')then
			AUX5<="00000000";
		end if;
		if(COND2='1')then
			AUX5<=AUX5+1;					   
		end if;
	end process; 
	
	POS<=AUX5;
	W<=AUX3;  
	CONDFIN<=COND3; 
	
end architecture;