precision highp float;
attribute vec3 position;
attribute vec3 normal;
attribute vec2 uv;
attribute vec3 tangent;

uniform mat4 u_MVPMatrix;
uniform mat4 modelWorldMatrix;
uniform vec3 u_WorldSpaceCameraPos;
uniform vec3 lightPos;
uniform vec3 viewPos;
uniform sampler2D bumpMap;
uniform vec4 u_Map_ST;
uniform sampler2D map;



varying vec4 fPosition;
varying vec3 lightDir;
varying vec3 viewDir;
varying vec4 vnormal;
varying vec4 vColor;
varying float vRim;
varying vec2 mainTexUv;

void main()
{
  
  mainTexUv = (uv.xy * u_Map_ST.xy) + u_Map_ST.zw;
  vRim = max(0.0, 1.0+dot(normalize(u_WorldSpaceCameraPos - vec3(modelWorldMatrix * vec4(position,1.0))),mat3(modelWorldMatrix) * normalize(normal)));


  viewDir = normalize(u_WorldSpaceCameraPos - vec3(modelWorldMatrix * vec4(position,1.0)));
  lightDir = normalize(vec3(modelWorldMatrix * vec4(lightPos,1.0)));

  mat3 tangentToWorld;
  tangentToWorld[2] = vec3(modelWorldMatrix * vec4(normal, 1.0));
  tangentToWorld[0] = vec3(modelWorldMatrix * vec4(tangent, 1.0));
  tangentToWorld[1] = cross(tangentToWorld[2], tangentToWorld[0]) ;



  vnormal = vec4(normalize(tangentToWorld[2]),1.0);
  


  gl_Position = u_MVPMatrix * vec4(position, 1.0);
}