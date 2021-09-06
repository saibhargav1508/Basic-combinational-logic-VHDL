library ieee;
use ieee.std_logic_1164.all;

entity enc4to2 is
  port (
    input  : in  std_logic_vector(3 downto 0);
    output : out std_logic_vector(1 downto 0);
    valid  : out std_logic);
end enc4to2;


architecture IF_STATEMENT of enc4to2 is
begin
    process(input)
    begin
        if (input = "0000") then
            output <= "XX";
            valid <= '0'; 
        elsif (input = "0001") then
            output <= "00";
            valid <= '1';
        -- if statement handles priority on its own
        elsif (input = "0010") then
            output <= "01";
            valid <= '1';    
        elsif (input = "0100") then
            output <= "10";
            valid <= '1';
        elsif (input = "1000") then
            output <= "11";
            valid <= '1';    
        end if;
    end process;
end IF_STATEMENT;

-- architecture will be slightly trickier because a case statement has no
-- notion of priority.

architecture CASE_STATEMENT of enc4to2 is
begin
    process(input)
    begin
        case input is 
            when "0000" =>
                output <= "XX";
                valid <= '0';
            when "0001" =>
                output <= "00";
                valid <= '1';
            -- to handle priority with case statement use - to ignore any data bit
            when "001-" =>
                output <= "01";
                valid <= '1';
            when "01--" =>
                output <= "10";
                valid <= '1';
            when "1---" =>
                output <= "11";
                valid <= '1';
            when others =>
                output <= "XX";
                valid <= 'X';
        end case;
    end process;
end CASE_STATEMENT;
