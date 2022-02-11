
/*--------------------------------------------------------
	C# (CSharp) Module Library for GameMaker Studio 2
	Copyright (C) 2022 Foxy Of Jungle - MIT License
--------------------------------------------------------*/

// ----- configs -----

#macro CSHARP_MOD_VERSION "0.0.1"
#macro CSHARP_MOD_AUTHOR "Foxy Of Jungle"
#macro CSHARP_TIME_TYPE CSHARP_TIME.P_FRAMES


#region < Library Core >

show_debug_message("Using C# Module (C) 2022, v" + string(CSHARP_MOD_VERSION));

enum CSHARP_TIME {
	P_SECONDS,
	P_FRAMES,
}

switch (CSHARP_TIME_TYPE) {
	case CSHARP_TIME.P_FRAMES:
		global.__csharp_game_speed = 1;
		global.__csharp_time_counter = 1;
		break;
	case CSHARP_TIME.P_SECONDS:
		global.__csharp_game_speed = game_get_speed(gamespeed_fps);
		global.__csharp_time_counter = 1;
		break;
}

#macro SECOND * game_get_speed(gamespeed_fps)
#macro SECONDS * game_get_speed(gamespeed_fps)
#macro null undefined
#macro IEnumerator __yield_call_number = 0; __yield = function
#macro yield_return __yield_call_number += 1; __yield_action =



// spawn
#macro __csh __csharp_handler
if instance_exists(__csh) instance_destroy(__csh);
room_instance_add(0, 0, 0, __csh);

// data
global.__cs_invoke_method_list = [];
global.__cs_invokerealtime_method_list = [];

#endregion



// ----- functions -----

#region Class: MonoBehaviour

function __Debug() constructor {
	/// @func Log(msg)
	static Log = function(msg) {
		show_debug_message(msg);
	}
	
	static LogFormat = function(msg, values_array) {
		var _final_string = "";
		var _vapos = 0;
		for (var i = 1; i <= string_length(msg); ++i) {
			var _char = string_char_at(msg, i);
			if (_char == "{") {
				_final_string += string(values_array[_vapos]);
				_vapos += 1;
				i += 2;
			} else {
				_final_string += _char;
			}
		}
		show_debug_message(_final_string);
	}
}
global.__Debug_cs = new __Debug()
#macro Debug global.__Debug_cs


function print() {
	if (argument_count > 0) {
		var _log = "";
		for (var i = 0; i < argument_count; i += 1;) {
			_log += string(argument[i]);
			if (argument_count > 1) _log += " | ";
		}
		show_debug_message(_log);
	}
}


// -> Public Methods

function Invoke(method_id, arguments_array=[], time=0, once=true) {
	if (time <= 0) {
		script_execute_array(method_id, arguments_array);
		return undefined;
	} else {
		var _struct = {
			callback : method_id,
			callback_data : arguments_array,
			time : time*global.__csharp_game_speed,
			counter : 0,
			once : once,
			paused : false
		}
		array_push(global.__cs_invoke_method_list, _struct);
	}
}


function InvokeRealtime(method_id, arguments_array=[], time_ms=0, once=true) {
	if (time_ms <= 0) {
		script_execute_array(method_id, arguments_array);
		return undefined;
	} else {
		var _struct = {
			callback : method_id,
			callback_data : arguments_array,
			time : time_ms,
			end_time : current_time + time_ms,
			counter : 0,
			once : once,
			paused : false
		}
		array_push(global.__cs_invokerealtime_method_list, _struct);
	}
}



function IsInvoking(method_id) {
	var i = 0, _size = array_length(global.__cs_invoke_method_list);
	repeat(_size) {
		if (global.__cs_invoke_method_list[i].callback == method_id) {
			return true;
		}
		i++;
	}
	return false;
}

function CancelInvoke(method_id=-1) {
	if (method_id == -1) {
		array_resize(global.__cs_invoke_method_list, 0);
	} else {
		var i = 0, _size = array_length(global.__cs_invoke_method_list);
		repeat(_size) {
			if (global.__cs_invoke_method_list[i].callback == method_id) {
				array_delete(global.__cs_invoke_method_list, i, 1);
				i--;
			}
			i++;
		}
	}
}

function PauseInvoke(method_id=-1) {
	var i = 0, _size = array_length(global.__cs_invoke_method_list);
	repeat(_size) {
		if (method_id == -1 || global.__cs_invoke_method_list[i].callback == method_id) {
			global.__cs_invoke_method_list[i].paused = true;
		}
		i++;
	}
}

function ResumeInvoke(method_id=-1) {
	var i = 0, _size = array_length(global.__cs_invoke_method_list);
	repeat(_size) {
		if (method_id == -1 || global.__cs_invoke_method_list[i].callback == method_id) {
			global.__cs_invoke_method_list[i].paused = false;
		}
		i++;
	}
}

function StartCoroutine(routine) {
	routine();
}

function WaitForTime(time) {
	//invoke()
	print("-- time --");
}


// -> Static Methods

function DontDestroyOnLoad(obj) {
	obj.persistent = true;
}

function Destroy(obj, time=0, destroy_flag=true) {
	var _d = function(_o, _d) {instance_destroy(_o, _d);}
	if !IsInvoking(_d) Invoke(_d, [obj, destroy_flag], time);
}

