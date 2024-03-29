with ada.characters.latin_1;
with logger;
use logger;

package body halfbox is
    function get_halfbox(width, length, height, thickness, queue_length : integer) return halfbox_t is
        -- On stock les informations relatives à la demi boîte avec celles-ci
        -- Au cas où on en aurait besoin ultérieurement si l'on souhaite rajouter
        -- des étapes au processus
        halfbox_info : constant halfbox_info_t := (width => width,
            length => length,
            height => height,
            thickness => thickness,
            queue_length => queue_length);

        -- On génère chacune des panneaux de la demi-boîte
        -- A partir des informations de la demi-boîte
        halfbox : constant halfbox_t := (
            info => halfbox_info,
            panel_bottom => get_bottom_panel(halfbox_info),
            panel_back => get_back_panel(halfbox_info),
            panel_front => get_front_panel(halfbox_info),
            panel_left => get_left_panel(halfbox_info),
            panel_right => get_right_panel(halfbox_info));
    begin
        debug("Génération d'une demi boîte");
        debug(to_string(halfbox_info));

        return halfbox; 
    end;

    procedure destroy(halfbox : in out halfbox_t) is
    begin
        destroy(halfbox.panel_bottom);
        destroy(halfbox.panel_back);
        destroy(halfbox.panel_front);
        destroy(halfbox.panel_left);
        destroy(halfbox.panel_right);
    end;

    function to_string(halfbox : halfbox_t) return string is
        tab : constant character := ada.characters.latin_1.HT;
        lf : constant character := ada.characters.latin_1.LF;
    begin
        return "[" 
            & tab & "info: " & to_string(halfbox.info) & lf
            & tab & "bottom:" & to_string(halfbox.panel_bottom) & lf
            & tab & "back:" & to_string(halfbox.panel_back) & lf
            & tab & "front:" & to_string(halfbox.panel_front) & lf
            & tab & "left:" & to_string(halfbox.panel_left) & lf
            & tab & "right:" & to_string(halfbox.panel_right) & lf
            & "]";
    end;
end halfbox;
