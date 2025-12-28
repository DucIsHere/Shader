#ifndef WATER_GLSL
#define WATER_GLSL

#include "include/pbr.glsl"

vec3 waterBRDF(vec3 N, vec3 V, vec3 L, vec3 skyCol) {
  float rough = clamp(0.04 / max(WATER_GLOSS, 0.001), 0.1, 0.2)
}
