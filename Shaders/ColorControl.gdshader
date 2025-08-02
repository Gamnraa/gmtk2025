shader_type canvas_item;

uniform bool red = false;
uniform bool blue = false;
uniform bool green = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if(red == true) {
		COLOR.r = 0.55;
	}
	if(blue == true) {
		COLOR.b = 0.55;
	}
	if(green == true) {
		COLOR.g = 0.55;
	}
}
