Shader "CookbookShaders/StandardDiffuse" {
 Properties {
  _MainTint ("Diffuse Tint", Color) = (1,1,1,1)
  _MainTex ("Base (RGB)", 2D) = "white" {}
  _NormalTex ("Normal Map", 2D) = "bump" {}
  _ScrollXSpeed ("X Scroll Speed", Range(0,10)) = 2
  _ScrollYSpeed ("Y Scroll Speed", Range(0,10)) = 2
  _NormalIntensity ("Normal Intensity", Range(0,5)) = 1
 }
 SubShader {
     Tags { "RenderType"="Opaque" }
     LOD 200
     
     CGPROGRAM
     // Physically based Standard lighting model, and enable shadows on all light types
     #pragma surface surf Standard fullforwardshadows

     // Use shader model 3.0 target, to get nicer looking lighting
     #pragma target 3.0

     struct Input {
         float2 uv_MainTex;
     };

     fixed4 _MainTint;
     fixed _ScrollXSpeed;
     fixed _ScrollYSpeed;
     sampler2D _MainTex;
     sampler2D _NormalTex;
     fixed _NormalIntensity;

     // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
     // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
     // #pragma instancing_options assumeuniformscaling
     UNITY_INSTANCING_CBUFFER_START(Props)
         // put more per-instance properties here
     UNITY_INSTANCING_CBUFFER_END

     void surf (Input IN, inout SurfaceOutputStandard o) {
         // Albedo comes from a texture tinted by color
         fixed2 uvCoord = IN.uv_MainTex;

         fixed xSpace = _ScrollXSpeed * _Time;
         fixed ySpace = _ScrollYSpeed * _Time;

         uvCoord += fixed2(xSpace, ySpace);

         half4 color = tex2D(_MainTex, uvCoord);
         o.Normal = UnpackNormal(tex2D(_NormalTex, uvCoord)).rgb;

         o.Normal.x *= _NormalIntensity;
         o.Normal.y *= _NormalIntensity;
         o.Normal = normalize(o.Normal);
            
         o.Albedo = color.rgb * _MainTint;
         o.Alpha = color.a;
     }
     ENDCG
 }
 FallBack "Diffuse"
}
