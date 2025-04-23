shader_type canvas_item;

uniform sampler2D pal0 : hint_default_black;
uniform sampler2D pal1 : hint_default_black;
uniform sampler2D pal2 : hint_default_black;

uniform float lerper: hint_range(0.0, 1.0);



vec3 c_lerp(vec4 c1, vec4 c2, float pos) {
	pos = clamp (pos, 0.0, 1.0);
	return vec3(c1.x*pos + c2.x*(1.0-pos),c1.y*pos + c2.y*(1.0-pos),c1.z*pos + c2.z*(1.0-pos));
}

void fragment() {
	
	vec3 tex_uv = vec3(UV, 0.0);
	vec3 color_input;
	float alpa_input;
	
	// Get the colors from the image at specified location
	
	{
		vec4 _tex_read = textureLod(TEXTURE, tex_uv.xy, 0.0);
		color_input = _tex_read.rgb;
		alpa_input = _tex_read.a;
	}
	
	// get the greyscale value through the highest of r, g, and b
	
	float grey_value;
	{
		vec3 c = color_input;
		float max1 = max(c.r, c.g);
		float max2 = max(max1, c.b);
		grey_value = max2;
	}
	
	// Read the colormap and use the greyscale value to map in the new colors for each palette.
	
	vec4 colorP0 = textureLod(pal0, vec2(grey_value, 0.0), 0.0);
	
	vec4 colorP1 = textureLod(pal1, vec2(grey_value, 0.0), 0.0);
	
	vec4 colorP2 = textureLod(pal2, vec2(grey_value, 0.0), 0.0);
	
	float l1 = min(lerper*2.0, 1.0);
	float l2 = max(min(lerper*2.0-1.0, 1.0), 0.0);
	
	
	vec4 mixture1 = mix(colorP0, colorP1, l1);
	vec4 mixture2 = mix(mixture1, colorP2, l2);
	// Blend between your two color maps and...   Profit.
	
	COLOR = vec4(mixture2.rgb, COLOR.w);
}