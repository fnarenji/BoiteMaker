with ada.characters.latin_1;
with logger;
use logger;

package body box_info is
    function initialize_box(t, w, l, h, q, b : integer) return box_info_t is
        box : constant box_info_t := (thickness => t,
                                        height => h,
                                        width => w,
                                        length => l,
                                        queue_length => q,
                                        inner_height => b);
    begin
        debug("Initialisation de la boite");
        debug(to_string(box));

        return box;
    end;

    -- requiert :
    -- t, l, w, q, h, b, q > 0
    -- l >= w
    -- l-2t, w-2t > 0
    -- b < h-2t
    -- q <= l-4t (Test aussi sur la inner boite d'où le 4)
    -- q <= w-4t (Test aussi sur la inner boite d'où le 4)
    -- q <= h-2t
    -- q <= b-2t
    procedure validate_box_measurements(box : box_info_t) is
    begin
        debug("Verification des mesures entrées");

        if not (box.thickness > 0) then
            raise invalid_args with "t > 0";
        end if;

        if not (box.length > 0) then
            raise invalid_args with "l > 0";
        end if;

        if not (box.width > 0) then
            raise invalid_args with "w > 0";
        end if;

        if not (box.queue_length > 0) then
            raise invalid_args with "q > 0";
        end if;

        if not (box.height > 0) then
            raise invalid_args with "h > 0";
        end if;

        if not (box.inner_height > 0) then
            raise invalid_args with "b > 0";
        end if;

        if not (box.queue_length > 0) then
            raise invalid_args with "q > 0";
        end if;

        if not (box.length >= box.width) then
            raise invalid_args with "l >= w";
        end if;

        if not (box.length - 2 * box.thickness > 0) then
            raise invalid_args with "l - 2 * t > 0";
        end if;

        if not (box.width - 2 * box.thickness > 0) then
            raise invalid_args with "w - 2 * t > 0";
        end if;

        if not (box.inner_height < box.height - 2 * box.thickness) then
            raise invalid_args with "b < h - 2 * t";
        end if;

        if not (box.queue_length <= box.length - 4 * box.thickness) then
            raise invalid_args with "q <= l - 4 * t";
        end if;
        if not (box.queue_length <= box.width - 4 * box.thickness) then
            raise invalid_args with "q <= w - 4 * t";
        end if;
        if not (box.queue_length <= box.height - 2 * box.thickness) then
            raise invalid_args with "q <= h - 2 * t";
        end if;

        if not (box.queue_length <= box.inner_height - 2 * box.thickness) then
            raise invalid_args with "q <= b - 2 * t";
        end if;
    end;

    -- renvoie une chaine de texte décrivant l'état de l'objet
    function to_string(box : box_info_t) return string is
        tab : constant character := ada.characters.latin_1.HT;
        lf : constant character := ada.characters.latin_1.LF;
    begin
        return "[ " 
            & tab & "t: " & integer'image(box.thickness) & ", " & lf
            & tab & "w: " & integer'image(box.width) & ", " & lf
            & tab & "l: " & integer'image(box.length) & ", " & lf
            & tab & "h: " & integer'image(box.height) & ", " & lf
            & tab & "q: " & integer'image(box.queue_length) & ", " & lf
            & tab & "b: " & integer'image(box.inner_height) & " ]";
    end;
end box_info;