function Instantiate(obj, x, y) {
	instance_create_layer(x, y, layer, obj);
}

#endregion


#region Class: Mathf

function __Mathf() constructor {
	
	/// @func PI()
	static PI = function() {
		return pi;
	}
	
	/// @func Deg2Rad(x)
	static Deg2Rad = function(x) {
		return x * (pi * 2) / 360;
	}
	
	/// @func Rad2Deg(x)
	static Rad2Deg = function(x) {
		return x * 360 / (pi * 2);
	}
	
	/// @func Infinity()
	static Infinity = function() {
		return infinity;
	}
	
	/// @func NegativeInfinity()
	static NegativeInfinity = function() {
		return -infinity;
	}
	
	/// @func Abs(x)
	static Abs = function(x) {
		return abs(x);
	}
	
	/// @func Acos(x)
	static Acos = function(x) {
		return arccos(x); 
	}
	
	/// @func Asin(x)
	static Asin = function(x) {
		return arcsin(x); 
	}
	
	/// @func Atan(x)
	static Atan = function(x) {
		return arctan(x); 
	}
	
	/// @func Atan2(x)
	static Atan2 = function(y, x) {
		return arctan2(y, x);
	}
	
	/// @func Ceil(x)
	static Ceil = function(x) {
		return ceil(x);
	}
	
	/// @func Clamp(val, min, max)
	static Clamp = function(val, min, max) {
		return clamp(val, min, max);
	}
	
	/// @func Clamp01(val)
	static Clamp01 = function(val) {
		return clamp(val, 0, 1);
	}
	
	/// @func ClosestPowerOfTwo(val)
	static ClosestPowerOfTwo = function(val) {
		val--;
		val |= val >> 1;
		val |= val >> 2;
		val |= val >> 4;
		val |= val >> 8;
		val |= val >> 16;
		val++;
		return val;
	}
	
	/// @func RGB2Kelvin(val) - W.I.P.
	static RGB2Kelvin = function(color) {
		return 0;
	}
	
	/// @func Kelvin2RGB(val)
	static Kelvin2RGB = function(temp) {
		temp /= 100;
		var red, blue, green;
		
		if (temp <= 66) {
			red = 255;
		} else {
			red = temp - 60;
			red = 329.698727466 * power(red, -0.1332047592);
			if (red < 0) {
				red = 0;
			}
			if (red > 255) {
				red = 255;
			}
		}

		if (temp <= 66) {
			green = temp;
			green = 99.4708025861 * log2(green) - 161.1195681661;
			if (green < 0) {
				green = 0;
			}
			if (green > 255) {
				green = 255;
			}
		} else {
			green = temp - 60;
			green = 288.1221695283 * power(green, -0.0755148492)
			if (green < 0) {
				green = 0;
			}
			if (green > 255) {
				green = 255;
			}
		}

		if (temp >= 66) {
			blue = 255;
		} else {
			if (temp <= 19) {
				blue = 0;
			} else {
				blue = temp - 10;
				blue = 138.5177312231 * log2(blue) - 305.0447927307;
				if (blue < 0) {
					blue = 0;
				}
				if (blue > 255) {
					blue = 255;
				}
			}
		}
		
		return {
			r : floor(red),
			g : floor(green),
			b : floor(blue),
		};
	}
	
	/// @func Sin(radian_angle).
	static Sin = function(radian_angle) {
		return sin(radian_angle);
	}
	
	/// @func Cos(radian_angle).
	static Cos = function(radian_angle) {
		return cos(radian_angle);
	}
	
	/// @func Tan(radian_angle).
	static Tan = function(radian_angle) {
		return tan(radian_angle);
	}
	
	/// @func Exp(x).
	static Exp = function(x) {
		return exp(x);
	}
	
	/// @func Floor(x).
	static Floor = function(x) {
		return floor(x);
	}
	
	/// @func Round(x).
	static Round = function(x) {
		return round(x);
	}
	
	/// @func Ceil(x).
	static Ceil = function(x) {
		return ceil(x);
	}
	
	/// @func DeltaAngle(current, target).
	static DeltaAngle = function(current, target) {
		return angle_difference(target, current);
	}
	
}


global.__Mathf_cs = new __Mathf()
#macro Mathf global.__Mathf_cs



#endregion


#region Class: GML Internal Extended
// Others
function script_execute_array(func, array) {
	var _size = array_length(array);
	switch(_size) {
		case 0: func(); break;
		case 1: func(array[0]); break;
		case 2: func(array[0], array[1]); break;
		case 3: func(array[0], array[1], array[2]); break;
		case 4: func(array[0], array[1], array[2], array[3]); break;
		case 5: func(array[0], array[1], array[2], array[3], array[4]); break;
		case 6: func(array[0], array[1], array[2], array[3], array[4], array[5]); break;
		case 7: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6]); break;
		case 8: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7]); break;
		case 9: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8]); break;
		case 10: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9]); break;
		case 11: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10]); break;
		case 12: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11]); break;
		case 13: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11], array[12]); break;
		case 14: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11], array[12], array[13]); break;
		case 15: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11], array[12], array[13], array[14]); break;
		case 16: func(array[0], array[1], array[2], array[3], array[4], array[5], array[6], array[7], array[8], array[9], array[10], array[11], array[12], array[13], array[14], array[15]); break;
		default: return undefined;
	}
}
#endregion

