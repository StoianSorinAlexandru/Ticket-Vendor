library	IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_UNSIGNED.all;	 

entity UC_TONOMAT_BILETE_V1 is 
	
	port(
		SEL: in STD_LOGIC_VECTOR(4 downto 0);
		OK:  in STD_LOGIC;
		NOK: in STD_LOGIC;
		INC: in STD_LOGIC;
		DEC: in STD_LOGIC;	 
		SHUT_DOWN: in STD_LOGIC;
		CLK: in STD_LOGIC;
		
		REST_POS: in STD_LOGIC;
		OK_6: in STD_LOGIC;
		OK_4: in STD_LOGIC;
		
		CLK_O: out STD_LOGIC;
		INC_O: out STD_LOGIC;
		DEC_O: out STD_LOGIC; 
		ERR_T: out STD_LOGIC;
		ERR_R: out STD_LOGIC; 
		
		INT_M: out STD_LOGIC;
		INT_T: out STD_LOGIC; 
		INT_D: out STD_LOGIC; 
		
		UTILIZ: out STD_LOGIC;	
		ADMIN: out STD_LOGIC;
		ELIB_REST: out STD_LOGIC;
		ELIB_BIL: out STD_LOGIC;
		
		
		EN_2, EN_4, EN_6, EN_7, SEL_8, EN_9, EN_10, SEL_12:out STD_LOGIC_VECTOR(1 downto 0);
		SEL_2, SEL_9:out STD_LOGIC_VECTOR(4 downto 0) 
	);
	
end entity;		

architecture MIXT OF UC_TONOMAT_BILETE_V1 is

