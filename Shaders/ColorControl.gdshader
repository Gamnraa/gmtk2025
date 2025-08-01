shader_type canvas_item;

uniform float red = 0;
uniform float blue = 0;
uniform float green = 0;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = red;
	COLOR.b = blue;
	COLOR.g = green;
}
