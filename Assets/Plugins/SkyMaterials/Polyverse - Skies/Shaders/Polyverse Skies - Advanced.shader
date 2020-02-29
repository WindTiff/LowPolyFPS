// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Polyverse/Skies - Advanced"
{
	Properties
	{
		[Header(Sky Gradient)] _SkyColor("Sky Color", Color) = (0.4980392,0.7450981,1,1)
		_EquatorColor("Equator Color", Color) = (1,0.747,0,1)
		_GroundColor("Ground Color", Color) = (0.4980392,0.497,0,1)
		_EquatorHeight("Equator Height", Range(0 , 1)) = 0.5
		_EquatorSmoothness("Equator Smoothness", Range(0.01 , 1)) = 0.5

		[Header(Sky Pattern Overlay)][Toggle]_EnablePatternOverlay("Enable Pattern Overlay", Int) = 0
		[NoScaleOffset]_PatternCubemap("Pattern Cubemap", CUBE) = "black" {}
		_PatternContrast("Pattern Contrast", Range(0 , 2)) = 0.5
		[Header(Stars)][Toggle]_EnableStars("Enable Stars", Int) = 0
		[NoScaleOffset]_StarsCubemap("Stars Cubemap", CUBE) = "white" {}
		[IntRange]_StarsLayer("Stars Layer", Range(1 , 3)) = 2
		_StarsSize("Stars Size", Range(0 , 0.99)) = 0.5
		_StarsIntensity("Stars Intensity", Range(0 , 5)) = 2
		_StarsSunMask("Stars Sun Mask", Range(0 , 1)) = 0
		_StarsHeightMask("Stars Height Mask", Range(0 , 1)) = 0

		[Space(10)][Toggle]_EnableStarsTwinkling("Enable Stars Twinkling", Int) = 0
		[NoScaleOffset]_TwinklingTexture("Twinkling Texture", 2D) = "white" {}
		_TwinklingContrast("Twinkling Contrast", Range(0 , 1)) = 1
		_TwinklingSpeed("Twinkling Speed", Float) = 0.05

		[Header(Sun)][Toggle]_EnableSun("Enable Sun", Int) = 0
		[NoScaleOffset]_SunTexture("Sun Texture", 2D) = "black" {}
		_SunSize("Sun Size", Range(0.1 , 1)) = 0.5
		_SunColor("Sun Color", Color) = (1,1,1,1)
		_SunIntensity("Sun Intensity", Range(1 , 10)) = 1

		[Header(Moon)][Toggle]_EnableMoon("Enable Moon", Int) = 0
		[NoScaleOffset]_MoonTexture("Moon Texture", 2D) = "black" {}
		_MoonSize("Moon Size", Range(0.1 , 1)) = 0.5
		_MoonColor("Moon Color", Color) = (1,1,1,1)
		_MoonIntensity("Moon Intensity", Range(1 , 10)) = 1

		[Header(Clouds)][Toggle]_EnableClouds("Enable Clouds", Int) = 0
		[NoScaleOffset]_CloudsCubemap("Clouds Cubemap", CUBE) = "black" {}
		_CloudsHeight("Clouds Height", Range(-0.5 , 0.5)) = 0
		_CloudsLightColor("Clouds Light Color", Color) = (1,1,1,1)
		_CloudsShadowColor("Clouds Shadow Color", Color) = (0.4980392,0.7450981,1,1)
		[Toggle]_CloudsLitbySun("Clouds Lit by Sun", Int) = 0

		[Space(10)][Toggle]_EnableCloudsRotation("Enable Clouds Rotation", Int) = 0
		[IntRange]_CloudsRotation("Clouds Rotation", Range(0 , 360)) = 360
		_CloudsRotationSpeed("Clouds Rotation Speed", Float) = 0.5

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
		#pragma target 3.0
		#pragma shader_feature _ENABLEBUILTINFOG_ON
		#pragma shader_feature _ENABLECLOUDS_ON
		#pragma shader_feature _ENABLEMOON_ON
		#pragma shader_feature _ENABLESUN_ON
		#pragma shader_feature _ENABLESTARS_ON
		#pragma shader_feature _ENABLEPATTERNOVERLAY_ON
		#pragma shader_feature _ENABLESTARSTWINKLING_ON
		#pragma shader_feature _CLOUDSLITBYSUN_ON
		#pragma shader_feature _ENABLECLOUDSROTATION_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float vertexToFrag762;
			float3 vertexToFrag763;
			float vertexToFrag856;
			float2 vertexToFrag761;
			float2 vertexToFrag993;
			float vertexToFrag997;
			float2 vertexToFrag1043;
			float vertexToFrag1051;
			float3 vertexToFrag774;
			float3 vertexToFrag775;
			float3 vertexToFrag776;
		};

		uniform fixed4 _EquatorColor;
		uniform fixed4 _GroundColor;
		uniform fixed4 _SkyColor;
		uniform fixed _EquatorHeight;
		uniform fixed _EquatorSmoothness;
		uniform fixed _PatternContrast;
		uniform samplerCUBE _PatternCubemap;
		uniform fixed3 GlobalSunDirection;
		uniform fixed _StarsSunMask;
		uniform samplerCUBE _StarsCubemap;
		uniform fixed _StarsLayer;
		uniform fixed _StarsSize;
		uniform fixed _StarsHeightMask;
		uniform sampler2D _TwinklingTexture;
		uniform fixed _TwinklingSpeed;
		uniform fixed _TwinklingContrast;
		uniform half _StarsIntensity;
		uniform sampler2D _SunTexture;
		uniform fixed _SunSize;
		uniform fixed4 _SunColor;
		uniform half _SunIntensity;
		uniform sampler2D _MoonTexture;
		uniform fixed3 GlobalMoonDirection;
		uniform fixed _MoonSize;
		uniform fixed4 _MoonColor;
		uniform half _MoonIntensity;
		uniform fixed4 _CloudsShadowColor;
		uniform fixed4 _CloudsLightColor;
		uniform samplerCUBE _CloudsCubemap;
		uniform half _CloudsRotation;
		uniform fixed _CloudsRotationSpeed;
		uniform fixed _CloudsHeight;
		uniform fixed _FogHeight;
		uniform fixed _FogSmoothness;
		uniform fixed _FogFill;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			fixed3 GlobalSunDirection1005 = GlobalSunDirection;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult732 = dot( GlobalSunDirection1005 , ase_worldViewDir );
			#ifdef _ENABLESTARS_ON
				float staticSwitch947 = saturate( (0.0 + (dotResult732 - -1.0) * (1.0 - 0.0) / (-( 1.0 - _StarsSunMask ) - -1.0)) );
			#else
				float staticSwitch947 = 0;
			#endif
			o.vertexToFrag762 = staticSwitch947;
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			fixed CAMERA_MODE300 = lerpResult268;
			float3 appendResult675 = (float3(ase_worldPos.x , ( ase_worldPos.y * CAMERA_MODE300 ) , ase_worldPos.z));
			#ifdef _ENABLESTARS_ON
				float3 staticSwitch941 = appendResult675;
			#else
				float3 staticSwitch941 = float3( 0,0,0 );
			#endif
			o.vertexToFrag763 = staticSwitch941;
			float3 normalizeResult825 = normalize( ase_worldPos );
			#ifdef _ENABLESTARS_ON
				float staticSwitch953 = saturate( (0.1 + (abs( normalizeResult825.y ) - 0.0) * (1.0 - 0.1) / (_StarsHeightMask - 0.0)) );
			#else
				float staticSwitch953 = 0;
			#endif
			o.vertexToFrag856 = staticSwitch953;
			float mulTime633 = _Time.y * 1;
			float2 temp_cast_0 = (_TwinklingSpeed).xx;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult568 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 panner569 = ( appendResult568 + mulTime633 * temp_cast_0);
			#ifdef _ENABLESTARS_ON
				float2 staticSwitch956 = panner569;
			#else
				float2 staticSwitch956 = float2( 0,0 );
			#endif
			o.vertexToFrag761 = staticSwitch956;
			float3 temp_output_962_0 = cross( GlobalSunDirection , fixed3(0,1,0) );
			float3 normalizeResult967 = normalize( temp_output_962_0 );
			float3 normalizeResult966 = normalize( ase_worldPos );
			float dotResult968 = dot( normalizeResult967 , normalizeResult966 );
			float3 normalizeResult965 = normalize( cross( GlobalSunDirection1005 , temp_output_962_0 ) );
			float dotResult969 = dot( normalizeResult965 , normalizeResult966 );
			float2 appendResult970 = (float2(dotResult968 , dotResult969));
			float2 appendResult980 = (float2(appendResult970.x , ( appendResult970.y * CAMERA_MODE300 )));
			float2 temp_cast_1 = (-1.0).xx;
			float2 temp_cast_2 = (1.0).xx;
			float2 temp_cast_3 = (0.0).xx;
			float2 temp_cast_4 = (1.0).xx;
			#ifdef _ENABLESUN_ON
				float2 staticSwitch940 = (temp_cast_3 + (( appendResult980 * (20.0 + (_SunSize - 0.1) * (2.0 - 20.0) / (1.0 - 0.1)) ) - temp_cast_1) * (temp_cast_4 - temp_cast_3) / (temp_cast_2 - temp_cast_1));
			#else
				float2 staticSwitch940 = float2( 0,0 );
			#endif
			o.vertexToFrag993 = staticSwitch940;
			float dotResult988 = dot( GlobalSunDirection1005 , ase_worldPos );
			#ifdef _ENABLESUN_ON
				float staticSwitch1027 = saturate( dotResult988 );
			#else
				float staticSwitch1027 = 0;
			#endif
			o.vertexToFrag997 = staticSwitch1027;
			float3 temp_output_1058_0 = cross( GlobalMoonDirection , fixed3(0,1,0) );
			float3 normalizeResult1039 = normalize( temp_output_1058_0 );
			float3 normalizeResult1037 = normalize( ase_worldPos );
			float dotResult1036 = dot( normalizeResult1039 , normalizeResult1037 );
			fixed3 GlobalMoonDirection1073 = GlobalMoonDirection;
			float3 normalizeResult1064 = normalize( cross( GlobalMoonDirection1073 , temp_output_1058_0 ) );
			float dotResult1067 = dot( normalizeResult1064 , normalizeResult1037 );
			float2 appendResult1066 = (float2(dotResult1036 , dotResult1067));
			float2 appendResult1069 = (float2(appendResult1066.x , ( appendResult1066.y * CAMERA_MODE300 )));
			float2 temp_cast_5 = (-1.0).xx;
			float2 temp_cast_6 = (1.0).xx;
			float2 temp_cast_7 = (0.0).xx;
			float2 temp_cast_8 = (1.0).xx;
			#ifdef _ENABLEMOON_ON
				float2 staticSwitch1057 = (temp_cast_7 + (( appendResult1069 * (20.0 + (_MoonSize - 0.1) * (2.0 - 20.0) / (1.0 - 0.1)) ) - temp_cast_5) * (temp_cast_8 - temp_cast_7) / (temp_cast_6 - temp_cast_5));
			#else
				float2 staticSwitch1057 = float2( 0,0 );
			#endif
			o.vertexToFrag1043 = staticSwitch1057;
			float dotResult1054 = dot( GlobalMoonDirection1073 , ase_worldPos );
			#ifdef _ENABLEMOON_ON
				float staticSwitch1052 = saturate( dotResult1054 );
			#else
				float staticSwitch1052 = 0;
			#endif
			o.vertexToFrag1051 = staticSwitch1052;
			float mulTime701 = _Time.y * 1;
			float3 appendResult56 = (float3(cos( radians( ( _CloudsRotation + ( mulTime701 * _CloudsRotationSpeed ) ) ) ) , 0.0 , ( sin( radians( ( _CloudsRotation + ( mulTime701 * _CloudsRotationSpeed ) ) ) ) * -1.0 )));
			#ifdef _ENABLECLOUDS_ON
				float3 staticSwitch1122 = appendResult56;
			#else
				float3 staticSwitch1122 = float3( 0,0,0 );
			#endif
			o.vertexToFrag774 = staticSwitch1122;
			float3 appendResult266 = (float3(0.0 , CAMERA_MODE300 , 0.0));
			#ifdef _ENABLECLOUDS_ON
				float3 staticSwitch1123 = appendResult266;
			#else
				float3 staticSwitch1123 = float3( 0,0,0 );
			#endif
			o.vertexToFrag775 = staticSwitch1123;
			float3 appendResult58 = (float3(sin( radians( ( _CloudsRotation + ( mulTime701 * _CloudsRotationSpeed ) ) ) ) , 0.0 , cos( radians( ( _CloudsRotation + ( mulTime701 * _CloudsRotationSpeed ) ) ) )));
			#ifdef _ENABLECLOUDS_ON
				float3 staticSwitch1124 = appendResult58;
			#else
				float3 staticSwitch1124 = float3( 0,0,0 );
			#endif
			o.vertexToFrag776 = staticSwitch1124;
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
			fixed4 PATTERN513 = saturate( CalculateContrast(_PatternContrast,texCUBE( _PatternCubemap, ase_worldPos )) );
			float4 blendOpSrc574 = PATTERN513;
			float4 blendOpDest574 = SKY218;
			#ifdef _ENABLEPATTERNOVERLAY_ON
				float4 staticSwitch524 = ( saturate( (( blendOpDest574 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest574 - 0.5 ) ) * ( 1.0 - blendOpSrc574 ) ) : ( 2.0 * blendOpDest574 * blendOpSrc574 ) ) ));
			#else
				float4 staticSwitch524 = SKY218;
			#endif
			float4 texCUBENode564 = texCUBE( _StarsCubemap, i.vertexToFrag763 );
			float temp_output_537_0 = (3.0 + (_StarsLayer - 1.0) * (1.0 - 3.0) / (3.0 - 1.0));
			#ifdef _ENABLESTARSTWINKLING_ON
				float staticSwitch878 = ( saturate( pow( tex2D( _TwinklingTexture, i.vertexToFrag761 ).r , _TwinklingContrast ) ) * floor( ( i.vertexToFrag762 * ( ( texCUBENode564.r + ( texCUBENode564.g * step( temp_output_537_0 , 2.0 ) ) + ( texCUBENode564.b * step( temp_output_537_0 , 1.0 ) ) ) + _StarsSize ) * i.vertexToFrag856 ) ) );
			#else
				float staticSwitch878 = floor( ( i.vertexToFrag762 * ( ( texCUBENode564.r + ( texCUBENode564.g * step( temp_output_537_0 , 2.0 ) ) + ( texCUBENode564.b * step( temp_output_537_0 , 1.0 ) ) ) + _StarsSize ) * i.vertexToFrag856 ) );
			#endif
			half STARS630 = ( staticSwitch878 * _StarsIntensity );
			#ifdef _ENABLESTARS_ON
				float4 staticSwitch918 = ( staticSwitch524 + STARS630 );
			#else
				float4 staticSwitch918 = staticSwitch524;
			#endif
			float4 tex2DNode995 = tex2D( _SunTexture, i.vertexToFrag993 );
			fixed4 SUN1004 = ( tex2DNode995.r * _SunColor * _SunIntensity );
			fixed SUN_MASK1003 = ( tex2DNode995.a * i.vertexToFrag997 );
			float4 lerpResult176 = lerp( staticSwitch918 , SUN1004 , SUN_MASK1003);
			#ifdef _ENABLESUN_ON
				float4 staticSwitch919 = lerpResult176;
			#else
				float4 staticSwitch919 = staticSwitch918;
			#endif
			float4 tex2DNode1049 = tex2D( _MoonTexture, i.vertexToFrag1043 );
			fixed4 MOON1077 = ( tex2DNode1049.r * _MoonColor * _MoonIntensity );
			fixed MOON_MASK1078 = ( tex2DNode1049.a * i.vertexToFrag1051 );
			float4 lerpResult1114 = lerp( staticSwitch919 , MOON1077 , MOON_MASK1078);
			#ifdef _ENABLEMOON_ON
				float4 staticSwitch1113 = lerpResult1114;
			#else
				float4 staticSwitch1113 = staticSwitch919;
			#endif
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			fixed CAMERA_MODE300 = lerpResult268;
			float3 appendResult1129 = (float3(ase_worldPos.x , ( ase_worldPos.y * CAMERA_MODE300 ) , ase_worldPos.z));
			float3 normalizeResult1130 = normalize( appendResult1129 );
			float3 normalizeResult247 = normalize( ase_worldPos );
			#ifdef _ENABLECLOUDSROTATION_ON
				float3 staticSwitch1164 = mul( float3x3(i.vertexToFrag774, i.vertexToFrag775, i.vertexToFrag776), normalizeResult247 );
			#else
				float3 staticSwitch1164 = normalizeResult1130;
			#endif
			float3 appendResult246 = (float3(staticSwitch1164.x , ( staticSwitch1164.y + ( _CloudsHeight * -1.0 ) ) , staticSwitch1164.z));
			float4 texCUBENode41 = texCUBE( _CloudsCubemap, appendResult246 );
			fixed Clouds_G397 = texCUBENode41.g;
			fixed3 GlobalSunDirection1005 = GlobalSunDirection;
			#ifdef _ENABLECLOUDSROTATION_ON
				float3 staticSwitch1166 = mul( float3x3(i.vertexToFrag774, i.vertexToFrag775, i.vertexToFrag776), GlobalSunDirection1005 );
			#else
				float3 staticSwitch1166 = GlobalSunDirection1005;
			#endif
			float3 normalizeResult1163 = normalize( staticSwitch1166 );
			float3 temp_cast_0 = (0.0).xxx;
			float3 temp_cast_1 = (1.0).xxx;
			float3 temp_cast_2 = (-1.0).xxx;
			float3 temp_cast_3 = (1.0).xxx;
			float dotResult89 = dot( normalizeResult1163 , (temp_cast_2 + ((texCUBENode41).rgb - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) );
			#ifdef _CLOUDSLITBYSUN_ON
				float staticSwitch391 = saturate( (0.0 + (dotResult89 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) );
			#else
				float staticSwitch391 = Clouds_G397;
			#endif
			float4 lerpResult101 = lerp( _CloudsShadowColor , _CloudsLightColor , staticSwitch391);
			fixed4 CLOUDS222 = lerpResult101;
			fixed CLOUDS_MASK223 = texCUBENode41.a;
			float4 lerpResult227 = lerp( staticSwitch1113 , CLOUDS222 , CLOUDS_MASK223);
			#ifdef _ENABLECLOUDS_ON
				float4 staticSwitch1120 = lerpResult227;
			#else
				float4 staticSwitch1120 = staticSwitch1113;
			#endif
			float3 normalizeResult319 = normalize( ase_worldPos );
			float lerpResult678 = lerp( saturate( pow( (0.0 + (abs( normalizeResult319.y ) - 0.0) * (1.0 - 0.0) / (_FogHeight - 0.0)) , ( 1.0 - _FogSmoothness ) ) ) , 0.0 , _FogFill);
			fixed FOG_MASK359 = lerpResult678;
			float4 lerpResult317 = lerp( unity_FogColor , staticSwitch1120 , FOG_MASK359);
			#ifdef _ENABLEBUILTINFOG_ON
				float4 staticSwitch921 = lerpResult317;
			#else
				float4 staticSwitch921 = staticSwitch1120;
			#endif
			o.Emission = staticSwitch921.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=15001
1927;29;1906;1014;172.306;-775.8116;2.021981;True;False
Node;AmplifyShaderEditor.CommentaryNode;1136;-946,1486;Float;False;3074.084;612.3101;Clouds Coordinates;27;1130;49;1129;54;1128;247;1127;238;58;56;1088;266;55;60;365;1081;310;61;1080;59;62;47;276;48;255;260;701;CLOUDS;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;431;-944,-4528;Float;False;860;219;Switch between Perspective / Orthographic camera;4;268;309;267;1007;CAMERA MODE;1,0,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;260;-896,1792;Fixed;False;Property;_CloudsRotationSpeed;Clouds Rotation Speed;37;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;701;-896,1664;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OrthoParams;267;-896,-4480;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-896,1536;Half;False;Property;_CloudsRotation;Clouds Rotation;36;1;[IntRange];Create;True;0;0;False;0;360;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;255;-640,1664;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;309;-592,-4480;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1007;-448,-4480;Fixed;False;Constant;_Float7;Float 7;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;276;-512,1536;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;942;-946,-1842;Float;False;2252;869;Stars Cubemap Coords and Cubemap RGB Layer;19;672;674;673;675;528;537;534;564;533;530;529;619;527;626;946;1010;1011;1012;1013;STARS;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;268;-256,-4480;Float;False;3;0;FLOAT;1;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;47;-384,1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;432;-48,-4528;Float;False;305;165;CAMERA MODE OUTPUT;1;300;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;674;-896,-1600;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;952;1360,-1328;Float;False;1849;373;Stars Horizon Height Mask;11;824;825;826;828;831;832;822;954;1017;1018;1167;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;300;0,-4480;Fixed;False;CAMERA_MODE;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;62;-224,1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;672;-896,-1792;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;824;1408,-1280;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;1006;-946,-562;Float;False;3049;613;Calculate Sun Position;28;1025;989;1024;1023;1022;985;981;980;1020;976;973;1019;975;1021;971;970;968;969;967;966;965;963;964;962;1005;938;972;961;SUN;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;949;1360,-1840;Float;False;1849;485;Stars Sun Mask;12;733;738;731;732;740;726;724;950;1014;1015;1016;1148;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SinOpNode;59;128,1600;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1080;128,1664;Fixed;False;Constant;_Float26;Float 26;50;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;673;-640,-1616;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;733;1664,-1472;Fixed;False;Property;_StarsSunMask;Stars Sun Mask;13;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;825;1616,-1280;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;938;-896,-512;Fixed;False;Global;GlobalSunDirection;GlobalSunDirection;38;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;946;-258,-1794;Float;False;521;188;Per Vertex;2;941;763;;1,0,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;961;-896,-352;Fixed;False;Constant;_Vector2;Vector 2;9;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;675;-448,-1792;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1081;128,1840;Fixed;False;Constant;_Float27;Float 27;50;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;310;128,1760;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;61;128,1920;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;365;128,1984;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;55;128,1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;320,1600;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;479;-944,-3760;Float;False;1505;743;Color Gradient Calculation;13;178;179;185;287;210;212;471;475;470;208;211;1009;1008;SKY;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;528;0,-1536;Fixed;False;Property;_StarsLayer;Stars Layer;10;1;[IntRange];Create;True;0;0;False;0;2;0;1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1011;0,-1376;Half;False;Constant;_Float11;Float 11;47;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1005;-640,-512;Fixed;False;GlobalSunDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;941;-208,-1742.622;Float;False;Property;_EnableStars;Enable Stars;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1030;-944,464;Float;False;3049;613;Calculate Moon Position;28;1075;1074;1073;1072;1071;1070;1069;1068;1067;1066;1065;1064;1063;1062;1061;1060;1058;1047;1046;1044;1042;1041;1040;1039;1038;1037;1036;1034;MOON;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1148;1408,-1792;Float;False;1005;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1010;0,-1456;Fixed;False;Constant;_Float10;Float 10;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;826;1792,-1280;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;56;512,1536;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;512,1920;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;266;512,1728;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1088;720,1536;Float;False;521;524;Per Vertex;6;775;776;774;1122;1123;1124;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;955;3408,-1840;Float;False;2267;357;Stars Twinkling ;11;567;546;568;633;569;566;555;554;756;877;957;;1,0,0,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;738;1984,-1472;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;962;-576,-384;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;731;1408,-1648;Float;False;World;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;1062;-896,672;Fixed;False;Constant;_Vector3;Vector 3;9;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScreenPosInputsNode;567;3456,-1792;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1018;1792,-1088;Fixed;False;Constant;_Float18;Float 18;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;763;48,-1728;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;964;-384,-512;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NegateNode;740;2176,-1472;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;238;1408,1760;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;831;2000,-1088;Fixed;False;Property;_StarsHeightMask;Stars Height Mask;14;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1013;384,-1264;Fixed;False;Constant;_Float13;Float 13;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;178;-896,-3712;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1127;1408,1936;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1061;-896,512;Fixed;False;Global;GlobalMoonDirection;GlobalMoonDirection;38;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1167;2032,-1184;Fixed;False;Constant;_Float0;Float 0;47;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;732;1744,-1792;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;828;2048,-1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1017;1792,-1168;Fixed;False;Constant;_Float17;Float 17;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1015;1984,-1632;Fixed;False;Constant;_Float15;Float 15;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1122;768,1584;Float;False;Property;_EnableClouds;Enable Clouds;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1124;768,1920;Float;False;Property;_EnableClouds;Enable Clouds;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1123;768,1744;Float;False;Property;_EnableClouds;Enable Clouds;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;963;-896,-128;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1014;1984,-1712;Fixed;False;Constant;_Float14;Float 14;47;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1016;1984,-1552;Fixed;False;Constant;_Float16;Float 16;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1012;384,-1344;Fixed;False;Constant;_Float12;Float 12;47;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;537;384,-1536;Float;False;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;3;False;3;FLOAT;3;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;179;-640,-3712;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;568;3712,-1792;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;832;2304,-1280;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;633;3712,-1600;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1128;1664,1920;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;533;640,-1536;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;965;-192,-512;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;967;-384,-384;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;534;640,-1408;Float;False;2;0;FLOAT;3;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;564;384,-1792;Float;True;Property;_StarsCubemap;Stars Cubemap;9;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;546;3712,-1680;Fixed;False;Property;_TwinklingSpeed;Twinkling Speed;18;0;Create;True;0;0;False;0;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;774;1024,1600;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexToFragmentNode;775;1024,1760;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexToFragmentNode;776;1024,1936;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;726;2304,-1792;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;-0.5;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;1058;-576,640;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;966;-384,-128;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1073;-640,512;Fixed;False;GlobalMoonDirection;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;185;-448,-3712;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;724;2480,-1792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;950;2640,-1792;Float;False;521;188;Per Vertex;2;947;762;;1,0,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;822;2496,-1280;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;954;2640,-1280;Float;False;521;188;Per Vertex;2;856;953;;1,0,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;969;0,-512;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1129;1792,1792;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;957;4240,-1792;Float;False;521;188;Per Vertex ;2;761;956;;1,0,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;530;832,-1536;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;569;4016,-1792;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NormalizeNode;247;1599,1667;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;54;1408,1536;Float;False;FLOAT3x3;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;529;832,-1664;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;1038;-384,512;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1060;-896,896;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;968;0,-384;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;1130;1920,1792;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1008;-384,-3456;Fixed;False;Constant;_Float8;Float 8;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;947;2688,-1744;Float;False;Property;_EnableStars;Enable Stars;9;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;970;160,-512;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;471;-384,-3136;Fixed;False;Property;_EquatorSmoothness;Equator Smoothness;4;0;Create;True;0;0;False;0;0.5;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;1064;-192,512;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1037;-384,896;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;287;-192,-3712;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;953;2688,-1232;Float;False;Property;_EnableStars;Enable Stars;9;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-384,-3264;Fixed;False;Property;_EquatorHeight;Equator Height;3;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1009;-384,-3376;Fixed;False;Constant;_Float9;Float 9;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1792,1616;Float;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;619;384,-1088;Fixed;False;Property;_StarsSize;Stars Size;11;0;Create;True;0;0;False;0;0.5;0;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;956;4288,-1744;Float;False;Property;_EnableStars;Enable Stars;9;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1091;2640,1664;Float;False;1446;423;Clouds Cubemap;9;246;41;397;223;241;278;245;1090;244;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1087;2192,1664;Float;False;394;188;Enable Clouds Rotation;1;1164;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;1039;-384,640;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;527;1024,-1792;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;639;-946,-2610;Float;False;1057;357;Pattern Overlay Texture and Contrast;5;280;254;519;283;517;PATTERN OVERLAY;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.VertexToFragmentNode;761;4544,-1728;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexToFragmentNode;856;2944,-1216;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;971;320,-384;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1164;2240,1728;Float;False;Property;_EnableCloudsRotation;Enable Clouds Rotation;35;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;241;2688,1872;Fixed;False;Property;_CloudsHeight;Clouds Height;31;0;Create;True;0;0;False;0;0;0;-0.5;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1090;2688,1968;Fixed;False;Constant;_Float31;Float 31;53;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1067;0,512;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;210;0,-3328;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;972;320,-512;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;475;-64,-3136;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;762;2944,-1728;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1036;0,640;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;626;1152,-1392;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;470;224,-3152;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1066;160,512;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1021;352,-64;Fixed;False;Constant;_Float21;Float 21;47;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;3008,1952;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;245;2688,1712;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;1019;352,-224;Fixed;False;Constant;_Float19;Float 19;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;876;3456,-1408;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;973;352,-304;Fixed;False;Constant;_Float4;Float 4;36;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;280;-896,-2560;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;211;-640,-3216;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;566;4864,-1792;Float;True;Property;_TwinklingTexture;Twinkling Texture;16;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;555;4864,-1600;Fixed;False;Property;_TwinklingContrast;Twinkling Contrast;17;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;975;0,-256;Fixed;False;Property;_SunSize;Sun Size;21;0;Create;True;0;0;False;0;0.5;0;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1020;352,-144;Half;False;Constant;_Float20;Float 20;47;0;Create;True;0;0;False;0;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;480;592,-3760;Float;False;874;736;Color Gradient Colors;7;180;181;288;417;303;194;182;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;976;640,-416;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1065;320,640;Float;False;300;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1026;2766,-306;Float;False;1161;357;Direction Negative Z Mask;5;1029;994;988;1028;984;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;283;-640,-2368;Fixed;False;Property;_PatternContrast;Pattern Contrast;7;0;Create;True;0;0;False;0;0.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;244;3152,1856;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;554;5184,-1728;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;303;896,-3216;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;886;3712,-1408;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;194;640,-3536;Fixed;False;Property;_GroundColor;Ground Color;2;0;Create;True;0;0;False;0;0.4980392,0.497,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;1063;320,512;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;182;640,-3360;Fixed;False;Property;_SkyColor;Sky Color;0;0;Create;True;0;0;False;0;0.4980392,0.7450981,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;254;-640,-2560;Float;True;Property;_PatternCubemap;Pattern Cubemap;6;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;208;384,-3136;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;981;640,-256;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;1;False;3;FLOAT;20;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1162;4176,1472;Float;False;1793;613;Light Calculation on Clouds;15;1147;126;1096;1095;1094;116;115;1097;1098;89;1099;236;104;1163;1166;;1,1,0,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;980;832,-512;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;519;-256,-2560;Float;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;640,608;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1070;352,880;Half;False;Constant;_Float29;Float 29;47;0;Create;True;0;0;False;0;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;985;1024,-512;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;246;3328,1712;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1147;4224,1616;Float;False;1005;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1071;352,720;Fixed;False;Constant;_Float30;Float 30;36;0;Create;True;0;0;False;0;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1040;352,960;Fixed;False;Constant;_Float3;Float 3;47;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;180;1024,-3520;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1023;1024,-304;Fixed;False;Constant;_Float6;Float 6;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;756;5344,-1728;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;984;2816,-128;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1046;0,768;Fixed;False;Property;_MoonSize;Moon Size;26;0;Create;True;0;0;False;0;0.5;0;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1022;1024,-384;Fixed;False;Constant;_Float5;Float 5;47;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;417;1152,-3136;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;181;640,-3712;Fixed;False;Property;_EquatorColor;Equator Color;1;0;Create;True;0;0;False;0;1,0.747,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1024;1024,-224;Fixed;False;Constant;_Float22;Float 22;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;881;5344,-1408;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1028;2816,-256;Float;False;1005;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1047;352,800;Fixed;False;Constant;_Float28;Float 28;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;958;5712,-1840;Float;False;393;188;Enable Stars Twinkling;1;878;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;4544,1520;Float;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;41;3520,1712;Float;True;Property;_CloudsCubemap;Clouds Cubemap;30;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;288;1280,-3712;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1035;2768,720;Float;False;1161;357;Direction Negative Z Mask;5;1076;1056;1055;1054;1050;;1,0,0,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;988;3072,-256;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1069;832,512;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1025;1518,-514;Float;False;505;188;Per Vertex;2;993;940;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;640;206,-2610;Float;False;293;165;PATTERN OUTPUT;1;513;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;1068;640,768;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.1;False;2;FLOAT;1;False;3;FLOAT;20;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1117;-944,-5424;Float;False;3557;485;;23;516;220;574;524;631;918;632;312;436;317;921;919;1113;176;1112;1111;1114;1115;1116;229;228;227;1120;FINAL COLOR;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.SaturateNode;517;-64,-2560;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;420;1616,-3760;Float;False;293;165;SKY OUTPUT;1;218;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;989;1280,-512;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;877;5504,-1728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1096;4224,1968;Fixed;False;Constant;_Float34;Float 34;54;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1166;4704,1520;Float;False;Property;_EnableCloudsRotation;Enable Clouds Rotation;35;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;126;4224,1712;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1094;4224,1808;Fixed;False;Constant;_Float32;Float 32;54;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1095;4224,1888;Fixed;False;Constant;_Float33;Float 33;54;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;878;5760,-1792;Float;False;Property;_EnableStarsTwinkling;Enable Stars Twinkling;15;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;220;-896,-5056;Float;False;218;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;1024,512;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1044;1024,800;Fixed;False;Constant;_Float25;Float 25;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;218;1664,-3712;Fixed;False;SKY;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1050;2816,896;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;629;5760,-1600;Half;False;Property;_StarsIntensity;Stars Intensity;12;0;Create;True;0;0;False;0;2;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;940;1568,-464;Float;False;Property;_EnableSun;Enable Sun;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;994;3232,-256;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1041;1024,720;Fixed;False;Constant;_Float23;Float 23;47;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1056;2816,768;Float;False;1073;0;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1042;1024,640;Fixed;False;Constant;_Float24;Float 24;47;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1029;3374,-258;Float;False;489;188;Per Vertex;2;997;1027;;1,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;516;-896,-5376;Float;False;513;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;513;256,-2560;Fixed;False;PATTERN;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1027;3424,-208;Float;False;Property;_EnableSun;Enable Sun;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;993;1808,-448;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;700;-944,2512;Float;False;1898;485;Fog Coords on Screen;15;318;319;320;313;325;314;315;329;677;316;678;679;1108;1109;1110;BUILT-IN FOG;0,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;1163;5056,1520;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;116;4544,1744;Float;False;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;3;FLOAT3;-1,-1,-1;False;4;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;916;6352,-1840;Float;False;293;165;STARS OUTPUT;1;630;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.BlendOpsNode;574;-704,-5376;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;882;6144,-1792;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;1054;3072,768;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;991;2128,-560;Float;False;603;613;Sun Texture, Color and Intensity;1;995;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;1074;1280,512;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;-1,0;False;2;FLOAT2;1,0;False;3;FLOAT2;0,0;False;4;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1034;1520,512;Float;False;505;188;Per Vertex;2;1057;1043;;1,0,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;632;-384,-5056;Float;False;630;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;998;2176,-256;Fixed;False;Property;_SunColor;Sun Color;22;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexToFragmentNode;997;3664,-192;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1057;1568,560;Float;False;Property;_EnableMoon;Enable Moon;24;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;318;-896,2560;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;1055;3232,768;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;630;6400,-1792;Half;False;STARS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;524;-384,-5376;Float;False;Property;_EnablePatternOverlay;Enable Pattern Overlay;5;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1099;5344,1744;Fixed;False;Constant;_Float37;Float 37;54;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1098;5344,1664;Fixed;False;Constant;_Float36;Float 36;54;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1097;5344,1584;Fixed;False;Constant;_Float35;Float 35;54;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;89;5216,1520;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1076;3376,768;Float;False;489;188;Per Vertex;2;1052;1051;;1,0,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;996;2176,-64;Half;False;Property;_SunIntensity;Sun Intensity;23;0;Create;True;0;0;False;0;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;995;2176,-512;Float;True;Property;_SunTexture;Sun Texture;20;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;236;5600,1520;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;999;4304,-304;Float;False;293;165;SUN OUTPUT MASK;1;1003;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1001;4096,-416;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;319;-640,2560;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;631;-48,-5248;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1000;4304,-560;Float;False;293;165;SUN OUTPUT;1;1004;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1002;2560,-512;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1043;1808,576;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;1031;2128,464;Float;False;603;613;Moon Texture, Color and Intensity;4;1059;1049;1048;1045;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;1052;3424,816;Float;False;Property;_EnableMoon;Enable Moon;24;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1111;128,-5056;Float;False;1003;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1051;3664,832;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;320;-448,2560;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StaticSwitch;918;128,-5376;Float;False;Property;_EnableStars;Enable Stars;8;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1004;4352,-512;Fixed;False;SUN;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1112;128,-5152;Float;False;1004;0;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;1107;6224,1728;Float;False;388;188;Enable Direction Light;1;391;;0,1,0.4980392,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1003;4352,-256;Fixed;False;SUN_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1045;2176,960;Half;False;Property;_MoonIntensity;Moon Intensity;28;0;Create;True;0;0;False;0;1;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1048;2176,768;Fixed;False;Property;_MoonColor;Moon Color;27;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1049;2176,512;Float;True;Property;_MoonTexture;Moon Texture;25;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;399;6016,1856;Float;False;397;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;104;5792,1520;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;397;3840,1840;Fixed;False;Clouds_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1109;-128,2784;Fixed;False;Constant;_Float40;Float 40;55;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1059;2560,512;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1108;-128,2688;Fixed;False;Constant;_Float39;Float 39;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;391;6272,1776;Float;False;Property;_CloudsLitbySun;Clouds Lit by Sun;34;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;914;6672,1472;Float;False;618;496;Cloud Colors;4;232;261;407;101;;0,0.4980392,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;314;-128,2560;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1033;4304,720;Float;False;293;165;SUN OUTPUT MASK;1;1078;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1032;4304,464;Float;False;293;165;SUN OUTPUT;1;1077;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;325;-896,2880;Fixed;False;Property;_FogSmoothness;Fog Smoothness;40;0;Create;True;0;0;False;0;0;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;176;448,-5248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1053;4096,608;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;313;-896,2752;Fixed;False;Property;_FogHeight;Fog Height;39;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1116;640,-5056;Float;False;1078;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;315;64,2560;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1115;640,-5152;Float;False;1077;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1078;4352,768;Fixed;False;MOON_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;329;128,2880;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;407;6800,1856;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;919;640,-5376;Float;False;Property;_EnableSun;Enable Sun;19;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1077;4352,512;Fixed;False;MOON;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;261;6720,1680;Fixed;False;Property;_CloudsLightColor;Clouds Light Color;32;0;Create;True;0;0;False;0;1,1,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;232;6720,1520;Fixed;False;Property;_CloudsShadowColor;Clouds Shadow Color;33;0;Create;True;0;0;False;0;0.4980392,0.7450981,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;677;320,2560;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1114;960,-5248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;101;7104,1520;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;915;7440,1472;Float;False;293;165;CLOUDS OUTPUT;1;222;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;1152,-5152;Float;False;222;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;229;1152,-5056;Float;False;223;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;3840,1968;Fixed;False;CLOUDS_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;7488,1520;Fixed;False;CLOUDS;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;316;512,2560;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;679;512,2880;Fixed;False;Property;_FogFill;Fog Fill;41;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1113;1152,-5376;Float;False;Property;_EnableMoon;Enable Moon;25;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1110;512,2752;Fixed;False;Constant;_Float41;Float 41;55;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;699;1104,2512;Float;False;293;165;FOG_MASK OUTPUT;1;359;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.LerpOp;678;768,2560;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;227;1472,-5248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;359;1152,2560;Fixed;False;FOG_MASK;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;312;1664,-5152;Float;False;unity_FogColor;0;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;1120;1664,-5376;Float;False;Property;_EnableClouds;Enable Clouds;29;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;436;1664,-5056;Float;False;359;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;317;2048,-5248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;921;2304,-5376;Float;False;Property;_EnableBuiltinFog;Enable Built-in Fog;38;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;2816,-5376;Float;False;True;2;Float;;0;0;Unlit;BOXOPHOBIC/Polyverse/Skies - Advanced;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;False;Off;2;False;-1;0;False;-1;False;0;0;False;0;Custom;0;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;42;-1;-1;-1;0;1;PreviewType=Skybox;0;False;0;0;0;False;-1;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;255;0;701;0
WireConnection;255;1;260;0
WireConnection;309;0;267;2
WireConnection;309;1;267;1
WireConnection;276;0;48;0
WireConnection;276;1;255;0
WireConnection;268;0;1007;0
WireConnection;268;1;309;0
WireConnection;268;2;267;4
WireConnection;47;0;276;0
WireConnection;300;0;268;0
WireConnection;62;0;47;0
WireConnection;59;0;62;0
WireConnection;673;0;672;2
WireConnection;673;1;674;0
WireConnection;825;0;824;0
WireConnection;675;0;672;1
WireConnection;675;1;673;0
WireConnection;675;2;672;3
WireConnection;61;0;62;0
WireConnection;365;0;62;0
WireConnection;55;0;62;0
WireConnection;60;0;59;0
WireConnection;60;1;1080;0
WireConnection;1005;0;938;0
WireConnection;941;0;675;0
WireConnection;826;0;825;0
WireConnection;56;0;55;0
WireConnection;56;1;1081;0
WireConnection;56;2;60;0
WireConnection;58;0;61;0
WireConnection;58;1;1081;0
WireConnection;58;2;365;0
WireConnection;266;0;1081;0
WireConnection;266;1;310;0
WireConnection;266;2;1081;0
WireConnection;738;0;733;0
WireConnection;962;0;938;0
WireConnection;962;1;961;0
WireConnection;763;0;941;0
WireConnection;964;0;1005;0
WireConnection;964;1;962;0
WireConnection;740;0;738;0
WireConnection;732;0;1148;0
WireConnection;732;1;731;0
WireConnection;828;0;826;1
WireConnection;1122;0;56;0
WireConnection;1124;0;58;0
WireConnection;1123;0;266;0
WireConnection;537;0;528;0
WireConnection;537;1;1010;0
WireConnection;537;2;1011;0
WireConnection;537;3;1011;0
WireConnection;537;4;1010;0
WireConnection;179;0;178;0
WireConnection;568;0;567;1
WireConnection;568;1;567;2
WireConnection;832;0;828;0
WireConnection;832;1;1017;0
WireConnection;832;2;831;0
WireConnection;832;3;1167;0
WireConnection;832;4;1018;0
WireConnection;1128;0;238;2
WireConnection;1128;1;1127;0
WireConnection;533;0;537;0
WireConnection;533;1;1012;0
WireConnection;965;0;964;0
WireConnection;967;0;962;0
WireConnection;534;0;537;0
WireConnection;534;1;1013;0
WireConnection;564;1;763;0
WireConnection;774;0;1122;0
WireConnection;775;0;1123;0
WireConnection;776;0;1124;0
WireConnection;726;0;732;0
WireConnection;726;1;1014;0
WireConnection;726;2;740;0
WireConnection;726;3;1015;0
WireConnection;726;4;1016;0
WireConnection;1058;0;1061;0
WireConnection;1058;1;1062;0
WireConnection;966;0;963;0
WireConnection;1073;0;1061;0
WireConnection;185;0;179;0
WireConnection;724;0;726;0
WireConnection;822;0;832;0
WireConnection;969;0;965;0
WireConnection;969;1;966;0
WireConnection;1129;0;238;1
WireConnection;1129;1;1128;0
WireConnection;1129;2;238;3
WireConnection;530;0;564;3
WireConnection;530;1;534;0
WireConnection;569;0;568;0
WireConnection;569;2;546;0
WireConnection;569;1;633;0
WireConnection;247;0;238;0
WireConnection;54;0;774;0
WireConnection;54;1;775;0
WireConnection;54;2;776;0
WireConnection;529;0;564;2
WireConnection;529;1;533;0
WireConnection;1038;0;1073;0
WireConnection;1038;1;1058;0
WireConnection;968;0;967;0
WireConnection;968;1;966;0
WireConnection;1130;0;1129;0
WireConnection;947;0;724;0
WireConnection;970;0;968;0
WireConnection;970;1;969;0
WireConnection;1064;0;1038;0
WireConnection;1037;0;1060;0
WireConnection;287;0;185;1
WireConnection;953;0;822;0
WireConnection;49;0;54;0
WireConnection;49;1;247;0
WireConnection;956;0;569;0
WireConnection;1039;0;1058;0
WireConnection;527;0;564;1
WireConnection;527;1;529;0
WireConnection;527;2;530;0
WireConnection;761;0;956;0
WireConnection;856;0;953;0
WireConnection;1164;1;1130;0
WireConnection;1164;0;49;0
WireConnection;1067;0;1064;0
WireConnection;1067;1;1037;0
WireConnection;210;0;287;0
WireConnection;210;1;1008;0
WireConnection;210;2;212;0
WireConnection;210;3;1008;0
WireConnection;210;4;1009;0
WireConnection;972;0;970;0
WireConnection;475;0;471;0
WireConnection;762;0;947;0
WireConnection;1036;0;1039;0
WireConnection;1036;1;1037;0
WireConnection;626;0;527;0
WireConnection;626;1;619;0
WireConnection;470;0;210;0
WireConnection;470;1;475;0
WireConnection;1066;0;1036;0
WireConnection;1066;1;1067;0
WireConnection;278;0;241;0
WireConnection;278;1;1090;0
WireConnection;245;0;1164;0
WireConnection;876;0;762;0
WireConnection;876;1;626;0
WireConnection;876;2;856;0
WireConnection;211;0;178;2
WireConnection;566;1;761;0
WireConnection;976;0;972;1
WireConnection;976;1;971;0
WireConnection;244;0;245;1
WireConnection;244;1;278;0
WireConnection;554;0;566;1
WireConnection;554;1;555;0
WireConnection;303;0;211;0
WireConnection;886;0;876;0
WireConnection;1063;0;1066;0
WireConnection;254;1;280;0
WireConnection;208;0;470;0
WireConnection;981;0;975;0
WireConnection;981;1;973;0
WireConnection;981;2;1019;0
WireConnection;981;3;1020;0
WireConnection;981;4;1021;0
WireConnection;980;0;972;0
WireConnection;980;1;976;0
WireConnection;519;1;254;0
WireConnection;519;0;283;0
WireConnection;1072;0;1063;1
WireConnection;1072;1;1065;0
WireConnection;985;0;980;0
WireConnection;985;1;981;0
WireConnection;246;0;245;0
WireConnection;246;1;244;0
WireConnection;246;2;245;2
WireConnection;180;0;194;0
WireConnection;180;1;182;0
WireConnection;180;2;303;0
WireConnection;756;0;554;0
WireConnection;417;0;208;0
WireConnection;881;0;886;0
WireConnection;115;0;54;0
WireConnection;115;1;1147;0
WireConnection;41;1;246;0
WireConnection;288;0;181;0
WireConnection;288;1;180;0
WireConnection;288;2;417;0
WireConnection;988;0;1028;0
WireConnection;988;1;984;0
WireConnection;1069;0;1063;0
WireConnection;1069;1;1072;0
WireConnection;1068;0;1046;0
WireConnection;1068;1;1071;0
WireConnection;1068;2;1047;0
WireConnection;1068;3;1070;0
WireConnection;1068;4;1040;0
WireConnection;517;0;519;0
WireConnection;989;0;985;0
WireConnection;989;1;1022;0
WireConnection;989;2;1024;0
WireConnection;989;3;1023;0
WireConnection;989;4;1024;0
WireConnection;877;0;756;0
WireConnection;877;1;881;0
WireConnection;1166;1;1147;0
WireConnection;1166;0;115;0
WireConnection;126;0;41;0
WireConnection;878;1;881;0
WireConnection;878;0;877;0
WireConnection;1075;0;1069;0
WireConnection;1075;1;1068;0
WireConnection;218;0;288;0
WireConnection;940;0;989;0
WireConnection;994;0;988;0
WireConnection;513;0;517;0
WireConnection;1027;0;994;0
WireConnection;993;0;940;0
WireConnection;1163;0;1166;0
WireConnection;116;0;126;0
WireConnection;116;1;1094;0
WireConnection;116;2;1096;0
WireConnection;116;3;1095;0
WireConnection;116;4;1096;0
WireConnection;574;0;516;0
WireConnection;574;1;220;0
WireConnection;882;0;878;0
WireConnection;882;1;629;0
WireConnection;1054;0;1056;0
WireConnection;1054;1;1050;0
WireConnection;1074;0;1075;0
WireConnection;1074;1;1042;0
WireConnection;1074;2;1044;0
WireConnection;1074;3;1041;0
WireConnection;1074;4;1044;0
WireConnection;997;0;1027;0
WireConnection;1057;0;1074;0
WireConnection;1055;0;1054;0
WireConnection;630;0;882;0
WireConnection;524;1;220;0
WireConnection;524;0;574;0
WireConnection;89;0;1163;0
WireConnection;89;1;116;0
WireConnection;995;1;993;0
WireConnection;236;0;89;0
WireConnection;236;1;1098;0
WireConnection;236;2;1099;0
WireConnection;236;3;1097;0
WireConnection;236;4;1099;0
WireConnection;1001;0;995;4
WireConnection;1001;1;997;0
WireConnection;319;0;318;0
WireConnection;631;0;524;0
WireConnection;631;1;632;0
WireConnection;1002;0;995;1
WireConnection;1002;1;998;0
WireConnection;1002;2;996;0
WireConnection;1043;0;1057;0
WireConnection;1052;0;1055;0
WireConnection;1051;0;1052;0
WireConnection;320;0;319;0
WireConnection;918;1;524;0
WireConnection;918;0;631;0
WireConnection;1004;0;1002;0
WireConnection;1003;0;1001;0
WireConnection;1049;1;1043;0
WireConnection;104;0;236;0
WireConnection;397;0;41;2
WireConnection;1059;0;1049;1
WireConnection;1059;1;1048;0
WireConnection;1059;2;1045;0
WireConnection;391;1;399;0
WireConnection;391;0;104;0
WireConnection;314;0;320;1
WireConnection;176;0;918;0
WireConnection;176;1;1112;0
WireConnection;176;2;1111;0
WireConnection;1053;0;1049;4
WireConnection;1053;1;1051;0
WireConnection;315;0;314;0
WireConnection;315;1;1108;0
WireConnection;315;2;313;0
WireConnection;315;3;1108;0
WireConnection;315;4;1109;0
WireConnection;1078;0;1053;0
WireConnection;329;0;325;0
WireConnection;407;0;391;0
WireConnection;919;1;918;0
WireConnection;919;0;176;0
WireConnection;1077;0;1059;0
WireConnection;677;0;315;0
WireConnection;677;1;329;0
WireConnection;1114;0;919;0
WireConnection;1114;1;1115;0
WireConnection;1114;2;1116;0
WireConnection;101;0;232;0
WireConnection;101;1;261;0
WireConnection;101;2;407;0
WireConnection;223;0;41;4
WireConnection;222;0;101;0
WireConnection;316;0;677;0
WireConnection;1113;1;919;0
WireConnection;1113;0;1114;0
WireConnection;678;0;316;0
WireConnection;678;1;1110;0
WireConnection;678;2;679;0
WireConnection;227;0;1113;0
WireConnection;227;1;228;0
WireConnection;227;2;229;0
WireConnection;359;0;678;0
WireConnection;1120;1;1113;0
WireConnection;1120;0;227;0
WireConnection;317;0;312;0
WireConnection;317;1;1120;0
WireConnection;317;2;436;0
WireConnection;921;1;1120;0
WireConnection;921;0;317;0
WireConnection;26;2;921;0
ASEEND*/
//CHKSM=592A5624222A7B67B3C1D85F924447B21668BCC2