signal STARE, NXSTARE: STD_LOGIC_VECTOR(4 downto 0);
signal POS: STD_LOGIC_VECTOR(1 downto 0);
begin
	
	CLK_O<=CLK;
	ACTUALIZARE_STARE: process(SHUT_DOWN, CLK)
	begin	   
		if(SHUT_DOWN='1')then
			STARE<="11111";	
		elsif CLK'EVENT and CLK	='1'then
			STARE<=NXSTARE;
		end if;
		
	end process;	
	
	IDENTIFICARE_STARE: process(STARE, REST_POS, OK_6, OK_4, OK, NOK, SHUT_DOWN, SEL, INC, DEC)
	begin
		
		POS(0)<=OK;
		POS(1)<=NOK;  
		
		case STARE is
			
			when "00000"=>--0  	
				EN_2<="00";
				EN_6<="00";
				EN_7<="00";
				EN_9<="00";	   
				SEL_8<="11";   
				SEL_12<="11";
				ADMIN<='1';
				if(OK='1')then
					NXSTARE<="00001";  
						
				elsif(NOK='1')then
					NXSTARE<="01000";
				else
					NXSTARE<="00000";
				end if;	  
					
					
			when "00001"=>--1 	
				ADMIN<='0';
				ERR_T<='0';
				ERR_R<='0';
				if(OK='1')then
					NXSTARE<="00010";  
					
				elsif(NOK='1')then
					NXSTARE<="00100";
				else
					NXSTARE<="00001";
						
				end if;	
					
			---PUNEM BILETE		
			when "00010"=>--2 	 
				EN_6<="01";
				INT_T<='1';	 
				
				INC_O<=INC;
				DEC_O<=DEC;	
				
				if(OK='1')then
					NXSTARE<="00100";  
						
				else
					NXSTARE<="00010";
					
				end if;	
			when "00011"=>--3 
				NXSTARE<="00010";
			
			when "00100"=>--4  	
				EN_6<="00";	
				INT_T<='0';	
				
				INC_O<='0';
				DEC_O<='0';	
				
				if(OK='1')then
					NXSTARE<="00101";  
						
				elsif(NOK='1')then
					NXSTARE<="00000";
				else
					NXSTARE<="00100";
					
				end if;	
			
			---PUNEM_BANI
			when "00101"=>--5 	
				SEL_12<="10";  
			
				if(SEL="11111" or SEL="10101")then
					SEL_2<="00000";
				else
					SEL_2<=SEL;	  
				end if;
								  
			 	INT_M<='1';	 
				 
				INC_O<=INC;
				DEC_O<=DEC;	
				
				if(OK='1')then
					NXSTARE<="00111";  
						
				elsif(NOK='1')then
					NXSTARE<="00110";
				else
					NXSTARE<="00101";
					
				end if;	
			when "00110"=>--6	  
				NXSTARE<="00101";
			when "00111"=>--7  
				SEL_2<="00000";	
			 	INT_M<='0';		
				SEL_12<="11";  
				 
				INC_O<='0';
				DEC_O<='0';	
			
				NXSTARE<="00000"; 
							  			  
			when "01000"=>--8	
				if(OK_6='1')then---DACA MAI AVEM BILETE 
					ERR_T<='1';
					NXSTARE<="00000";
				else
					NXSTARE<="01001";
				end if;
			when "01001"=>--9  
				 UTILIZ<='1';
				 SEL_9<="11111";
				 SEL_2<="00000";
				 if(OK='1')then
					NXSTARE<="01010";  
						
				elsif(NOK='1')then
					NXSTARE<="00000";
				else
					NXSTARE<="01001";
					
				end if;
			
			when "01010"=>--10 	   
				UTILIZ<='0';
				INT_D<='1';	
				NXSTARE<="01011";	
				SEL_8<="01";
			when "01011"=>--11 ---BAGAM DISTANTA
			
				EN_7<="01";	  	
				
				INC_O<=INC;
				DEC_O<=DEC;	
				
				if(OK='1')then
					NXSTARE<="01100";  
				else
					NXSTARE<="01011";
					
				end if;	
								 
			when "01100"=>--12	 
				EN_7<="00";
				SEL_12<="00";  
				INT_D<='0';
				INT_M<='1';	 
				SEL_8<="00";
				
				
				INC_O<='0';
				DEC_O<='0';	
				
				NXSTARE<="01101"; 
			---INTRODUCEM BANI
			when "01101"=>--13	
				if(SEL="11111" or SEL="10101")then
					SEL_9<="00000";
				else
					SEL_9<=SEL;	  
				end if;
				
				INT_D<='0';
				INT_M<='1';	 
			
				if(OK='1')then
					NXSTARE<="01110";  
				else
					NXSTARE<="01101";
					
				end if;	
			
			when "01110"=>--14	
				SEL_12<="11";  
				SEL_8<="00";
				INT_M<='0';	
			
				INC_O<='0';
				DEC_O<='0';	
				
				NXSTARE<="01111";
				
			when "01111"=>--15	 
				if(OK_4='1')then
					NXSTARE<="10000";
				else
					NXSTARE<="01111";
				end if;
			
			when "10000"=>--16
				if(REST_POS='1')then
					NXSTARE<="10001";
				elsif(REST_POS='0')then
					NXSTARE<="10101";
				else
					NXSTARE<="10000"; 
				end if;
			when "10001"=>--17	   
				ELIB_BIL<='1';
				ELIB_REST<='1';
				SEL_8<="00";  
				SEL_12<="01";  
				NXSTARE<="10010";
				EN_6<="01";
				DEC_O<='1';
			when "10010"=>--18	 
				EN_6<="00";		 
				DEC_O<='0';
				NXSTARE<="10011";  
				
			when "10011"=>--19	 
				NXSTARE<="10100"; 
			
			when "10100"=>--20 	    
			 	if(OK='1')then	 
					NXSTARE<="10110";
				else
					NXSTARE<="10100";
				end if;
				
			when "10101"=>--21 	 
				SEL_8<="11";
				ERR_R<='1';
				NXSTARE<="00000";	
				
			when "10110"=>--22 	   	   
				ELIB_BIL<='0';
				ELIB_REST<='0';
				SEL_8<="11";
				SEL_12<="11";  	
				NXSTARE<="00000";
				
			when "11111"=>--INITIALIZARE  
				SEL_2<="11111";		
				SEL_9<="11111";	
				EN_6<="10";	
				EN_7<="10";	 
				ERR_T<='0';
				ERR_R<='0';	  
				INT_T<='0';	  
				INT_M<='0';
				INT_D<='0';	
				
				ADMIN<='0';
				UTILIZ<='0';
				ELIB_BIL<='0';
				ELIB_REST<='0';
				INC_O<='0';
				DEC_O<='0';	
				NXSTARE<="00000";
			when others => 
				
		end case;			  
				
		
	end process;

end architecture;