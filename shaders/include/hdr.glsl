vec3 tonemap(vec3 c){
    c *= HDR_EXPOSURE;
    return c/(1.0+c);
}
