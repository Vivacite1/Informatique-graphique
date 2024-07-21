uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;
uniform sampler2D u_texture;

attribute vec4 position;
attribute vec4 color;
attribute vec3 normal;
attribute vec2 texCoord;


varying vec4 positionF;
varying vec3 normalF;
varying vec2 texCoordF;

void main() { 
    positionF = position;
    normalF = normal;
    texCoordF = texCoord;

    gl_Position = transform * position;
}
