
#region Class : MonoBehaviour

// Invoke = () => ()
if (array_length(global.__cs_invoke_method_list) > 0) {
	var i = 0;
	repeat(array_length(global.__cs_invoke_method_list)) {
		var _struct = global.__cs_invoke_method_list[i];
		if (!_struct.paused) _struct.counter += global.__csharp_time_counter;
		if (_struct.counter >= _struct.time) {
			if (_struct.once) {
				array_delete(global.__cs_invoke_method_list, i, 1);
				i -= 1;
			} else {
				_struct.counter -= _struct.time;
			}
			script_execute_array(_struct.callback, _struct.callback_data);
		}
		i += 1;
	}
}

// InvokeRealtime = () => ()
if (array_length(global.__cs_invokerealtime_method_list) > 0) {
	var i = 0;
	repeat(array_length(global.__cs_invokerealtime_method_list)) {
		var _struct = global.__cs_invokerealtime_method_list[i];
		if (_struct.end_time <= current_time) {
			if (_struct.once) {
				array_delete(global.__cs_invokerealtime_method_list, i, 1);
				i -= 1;
			} else {
				_struct.end_time += _struct.time;
			}
			script_execute_array(_struct.callback, _struct.callback_data);
		}
		i += 1;
	}
}

#endregion
