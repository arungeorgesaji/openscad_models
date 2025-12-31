name_text      = "ABCD";
plate_width    = 50; 
plate_height   = 20;  
plate_thickness= 2;     

text_size      = 10;    
text_depth     = 0.6;  
font_name      = "Liberation Sans:style=Bold";

corner_radius  = 4;     
hole_radius    = 2;     
hole_offset    = 6;     

raised_text    = false;  

module rounded_plate(w, h, r, t) {
    linear_extrude(height = t)
        offset(r = r)
            square([w - 2*r, h - 2*r], center = true);
}

module mounting_holes(w, h, r, off) {
    for (x = [-w/2 + off, w/2 - off])
        for (y = [-h/2 + off, h/2 - off])
            translate([x, y, -1])
                cylinder(h = plate_thickness + 2, r = r, $fn = 32);
}

module name_text_3d(txt, size, depth) {
    linear_extrude(height = depth)
        text(txt,
             size = size,
             font = font_name,
             halign = "center",
             valign = "center");
}

difference() {
    rounded_plate(plate_width, plate_height, corner_radius, plate_thickness);

    if (!raised_text)
        translate([0, 0, plate_thickness - text_depth])
            name_text_3d(name_text, text_size, text_depth);
}

if (raised_text)
    translate([0, 0, plate_thickness])
        name_text_3d(name_text, text_size, text_depth);
