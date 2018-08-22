precision highp float;




uniform vec4 specColor;
uniform vec4 lightColor;
uniform float specIntensity;//0~100 1
uniform float shininess;
uniform float atten;
uniform vec4 rim;
uniform float rimPower;
uniform sampler2D map;
uniform vec4 mainColor;

varying vec3 lightDir;
varying vec3 viewDir;
varying vec4 vnormal;
varying vec4 vColor;
varying vec2 mainTexUv;
varying float vRim;


void main()
{
  
  
  
  float alpha = 1.0;
  float specular = shininess;
  vec4 tex = texture2D(map, mainTexUv);
  
  vec4 albedo = vec4(tex.rgb * mainColor.rgb,1.0); + pow(vRim, rimPower) * rim *rim.a * 10.0;
  float gloss = albedo.a;
  float diff = max(0.0, dot(vnormal.xyz, lightDir));
  vec3 h = normalize(lightDir + viewDir);
  float nh = max(0.0, dot(vnormal.xyz, h));
  
  float spec = pow(nh, specular*128.0) * gloss * specIntensity;

  vec4 c;
  c.rgb = (albedo.rgb * lightColor.rgb * diff + lightColor.rgb * specColor.rgb * spec) *(atten*2.0);
  c.a = alpha + lightColor.a * specColor.a * spec * atten;

  gl_FragColor = c;
}