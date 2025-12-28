#ifdef MICRO_SHADOWS
float microShadow(float NdotL, float ao) {
  return clamp(NdotL + ao - 1.0, 0.0, 1.0);
}

#endif
