library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity DEBOUNCER IS	
	
	generic(
	    CLK_FREQ    : INTEGER := 450000000; 
	    ST : INTEGER := 10
	);	
	
	port(	
	    CLK     : in  STD_LOGIC;
	    RST 	: in  STD_LOGIC;  
	    BT  	: in STD_LOGIC;  
	    REZ  	: out STD_LOGIC
	);	   
	
end entity;

architecture MIXT of DEBOUNCER is

signal REG     : STD_LOGIC_VECTOR(1 DOWNTO 0);
signal CNT_SET : STD_LOGIC;                  
BEGIN

  CNT_SET <= REG(0) xor REG(1);
  
  process(CLK, RST)
  variable CNT :  integer range 0 to CLK_FREQ*ST/1000;
  begin
    if(RST='0') then      
    	REG<="00";           
    	REZ <= '0';                           
    elsif(CLK'EVENT and CLK = '1')then
    	REG(0) <= BT;                      
    	REG(1) <= REG(0);                
    	if(CNT_SET = '1') then                    
        	CNT := 0;                               
    	elsif(CNT < CLK_FREQ*ST/1000) then 
        	CNT := CNT + 1;                     
      	else                                       
        	REZ <= REG(1);         
      	end if;    
  	end if;
  end process;
  
end architecture;
