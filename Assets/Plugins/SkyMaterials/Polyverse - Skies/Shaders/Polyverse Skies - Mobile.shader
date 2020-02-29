// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Polyverse/Skies - Mobile"
{
	Properties
	{
		[Header(Sky Gradient)]_SkyColor("Sky Color", Color) = (0.4980392,0.7450981,1,1)
		_EquatorColor("Equator Color", Color) = (1,0.747,0,1)
		_GroundColor("Ground Color", Color) = (0.4980392,0.497,0,1)
		_EquatorHeight("Equator Height", Range(0 , 1)) = 0.5
		_EquatorSmoothness("Equator Smoothness", Range(0.01 , 1)) = 0.5

		[Header(Stars)][Toggle]_EnableStars("Enable Stars", Int) = 0
		[NoScaleOffset]_StarsCubemap("Stars Cubemap", CUBE) = "white" {}
		_StarsSize("Stars Size", Range(0 , 0.99)) = 0.5
		_StarsIntensity("Stars Intensity", Range(0 , 5)) = 2
		_StarsHeightMask("Stars Height Mask", Range(0 , 1)) = 0

		[Header(Sun)][Toggle]_EnableSun("Enable Sun", Int) = 0
		[NoScaleOffset]_SunTexture("Sun Texture", 2D) = "black" {}
		_SunSize("Sun Size", Range(0.1 , 1)) = 0.5
		_SunColor("Sun Color", Color) = (1,1,1,1)
		_SunIntensity("Sun Intensity", Range(1 , 10)) = 1

		[Header(Clouds)][Toggle]_EnableClouds("Enable Clouds", Int) = 0
		[NoScaleOffset]_CloudsCubemap("Clouds Cubemap", CUBE) = "black" {}
		_CloudsHeight("Clouds Height", Range(-0.5 , 0.5)) = 0
		_CloudsLightColor("Clouds Light Color", Color) = (1,1,1,1)
		_CloudsShadowColor("Clouds Shadow Color", Color) = (0.4980392,0.7450981,1,1)

		[Header(Builtin Fog)][Toggle]_EnableBuiltinFog("Enable Fog", Int) = 0
		_FogHeight("Fog Height", Range(0 , 1)) = 0
		_FogSmoothness("Fog Smoothness", Range(0.01 , 1)) = 0
		_FogFill("Fog Fill", Range(0 , 1)) = 0
		[HideInInspector] __dirty("", Int) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  "PreviewType"="Skybox" }
		Cull Off
		ZWrite Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 2.0
		#pragma shader_feature _ENABLEBUILTINFOG_ON
		#pragma shader_feature _ENABLECLOUDS_ON
		#pragma shader_feature _ENABLESUN_ON
		#pragma shader_feature _ENABLESTARS_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float vertexToFrag856;
			float3 vertexToFrag763;
			float2 vertexToFrag993;
			float vertexToFrag997;
			float3 vertexToFrag1133;
		};

		uniform fixed4 _EquatorColor;
		uniform fixed4 _GroundColor;
		uniform fixed4 _SkyColor;
		uniform fixed _EquatorHeight;
		uniform fixed _EquatorSmoothness;
		uniform fixed _StarsHeightMask;
		uniform samplerCUBE _StarsCubemap;
		uniform fixed _StarsSize;
		uniform half _StarsIntensity;
		uniform sampler2D _SunTexture;
		uniform fixed3 GlobalSunDirection;
		uniform fixed _SunSize;
		uniform fixed4 _SunColor;
		uniform half _SunIntensity;
		uniform fixed4 _CloudsShadowColor;
		uniform fixed4 _CloudsLightColor;
		uniform samplerCUBE _CloudsCubemap;
		uniform fixed _CloudsHeight;
		uniform fixed _FogHeight;
		uniform fixed _FogSmoothness;
		uniform fixed _FogFill;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 normalizeResult825 = normalize( ase_worldPos );
			#ifdef _ENABLESTARS_ON
				float staticSwitch1166 = saturate( (0.1 + (abs( normalizeResult825.y ) - 0.0) * (1.0 - 0.1) / (_StarsHeightMask - 0.0)) );
			#else
				float staticSwitch1166 = 0;
			#endif
			o.vertexToFrag856 = staticSwitch1166;
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			fixed CAMERA_MODE300 = lerpResult268;
			float3 appendResult675 = (float3(ase_worldPos.x , ( ase_worldPos.y * CAMERA_MODE300 ) , ase_worldPos.z));
			#ifdef _ENABLESTARS_ON
				float3 staticSwitch1165 = appendResult675;
			#else
				float3 staticSwitch1165 = float3( 0,0,0 );
			#endif
			o.vertexToFrag763 = staticSwitch1165;
			float3 temp_output_962_0 = cross( GlobalSunDirection , fixed3(0,1,0) );
			float3 normalizeResult967 = normalize( temp_output_962_0 );
			float3 normalizeResult966 = normalize( ase_worldPos );
			float dotResult968 = dot( normalizeResult967 , normalizeResult966 );
			fixed3 GlobalSunDirection1005 = GlobalSunDirection;
			float3 normalizeResult965 = normalize( cross( GlobalSunDirection1005 , temp_output_962_0 ) );
			float dotResult969 = dot( normalizeResult965 , normalizeResult966 );
			float2 appendResult970 = (float2(dotResult968 , dotResult969));
			float2 appendResult980 = (float2(appendResult970.x , ( appendResult970.y * CAMERA_MODE300 )));
			float2 temp_cast_0 = (-1.0).xx;
			float2 temp_cast_1 = (1.0).xx;
			float2 temp_cast_2 = (0.0).xx;
			float2 temp_cast_3 = (1.0).xx;
			#ifdef _ENABLESUN_ON
				float2 staticSwitch1168 = (temp_cast_2 + (( appendResult980 * (20.0 + (_SunSize - 0.1) * (2.0 - 20.0) / (1.0 - 0.1)) ) - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0));
			#else
				float2 staticSwitch1168 = float2( 0,0 );
			#endif
			o.vertexToFrag993 = staticSwitch1168;
			float dotResult988 = dot( GlobalSunDirection1005 , ase_worldPos );
			#ifdef _ENABLESUN_ON
				float staticSwitch1169 = saturate( dotResult988 );
			#else
				float staticSwitch1169 = 0;
			#endif
			o.vertexToFrag997 = staticSwitch1169;
			float3 normalizeResult1150 = normalize( ase_worldPos );
			float3 appendResult246 = (float3(normalizeResult1150.x , ( ( normalizeResult1150.y + ( _CloudsHeight * -1.0 ) ) * CAMERA_MODE300 ) , normalizeResult1150.z));
			#ifdef _ENABLECLOUDS_ON
				float3 staticSwitch1163 = appendResult246;
			#else
				float3 staticSwitch1163 = float3( 0,0,0 );
			#endif
			o.vertexToFrag1133 = staticSwitch1163;
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult180 = lerp( _GroundColor , _SkyColor , saturate( ase_worldPos.y ));
			float3 normalizeResult179 = normalize( ase_worldPos );
			float4 lerpResult288 = lerp( _EquatorColor , lerpResult180 , saturate( pow( (0.0 + (abs( normalizeResult179.y ) - 0.0) * (1.0 - 0.0) / (_EquatorHeight - 0.0)) , ( 1.0 - _EquatorSmoothness ) ) ));
			fixed4 SKY218 = lerpResult288;
			half STARS630 = ( floor( ( i.vertexToFrag856 * ( texCUBE( _StarsCubemap, i.vertexToFrag763 ).g + _StarsSize ) ) ) * _StarsIntensity );
			#ifdef _ENABLESTARS_ON
				float4 staticSwitch1170 = ( SKY218 + STARS630 );
			#else
				float4 staticSwitch1170 = SKY218;
			#endif
			float4 tex2DNode995 = tex2D( _SunTexture, i.vertexToFrag993 );
			fixed4 SUN1004 = ( tex2DNode995.r * _SunColor * _SunIntensity );
			fixed SUN_MASK1003 = ( tex2DNode995.a * i.vertexToFrag997 );
			float4 lerpResult176 = lerp( staticSwitch1170 , SUN1004 , SUN_MASK1003);
			#ifdef _ENABLESUN_ON
				float4 staticSwitch1167 = lerpResult176;
			#else
				float4 staticSwitch1167 = staticSwitch1170;
			#endif
			float4 texCUBENode41 = texCUBE( _CloudsCubemap, i.vertexToFrag1133 );
			float4 lerpResult101 = lerp( _CloudsShadowColor , _CloudsLightColor , texCUBENode41.g);
			fixed4 CLOUDS222 = lerpResult101;
			fixed CLOUDS_MASK223 = texCUBENode41.a;
			float4 lerpResult227 = lerp( staticSwitch1167 , CLOUDS222 , CLOUDS_MASK223);
			#ifdef _ENABLECLOUDS_ON
				float4 staticSwitch1162 = lerpResult227;
			#else
				float4 staticSwitch1162 = staticSwitch1167;
			#endif
			float3 normalizeResult319 = normalize( ase_worldPos );
			float lerpResult678 = lerp( saturate( pow( (0.0 + (abs( normalizeResult319.y ) - 0.0) * (1.0 - 0.0) / (_FogHeight - 0.0)) , ( 1.0 - _FogSmoothness ) ) ) , 0.0 , _FogFill);
			fixed FOG_MASK359 = lerpResult678;
			float4 lerpResult317 = lerp( unity_FogColor , staticSwitch1162 , FOG_MASK359);
			#ifdef _ENABLEBUILTINFOG_ON
				float4 staticSwitch921 = lerpResult317;
			#else
				float4 staticSwitch921 = staticSwitch1162;
			#endif
			o.Emission = staticSwitch921.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=15001
