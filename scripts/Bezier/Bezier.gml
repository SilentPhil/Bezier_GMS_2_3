function Bezier() constructor {
    __points        			= [];   /// @is {Point[]}
    __sub_points				= [];	/// @is {Point[]}
    
    static add_point = function(_point/*:Point*/)/*->void*/ {
        array_push(__points, _point);
    }
    
    static set_points = function(_points/*:Point[]*/)/*->void*/ {
    	__points = _points;
    }
    
    static refresh = function()/*->void*/ {
    	__sub_points = [];
		
		array_push(__sub_points, __points[0]);
		for (var i = 0, size_i = array_length(__points); i < size_i - 1; i++) {
			var point = __points[i];
			var next_point = __points[i + 1];
			
			var sub_point = new Point((point.x + next_point.x) / 2, (point.y + next_point.y) / 2);
			
			array_push(__sub_points, sub_point);
		}
		array_push(__sub_points, __points[array_length(__points) - 1]);
    }
    
    static __eval_bezier = function(_f/*:number*/, _p0/*:Point*/, _p1/*:Point*/, _p2/*:Point*/)/*->Point*/ {
		var u	= 1 - _f;
		var uu	= u * u;
		var ff	= _f * _f;
		
		return new Point(
						uu * _p0.x + 2 * u * _f * _p1.x + ff * _p2.x, 
						uu * _p0.y + 2 * u * _f * _p1.y + ff * _p2.y
					);
    }
    
    static debug_draw_sub_points = function()/*->void*/ {
    	for (var i = 0, size_i = array_length(__sub_points); i < size_i; i++) {
    		draw_circle_color(__sub_points[i].x, __sub_points[i].y, 9, c_green, c_green, true);
    	}
    }
	
	#region getters
	/// @arg {number} position - float from 0.0 to 1.0
    static get_point = function(_position/*:number*/)/*->Point*/ {
    	var number_of_sections		= array_length(__sub_points) - 1;
        var f_position  			= _position * number_of_sections;
        var section_index   		= floor(min(number_of_sections - 1, f_position));
        var section_position		= (f_position - section_index);
	
        var is_first_section		= (section_index == 0);
        var is_last_section 		= (section_index == (number_of_sections - 1));
        if (is_first_section) {
        	return new Point(lerp(__sub_points[0].x, __sub_points[1].x, section_position), lerp(__sub_points[0].y, __sub_points[1].y, section_position));
        } else if (is_last_section) {
        	var number_of_sub_points = number_of_sections + 1;
        	return new Point(lerp(__sub_points[number_of_sub_points - 2].x, __sub_points[number_of_sub_points - 1].x, section_position), lerp(__sub_points[number_of_sub_points - 2].y, __sub_points[number_of_sub_points - 1].y, section_position));
        } else {
        	return __eval_bezier(section_position, __sub_points[section_index], __points[section_index], __sub_points[section_index + 1]);
        }
    }
    #endregion
} 


function Point(_x/*:number*/, _y/*:number*/) constructor {
    x = _x;
    y = _y;
}