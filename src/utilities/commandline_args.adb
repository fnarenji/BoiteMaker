with gnat.command_line;
use gnat.command_line;

package body commandline_args is
    procedure initialize is
        procedure validate_int_initialization(x : integer; name : string) is
        begin
            if x = int_no_value then
                raise argument_missing with name;
            end if;
        end;
    begin
        -- Boucle d'obtention des paramètres
        -- TODO: gérer si parameter non fourni
        loop
            case getopt("t: w: l: q: h: b: f: r: -fill: -border: -debug -help") is
                when 't' =>
                    t := integer'value(parameter);
                when 'w' =>
                    w := integer'value(parameter);
                when 'l' =>
                    l := integer'value(parameter);
                when 'q' =>
                    q := integer'value(parameter);
                when 'h' =>
                    h := integer'value(parameter);
                when 'b' =>
                    b := integer'value(parameter);
                when 'f' =>
                    f := to_unbounded_string(parameter);
                when '-' =>
                    if full_switch = "-fill" then
                        fill_color := to_unbounded_string(parameter);
                    elsif full_switch = "-border" then
                        border_color := to_unbounded_string(parameter);
                    elsif full_switch = "-help" then
                        show_help := true;
                    elsif full_switch = "-debug" then
                        show_debug := true;
                    end if; 
                when others =>
                    exit;
            end case;
        end loop;

        -- Vérification de la validité des paramètres saisis
        validate_int_initialization(t, "t");
        validate_int_initialization(w, "w");
        validate_int_initialization(l, "l");
        validate_int_initialization(q, "q");
        validate_int_initialization(h, "h");
        validate_int_initialization(b, "b");

        if f = null_unbounded_string then
            raise argument_missing with "f";
        end if;
    end;

    -- obtient le paramètre t
    function get_t return integer is
    begin
        return t;
    end;
    
    -- obtient le paramètre l
    function get_l return integer is
    begin
        return l;
    end;
    
    -- obtient le paramètre w
    function get_w return integer is
    begin
        return w;
    end;
    
    -- obtient le paramètre q
    function get_q return integer is
    begin
        return q;
    end;
    
    -- obtient le paramètre h
    function get_h return integer is
    begin
        return h;
    end;
    
    -- obtient le paramètre b
    function get_b return integer is
    begin
        return b;
    end;
    
    -- obtient le paramètre f
    function get_f return string is
    begin
        return to_string(f);
    end;

    -- obtient le paramètre fill
    function get_fill_color return string is
    begin
        return to_string(fill_color);
    end;

    -- obtient le paramètre border
    function get_border_color return string is
    begin
        return to_string(border_color);
    end;

    -- obtient le paramètre border
    function get_show_help return boolean is
    begin
        return show_help;
    end;

    -- obtient le paramètre border
    function get_show_debug return boolean is
    begin
        return show_debug;
    end;
end commandline_args;