1927;29;1906;1014;6065.32;5524.656;9.432011;True;False
Node;AmplifyShaderEditor.CommentaryNode;1006;-944,-1072;Float;False;3049;613;Calculate Sun Position;28;1025;989;1024;1023;1022;985;981;980;1020;976;973;1019;975;1021;971;970;968;969;967;966;965;963;964;962;1005;938;972;961;SUN;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;431;-944,-3632;Float;False;860;219;Switch between Perspective / Orthographic camera;4;268;309;267;1007;CAMERA MODE;1,0,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;938;-896,-1024;Fixed;False;Global;GlobalSunDirection;GlobalSunDirection;38;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;961;-896,-864;Fixed;False;Constant;_Vector2;Vector 2;9;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OrthoParams;267;-896,-3584;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CrossProductOpNode;962;-576,-896;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1007;-448,-3584;Fixed;False;Constant;_Float7;Float 7;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1005;-640,-1024;Fixed;False;GlobalSunDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;952;976,-1840;Float;False;1849;373;Stars Horizon Height Mask;11;824;825;826;828;831;832;822;954;1017;1171;1018;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;309;-592,-3584;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;432;-48,-3632;Float;False;305;165;CAMERA MODE OUTPUT;1;300;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CrossProductOpNode;964;-384,-1024;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;963;-896,-640;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;268;-256,-3584;Float;False;3;0;FLOAT;1;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1157;-946,-1844;Float;False;1259;361;Stars Cubemaps Coords;5;946;672;674;673;675;STARS;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;824;1024,-1792;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;674;-896,-1600;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;672;-896,-1792;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;967;-384,-896;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;965;-192,-1024;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;300;0,-3584;Fixed;False;CAMERA_MODE;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;966;-384,-640;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;479;-944,-2992;Float;False;1505;743;Color Gradient Calculation;13;178;179;185;287;210;212;471;475;470;208;211;1009;1008;SKY;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;825;1232,-1792;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;178;-896,-2944;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;673;-640,-1616;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;826;1408,-1792;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DotProductOpNode;968;0,-896;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;969;0,-1024;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;179;-640,-2944;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;946;-258,-1794;Float;False;521;188;Per Vertex;2;763;1165;;1,0,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;1648,-1696;Fixed;False;Constant;_Float0;Float 0;47;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;831;1600,-1600;Fixed;False;Property;_StarsHeightMask;Stars Height Mask;9;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;828;1664,-1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;675;-448,-1792;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1018;1408,-1600;Fixed;False;Constant;_Float18;Float 18;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;970;160,-1024;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1017;1408,-1680;Fixed;False;Constant;_Float17;Float 17;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;972;320,-1024;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;1154;-944,-48;Float;False;1851;485;Clouds Coordinates;11;1153;238;1150;245;246;241;1090;278;244;1152;1151;CLOUDS;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;832;1920,-1792;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;971;320,-896;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1165;-208,-1744;Float;False;Property;_EnableStars;Enable Stars;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;185;-448,-2944;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;212;-384,-2496;Fixed;False;Property;_EquatorHeight;Equator Height;3;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1020;352,-656;Half;False;Constant;_Float20;Float 20;47;0;Create;True;0;0;False;0;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1008;-384,-2688;Fixed;False;Constant;_Float8;Float 8;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;287;-192,-2944;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;954;2256,-1792;Float;False;521;188;Per Vertex;2;856;1166;;1,0,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1019;352,-736;Fixed;False;Constant;_Float19;Float 19;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;822;2112,-1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1021;352,-576;Fixed;False;Constant;_Float21;Float 21;47;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1159;334,-1842;Float;False;371;357;Stars Cubemap;2;564;619;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;973;352,-816;Fixed;False;Constant;_Float4;Float 4;36;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;471;-384,-2368;Fixed;False;Property;_EquatorSmoothness;Equator Smoothness;4;0;Create;True;0;0;False;0;0.5;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;976;640,-928;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1009;-384,-2608;Fixed;False;Constant;_Float9;Float 9;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;238;-896,0;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.VertexToFragmentNode;763;48,-1728;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;975;0,-768;Fixed;False;Property;_SunSize;Sun Size;12;0;Create;True;0;0;False;0;0.5;0;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;980;832,-1024;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1090;-896,320;Fixed;False;Constant;_Float31;Float 31;53;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;1150;-688,0;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;210;0,-2560;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;475;-64,-2368;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;981;640,-768;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;1;False;3;FLOAT;20;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1166;2305.3,-1744;Float;False;Property;_EnableStars;Enable Stars;6;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;619;384,-1600;Fixed;False;Property;_StarsSize;Stars Size;7;0;Create;True;0;0;False;0;0.5;0;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;241;-896,192;Fixed;False;Property;_CloudsHeight;Clouds Height;17;0;Create;True;0;0;False;0;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1026;2768,-816;Float;False;1161;357;Direction Negative Z Mask;5;1029;994;988;1028;984;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;564;384,-1792;Float;True;Property;_StarsCubemap;Stars Cubemap;6;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldPosInputsNode;984;2816,-640;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;480;592,-2992;Float;False;874;736;Color Gradient Colors;7;180;181;288;417;303;194;182;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;211;-640,-2448;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1022;1024,-896;Fixed;False;Constant;_Float5;Float 5;47;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-512,256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1024;1024,-736;Fixed;False;Constant;_Float22;Float 22;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1023;1024,-816;Fixed;False;Constant;_Float6;Float 6;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;985;1024,-1024;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1028;2816,-768;Float;False;1005;0;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;245;-512,0;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.VertexToFragmentNode;856;2560,-1728;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;626;768,-1552;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;470;224,-2384;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;182;640,-2592;Fixed;False;Property;_SkyColor;Sky Color;0;0;Create;True;0;0;False;0;0.4980392,0.7450981,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;303;896,-2448;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;989;1280,-1024;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;700;-944,848;Float;False;1898;485;Fog Coords on Screen;15;318;319;320;313;325;314;315;329;677;316;678;679;1108;1109;1110;BUILT-IN FOG;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;988;3072,-768;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;194;640,-2768;Fixed;False;Property;_GroundColor;Ground Color;2;0;Create;True;0;0;False;0;0.4980392,0.497,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;244;-256,192;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;876;2944,-1584;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1152;-256,320;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;208;384,-2368;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1025;1520,-1024;Float;False;505;188;Per Vertex;2;993;1168;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1029;3376,-768;Float;False;489;188;Per Vertex;2;997;1169;;1,0,1,1;0;0
Node;AmplifyShaderEditor.RelayNode;417;1152,-2368;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;181;640,-2944;Fixed;False;Property;_EquatorColor;Equator Color;1;0;Create;True;0;0;False;0;1,0.747,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;994;3232,-768;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;629;3200,-1664;Half;False;Property;_StarsIntensity;Stars Intensity;8;0;Create;True;0;0;False;0;2;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1168;1568,-976;Float;False;Property;_EnableSun;Enable Sun;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;318;-896,896;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;180;1024,-2752;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FloorOpNode;886;3200,-1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1151;0,192;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;420;1616,-2992;Float;False;293;165;SKY OUTPUT;1;218;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;916;3792,-1840;Float;False;293;165;STARS OUTPUT;1;630;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1161;-946,-4530;Float;False;2533;485;;16;632;220;631;1112;1111;176;229;228;227;436;312;317;921;1162;1167;1170;FINAL COLOR;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;319;-640,896;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;288;1280,-2944;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexToFragmentNode;993;1808,-960;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;246;128,0;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;991;2128,-1072;Float;False;603;613;Sun Texture, Color and Intensity;4;995;1002;996;998;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;882;3536,-1792;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1169;3424,-720;Float;False;Property;_EnableSun;Enable Sun;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1153;336,32;Float;False;521;188;Per Vertex;2;1133;1163;;1,0,1,1;0;0
Node;AmplifyShaderEditor.VertexToFragmentNode;997;3664,-704;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;632;-896,-4160;Float;False;630;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;630;3840,-1792;Half;False;STARS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;320;-448,896;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;996;2176,-576;Half;False;Property;_SunIntensity;Sun Intensity;14;0;Create;True;0;0;False;0;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1163;384,80;Float;False;Property;_EnableClouds;Enable Clouds;15;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;220;-896,-4480;Float;False;218;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;1664,-2944;Fixed;False;SKY;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;995;2176,-1024;Float;True;Property;_SunTexture;Sun Texture;11;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;998;2176,-768;Fixed;False;Property;_SunColor;Sun Color;13;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;314;-128,896;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;631;-560,-4352;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;325;-896,1216;Fixed;False;Property;_FogSmoothness;Fog Smoothness;22;0;Create;True;0;0;False;0;0;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1000;4304,-1072;Float;False;293;165;SUN OUTPUT;1;1004;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1133;640,96;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1001;4096,-928;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1108;-128,1024;Fixed;False;Constant;_Float39;Float 39;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1002;2560,-1024;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;999;4304,-816;Float;False;293;165;SUN OUTPUT MASK;1;1003;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;313;-896,1088;Fixed;False;Property;_FogHeight;Fog Height;21;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-128,1120;Fixed;False;Constant;_Float40;Float 40;55;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1155;976,-48;Float;False;678;293;Clouds Cubemap;2;223;41;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;914;1744,-48;Float;False;618;496;Cloud Colors;3;232;261;101;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;329;128,1216;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1003;4352,-768;Fixed;False;SUN_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1004;4352,-1024;Fixed;False;SUN;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;315;64,896;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;232;1792,0;Fixed;False;Property;_CloudsShadowColor;Clouds Shadow Color;19;0;Create;True;0;0;False;0;0.4980392,0.7450981,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;261;1792,224;Fixed;False;Property;_CloudsLightColor;Clouds Light Color;18;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;1170;-384,-4480;Float;False;Property;_EnableStars;Enable Stars;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1111;-384,-4160;Float;False;1003;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1112;-384,-4256;Float;False;1004;0;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;41;1024,0;Float;True;Property;_CloudsCubemap;Clouds Cubemap;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;176;-64,-4352;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;677;320,896;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;915;2512,-48;Float;False;293;165;CLOUDS OUTPUT;1;222;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;101;2176,0;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;128,-4160;Float;False;223;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;316;512,896;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;128,-4256;Float;False;222;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1110;512,1088;Fixed;False;Constant;_Float41;Float 41;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;1408,128;Fixed;False;CLOUDS_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;679;512,1216;Fixed;False;Property;_FogFill;Fog Fill;23;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;2560,0;Fixed;False;CLOUDS;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1167;128,-4480;Float;False;Property;_EnableSun;Enable Sun;10;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;678;768,896;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;699;1104,848;Float;False;293;165;FOG_MASK OUTPUT;1;359;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;227;448,-4352;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;312;640,-4256;Float;False;unity_FogColor;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;1152,896;Fixed;False;FOG_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;436;640,-4160;Float;False;359;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1162;640,-4480;Float;False;Property;_EnableClouds;Enable Clouds;14;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;317;1024,-4352;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;921;1280,-4480;Float;False;Property;_EnableBuiltinFog;Enable Built-in Fog;20;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;1792,-4480;Float;False;True;0;Float;;0;0;Unlit;BOXOPHOBIC/Polyverse/Skies - Mobile;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;False;Off;2;False;-1;0;False;-1;False;0;0;False;0;Custom;0;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;24;-1;-1;-1;0;1;PreviewType=Skybox;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;962;0;938;0
WireConnection;962;1;961;0
WireConnection;1005;0;938;0
WireConnection;309;0;267;2
WireConnection;309;1;267;1
WireConnection;964;0;1005;0
WireConnection;964;1;962;0
WireConnection;268;0;1007;0
WireConnection;268;1;309;0
WireConnection;268;2;267;4
WireConnection;967;0;962;0
WireConnection;965;0;964;0
WireConnection;300;0;268;0
WireConnection;966;0;963;0
WireConnection;825;0;824;0
WireConnection;673;0;672;2
WireConnection;673;1;674;0
WireConnection;826;0;825;0
WireConnection;968;0;967;0
WireConnection;968;1;966;0
WireConnection;969;0;965;0
WireConnection;969;1;966;0
WireConnection;179;0;178;0
WireConnection;828;0;826;1
WireConnection;675;0;672;1
WireConnection;675;1;673;0
WireConnection;675;2;672;3
WireConnection;970;0;968;0
WireConnection;970;1;969;0
WireConnection;972;0;970;0
WireConnection;832;0;828;0
WireConnection;832;1;1017;0
WireConnection;832;2;831;0
WireConnection;832;3;1171;0
WireConnection;832;4;1018;0
WireConnection;1165;0;675;0
WireConnection;185;0;179;0
WireConnection;287;0;185;1
WireConnection;822;0;832;0
WireConnection;976;0;972;1
WireConnection;976;1;971;0
WireConnection;763;0;1165;0
WireConnection;980;0;972;0
WireConnection;980;1;976;0
WireConnection;1150;0;238;0
WireConnection;210;0;287;0
WireConnection;210;1;1008;0
WireConnection;210;2;212;0
WireConnection;210;3;1008;0
WireConnection;210;4;1009;0
WireConnection;475;0;471;0
WireConnection;981;0;975;0
WireConnection;981;1;973;0
WireConnection;981;2;1019;0
WireConnection;981;3;1020;0
WireConnection;981;4;1021;0
WireConnection;1166;0;822;0
WireConnection;564;1;763;0
WireConnection;211;0;178;2
WireConnection;278;0;241;0
WireConnection;278;1;1090;0
WireConnection;985;0;980;0
WireConnection;985;1;981;0
WireConnection;245;0;1150;0
WireConnection;856;0;1166;0
WireConnection;626;0;564;2
WireConnection;626;1;619;0
WireConnection;470;0;210;0
WireConnection;470;1;475;0
WireConnection;303;0;211;0
WireConnection;989;0;985;0
WireConnection;989;1;1022;0
WireConnection;989;2;1024;0
WireConnection;989;3;1023;0
WireConnection;989;4;1024;0
WireConnection;988;0;1028;0
WireConnection;988;1;984;0
WireConnection;244;0;245;1
WireConnection;244;1;278;0
WireConnection;876;0;856;0
WireConnection;876;1;626;0
WireConnection;208;0;470;0
WireConnection;417;0;208;0
WireConnection;994;0;988;0
WireConnection;1168;0;989;0
WireConnection;180;0;194;0
WireConnection;180;1;182;0
WireConnection;180;2;303;0
WireConnection;886;0;876;0
WireConnection;1151;0;244;0
WireConnection;1151;1;1152;0
WireConnection;319;0;318;0
WireConnection;288;0;181;0
WireConnection;288;1;180;0
WireConnection;288;2;417;0
WireConnection;993;0;1168;0
WireConnection;246;0;245;0
WireConnection;246;1;1151;0
WireConnection;246;2;245;2
WireConnection;882;0;886;0
WireConnection;882;1;629;0
WireConnection;1169;0;994;0
WireConnection;997;0;1169;0
WireConnection;630;0;882;0
WireConnection;320;0;319;0
WireConnection;1163;0;246;0
WireConnection;218;0;288;0
WireConnection;995;1;993;0
WireConnection;314;0;320;1
WireConnection;631;0;220;0
WireConnection;631;1;632;0
WireConnection;1133;0;1163;0
WireConnection;1001;0;995;4
WireConnection;1001;1;997;0
WireConnection;1002;0;995;1
WireConnection;1002;1;998;0
WireConnection;1002;2;996;0
WireConnection;329;0;325;0
WireConnection;1003;0;1001;0
WireConnection;1004;0;1002;0
WireConnection;315;0;314;0
WireConnection;315;1;1108;0
WireConnection;315;2;313;0
WireConnection;315;3;1108;0
WireConnection;315;4;1109;0
WireConnection;1170;1;220;0
WireConnection;1170;0;631;0
WireConnection;41;1;1133;0
WireConnection;176;0;1170;0
WireConnection;176;1;1112;0
WireConnection;176;2;1111;0
WireConnection;677;0;315;0
WireConnection;677;1;329;0
WireConnection;101;0;232;0
WireConnection;101;1;261;0
WireConnection;101;2;41;2
WireConnection;316;0;677;0
WireConnection;223;0;41;4
WireConnection;222;0;101;0
WireConnection;1167;1;1170;0
WireConnection;1167;0;176;0
WireConnection;678;0;316;0
WireConnection;678;1;1110;0
WireConnection;678;2;679;0
WireConnection;227;0;1167;0
WireConnection;227;1;228;0
WireConnection;227;2;229;0
WireConnection;359;0;678;0
WireConnection;1162;1;1167;0
WireConnection;1162;0;227;0
WireConnection;317;0;312;0
WireConnection;317;1;1162;0
WireConnection;317;2;436;0
WireConnection;921;1;1162;0
WireConnection;921;0;317;0
WireConnection;26;2;921;0
ASEEND*/
//CHKSM=2B77E77C65A4A4BC9611431B86C1B234D25832BB