// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VolumetricExplosion"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Float2("Float 2", Range( -1 , 3)) = 0
		_Texture1("Texture 1", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "white" {}
		_ChannelFactor("_ChannelFactor", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture1;
		uniform sampler2D _Texture2;
		uniform float4 _Texture2_ST;
		uniform float4 _ChannelFactor;
		uniform float _Float2;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 uv_Texture2 = float4(v.texcoord * _Texture2_ST.xy + _Texture2_ST.zw, 0 ,0);
			float4 tex2DNode40 = tex2Dlod( _Texture2, uv_Texture2 );
			float temp_output_49_0 = ( ( tex2DNode40.r * _ChannelFactor.x ) + ( tex2DNode40.g * _ChannelFactor.y ) + ( tex2DNode40.b * _ChannelFactor.z ) );
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( temp_output_49_0 * ase_vertexNormal );
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Texture2 = i.uv_texcoord * _Texture2_ST.xy + _Texture2_ST.zw;
			float4 tex2DNode40 = tex2D( _Texture2, uv_Texture2 );
			float temp_output_49_0 = ( ( tex2DNode40.r * _ChannelFactor.x ) + ( tex2DNode40.g * _ChannelFactor.y ) + ( tex2DNode40.b * _ChannelFactor.z ) );
			float2 temp_cast_0 = (( temp_output_49_0 * _Float2 )).xx;
			o.Emission = tex2D( _Texture1, temp_cast_0 ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13101
1927;29;1266;988;-580.5848;1042.312;1.444219;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;39;219.6878,-401.3488;Float;True;Property;_Texture2;Texture 2;9;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.Vector4Node;50;210.3439,-770.6708;Float;False;Property;_ChannelFactor;_ChannelFactor;12;0;0,0,0,0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;40;565.8878,-360.7306;Float;True;Property;_TextureSample3;Texture Sample 3;10;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;924.0242,-399.9005;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;913.6679,-246.1496;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;938.7607,-551.7711;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;55;1418.93,-866.1904;Float;False;Property;_Float2;Float 2;6;0;0;-1;3;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;49;1119.57,-47.16142;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;1377.86,-622.1011;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.TexturePropertyNode;28;1148.704,-824.194;Float;True;Property;_Texture1;Texture 1;6;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.NormalVertexDataNode;42;770.1006,423.9182;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-1582.172,-1828.212;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.75,0.75;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;13;-2157.081,-476.4357;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;31;-2108.478,-1648.037;Float;False;Property;_Y_Pan_B;Y_Pan_B;3;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.TexturePropertyNode;3;-1269.363,-62.44658;Float;True;Property;_Texture0;Texture 0;0;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.BlendOpsNode;38;-399.1383,190.8433;Float;False;Overlay;True;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;19;-2329.894,-201.3839;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;9;-865.0754,429.9841;Float;False;Property;_Float0;Float 0;2;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1970.967,-373.7399;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-331.3427,-52.74899;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;30;-290.2727,-296.8383;Float;False;Property;_Float1;Float 1;6;0;0;-1;3;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-561.425,41.45095;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1662.837,-379.136;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT4;0.0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;22;-949.1947,-327.8696;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;14;-2518.843,-598.0427;Float;False;Property;_X_Pan;X_Pan;3;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-495.2393,349.5107;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;34;-1541.99,-1627.482;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2723.569,-496.9908;Float;False;Property;_Y_Pan;Y_Pan;3;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-1047.746,-1530.182;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT4;0.0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.NormalVertexDataNode;5;-119.2913,390.7339;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;32;-1904.752,-1749.089;Float;False;Property;_X_Pan_B;X_Pan_B;3;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1355.876,-1524.786;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;147.6836,211.053;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;4;-947.5107,-54.16714;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TimeNode;33;-1714.803,-1352.43;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-2197.263,-677.1661;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1085.718,328.726;Float;False;2;2;0;FLOAT;0,0,0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1329.475,-104.7534;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;53;1438.487,-374.7706;Float;True;Property;_TextureSample4;Texture Sample 4;10;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;26;-62.03052,-93.64801;Float;True;Property;_TextureSample2;Texture Sample 2;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;1501.487,40.41743;Float;False;True;6;Float;ASEMaterialInspector;0;0;Unlit;VolumetricExplosion;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;32;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;39;0
WireConnection;47;0;40;2
WireConnection;47;1;50;2
WireConnection;51;0;40;3
WireConnection;51;1;50;3
WireConnection;45;0;40;1
WireConnection;45;1;50;1
WireConnection;49;0;45;0
WireConnection;49;1;47;0
WireConnection;49;2;51;0
WireConnection;54;0;49;0
WireConnection;54;1;55;0
WireConnection;13;0;14;0
WireConnection;13;1;15;0
WireConnection;38;0;22;2
WireConnection;38;1;4;1
WireConnection;16;0;13;0
WireConnection;16;1;19;2
WireConnection;29;0;23;0
WireConnection;29;1;30;0
WireConnection;23;0;22;2
WireConnection;23;1;4;1
WireConnection;21;0;12;0
WireConnection;21;1;16;0
WireConnection;22;0;3;0
WireConnection;22;1;37;0
WireConnection;10;0;38;0
WireConnection;10;1;9;0
WireConnection;34;0;32;0
WireConnection;34;1;31;0
WireConnection;37;0;35;0
WireConnection;37;1;36;0
WireConnection;36;0;34;0
WireConnection;36;1;33;2
WireConnection;6;0;10;0
WireConnection;6;1;5;0
WireConnection;4;0;3;0
WireConnection;4;1;21;0
WireConnection;43;0;49;0
WireConnection;43;1;42;0
WireConnection;53;0;28;0
WireConnection;53;1;54;0
WireConnection;26;0;28;0
WireConnection;26;1;29;0
WireConnection;2;2;53;0
WireConnection;2;11;43;0
ASEEND*/
//CHKSM=113BBA9CD5126A64840F180E78E45D6965A03B43