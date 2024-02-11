
#define PI 3.1415926535897932384626433832795

uniform float uTime;
uniform sampler2D uTexture;
uniform int uRepetitions;
uniform vec2 uResolution;
uniform vec2 uMouse;

varying vec2 vUv;

void main(void)
{
    vec2 uv=vUv;
    uv*=2.;
    uv-=1.;
    
    vec2 mouse=uMouse/uResolution;
    
    // Get the angle and radius
    float radius=length(uv)*mix(1.,2.,mouse.y);
    float angle=atan(uv.y,uv.x);
    
    // Get a segment
    angle/=PI;
    angle*=float(uRepetitions);
    // angle=fract(angle);
    
    // Repeat segment
    if(mod(angle,2.)>=1.){
        angle=fract(angle);
    }else{
        angle=1.-fract(angle);
    }
    
    angle+=uTime*.01;
    
    // Unsquash segment
    angle/=float(uRepetitions);
    angle*=PI;
    
    vec2 point=vec2(radius*cos(angle*mouse.x*2.5),radius*sin(angle));
    point=fract(point);
    
    vec4 color=texture2D(uTexture,point);
    gl_FragColor=color;
}