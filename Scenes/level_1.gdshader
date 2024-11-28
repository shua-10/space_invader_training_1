shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform float flashState : hint_range(0,1) = 0.5;
uniform vec4 color = hint_color;
void fragment()
{
	vec4 pixelColor = texture(TEXTURE, UV);
	COLOR = mix(pixelColor, color, flashState);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
