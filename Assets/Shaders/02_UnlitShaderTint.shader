﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "LearningShaders/Basic/02_Unlit Tint" {

//Input Variables

Properties{
//_VariableName("InspectorName, Type) = defaultValue Types 2D|Color|Float|Int|Range|Vector|Cube|3D
_MainTex("MainTex",2D) = ""{}
_Color("Color", Color) = (1,1,1,1)

}

SubShader{


Pass{//Everytime a pass is applied the shader is modified, several passed can be used, each of one represents a draw call
CGPROGRAM //standard for CG Code CGPROGRAM CGEND
#pragma vertex vert //declaring there is a vertex function in the code
#pragma fragment frag //declaring there is a fragment function in the code
#include "UnityCG.cginc" //librery with useful parameters and functions, always include

//import defined variables from ShaderLab to CG
//uniform is set as a static variable
//variableType _VariableName;
uniform float4 _Color;
uniform sampler2D _MainTex;
float4 _MainTex_ST; //this is needed for the TRANSFORM_TEX op, that modifies the texture with tiling and offset values

//Input structs for vertices and uvs
struct appdata{
//variableType VariableName : Parameter
//variableType float|half|fixed with vector nº of components
//Parameters POSITION|NORMAL|TEXCOORDn|TANGENT|COLOR
float4 vertex : POSITION; //POSITION uses a float4 (x,y,z,w)
half2 uv0 : TEXCOORD0; //half used for performance, not suitable for Texture Animation
};

struct v2f{
float4 vertex : SV_POSITION; //the SV_ is used for compatibility with DX11
half2 uv0 : TEXCOORD0;
};

//Vertex function, when the object is built
//2nd struct nameOnPragmaVertex(1st struct anInVariableKey)
v2f vert(appdata v)
{
v2f o; //struct name and anOutVariableKey
o.vertex = UnityObjectToClipPos(v.vertex); //multiplying the vertex position for a standard parameter UNITY_MATRIX_MVP that bases on the model view projection from the camera
//o.uv0 = v.uv0; with this the tiling and offset does not modify the texture
o.uv0 = TRANSFORM_TEX(v.uv0, _MainTex); //TRANSFORM_TEX modifies the texture with tiling and offset values

return o; //returning the result of the function
}

//Fragment function, when the object is drawn per pixel

fixed4 frag(v2f i) : SV_Target
{
float4 texCol = tex2D( _MainTex, i.uv0);

return texCol * _Color; //return the final result that will be drawn
}

ENDCG
}

}
}