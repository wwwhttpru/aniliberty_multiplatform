#version 460 core
#define SHOW_GRID

#include <flutter/runtime_effect.glsl>

uniform vec2 u_size;  // size of the shape
uniform float u_seed; // shader playback time (in seconds)
uniform vec4 u_color_highlight; // line color of the shape
uniform vec4 u_color_background; // background color of the shape
uniform float u_stripe; // width of the stripes

out vec4 fragColor;

void main() {
    // Direction vector for 30 degrees angle (values are precalculated)
    vec2 direction = vec2(0.866, 0.5);

    // Calculate normalized coordinates
    vec2 normalizedCoords = gl_FragCoord.xy / u_size;

    // Generate a smooth moving wave based on time and coordinates
    float waveRaw = 0.5 * (1.0 + sin(u_seed - dot(normalizedCoords, direction) * u_stripe * 3.1415));
    float wave = smoothstep(0.0, 1.0, waveRaw);

    // Use the wave to interpolate between the background color and line color
    vec4 color = mix(u_color_background, u_color_highlight, wave);

    fragColor = color;
}
