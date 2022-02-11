
show_debug_message("---------------");

test_func = function() {
	print("Happened");
}
test_func1 = function(message1, message2, number) {
	print("Fox says: ", message1, message2, number);
}

time = 0;
timer = function() {
	print("Time: ", time);
	time += 1;
}

Invoke(timer, [], 60, false);
Invoke(test_func, [], 180);
Invoke(test_func1, ["Okay", "I'm fine", 256], 4 SECONDS);

Debug.LogFormat("I have {0} apples, {1} bananas and one {2}", [10, 5, "cat"]);

repeat(10) {
	var _xx = irandom(room_width);
	var _yy = irandom(room_height);
	instance_create_depth(_xx, _yy, 0, obj_test);
}


dir_test = function() {
	var dir_test = Mathf.Deg2Rad(-point_direction(room_width/2, room_height/2, mouse_x, mouse_y));
	print(cos(dir_test), sin(dir_test));
}
Invoke(dir_test, [], 0.25 SECONDS, false);


/*
IEnumerator TestThing() {
	repeat(6) {
		yield_return WaitForTime(5);
		//invoke(__yield, 5);
	}
}
StartCoroutine(TestThing);
print(__yield_call_number);

__yield; = id da funcao TestThing
*/
