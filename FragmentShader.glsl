#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D u_texture;
uniform mat4 modelview;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;

varying vec4 positionF;
varying vec3 normalF;
varying vec2 texCoordF;


void main() {
    vec3 ecPosition = vec3(modelview * positionF);  
    vec3 ecNormal = normalize(normalMatrix * normalF);
    vec3 direction = normalize(lightPosition.xyz - ecPosition);
    float intensity = max(0.0, dot(direction, ecNormal));

    vec4 teinteVerte = vec4(0.4, 1, 0.4, 1);
    vec4 teinteLignesNiveau = vec4(0.5, 0.5, 0.5, 1);
    float adjustedIntensity = intensity * 1.4;
    vec4 teinteIntensity = vec4(adjustedIntensity, adjustedIntensity, adjustedIntensity, 1);

    if (positionF.z < -197) {
        gl_FragColor = texture2D(u_texture, texCoordF) * teinteVerte * teinteIntensity;
    } else if (mod(int(100*positionF.z), 100) < 9) {
        gl_FragColor = texture2D(u_texture, texCoordF) * teinteLignesNiveau * teinteIntensity;
    } else {
        gl_FragColor = texture2D(u_texture, texCoordF) * teinteIntensity;
    }
}

