Shader "CookbookShaders/Chapter3/LambertLighting" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_LightColour0 ("Light", Color) = (1,1,1,1)
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf SimpleLambert

		sampler2D _MainTex;
        fixed4 _LightColour0;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
	        o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		
		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten)
		{
		    half NdotL = dot(s.Normal,lightDir);
		    half4 c;
		    c.rgb = s.Albedo * _LightColour0.rgb * (NdotL * atten * 1);
		    c.a = s.Alpha;
		    return c;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
