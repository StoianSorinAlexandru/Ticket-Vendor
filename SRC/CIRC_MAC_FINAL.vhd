library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;

entity CIRC_MAC_FINAL is
	
	port(
	INC, DEC: in STD_LOGIC; 	 
	EN: in STD_LOGIC_VECTOR(1 downto 0); 
	PL: in STD_LOGIC_VECTOR(7 downto 0);  
	Q: inout STD_LOGIC_VECTOR(7 downto 0));
	
end CIRC_MAC_FINAL; 

architecture comportamentala of CIRC_MAC_FINAL is

begin
	
	process(EN, INC, DEC)
	variable BIST:STD_LOGIC_VECTOR(7 downto 0);
	begin
		if(EN = "00")then
			BIST:=Q;
		elsif (EN = "01") then 
			
			if(INC'event) and (INC='1') then 
				if(BIST=x"FF")then
					BIST:=Q; 
				else
					BIST:=BIST+1;  
				end if;
			end if;	
			if(DEC'event) and (DEC='1') then 
				if(BIST=x"00")then
					BIST:=Q;
				else
					BIST:=BIST-1;
				end if;
			end if;
			
		elsif(EN="10")then
			BIST:="00000000";
		elsif(EN="11")then
			BIST:=PL;
		else 
			BIST:=Q;
		
		end if;	 
		Q<=BIST;
	end process;
end architecture;