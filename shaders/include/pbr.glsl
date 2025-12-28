#ifndef PBR_GLSL
#define PBR_GLSL

#include "/settings.glsl"

float DistributionGGX(float NdotH, float roughness){
    float a  = roughness*roughness;
    float a2 = a * a;
    float d  = (NdotH * NdotH) * (a2 - 1.0) + 1.0;
    return a2 / (pi * d *d + 1e - 6);
}

float GeometrySchlick(float NdotV,float k){
    return NdotV / (NdotV * (1.0 - k) + k);
}

float GeometrySmith(float NdotV,float NdotL,float rough){
    float k = (rough + 1.0);
    k = (k * k) / 8.0;
    return GeometrySchlick(NdotV,k) * GeometrySchlick(NdotL,k);
}

vec3 FresnelSchlick(float c, vec3 F0){
    return F0 + (1.0-F0) * pow(1.0-c,5.0);
}

vec3 BRDF_GGX(vec3 N, vec3 V, vec3 L, vec3 albedo, float metallic, float rough){
    rough = max(rough * ROUGHNESS_SCALE,0.02);

    vec3 H = normalize(V+L);

    float NdotL=max(dot(N,L),0.0);
    float NdotV=max(dot(N,V),0.0);
    float NdotH=max(dot(N,H),0.0);
    float VdotH=max(dot(V,H),0.0);

    vec3 F0 = mix(vec3(0.04), albedo, metallic);

    vec3  F = FresnelSchlick(VdotH,F0);
    float D = DistributionGGX(NdotH,rough);
    float G = GeometrySmith(NdotV,NdotL,rough);

    vec3 spec = (D * G * F) / (4.0 * NdotL * NdotV + 1e - 6);

    vec3 kD = (1.0 - F) * (1.0 - metallic);

    return kD * albedo/pi + spec;
}

#endif
