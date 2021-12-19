Shader "Holistic/MetalicShader"
{
    Properties
    {
        _diffuse("Diffuse Texture", 2D) = "white" {}
        _bump("Bump Texture", 2D) = "bump" {}
        _textureSize("Texture size", Range(0, 10)) = 1
        _bumpHeight("Bump Amount", Range(0, 20)) = 1
        _skybox("SkyBox", CUBE) = "white" {}
        _color ("Color", Color) = (1,1,1,1)
        _emission("Emission", Range(0, 20)) = 1
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuse;
            sampler2D _bump;
            half _textureSize;
            half _bumpHeight;
            half _emission;
            samplerCUBE _skybox;
            fixed4 _color;

            struct Input {
                float2 uv_diffuse;
                float2 uv_bump;
                float3 worldRefl; INTERNAL_DATA 
            };

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = (tex2D(_diffuse, IN.uv_diffuse * _textureSize) * _color).rgb;
                o.Normal = UnpackNormal(tex2D(_bump, IN.uv_bump * _textureSize));
                o.Normal *= float3(_bumpHeight, _bumpHeight, 1);
                o.Emission = (texCUBE(_skybox, WorldReflectionVector(IN, o.Normal)) * _emission).rgb;
            }
        ENDCG
    }
    Fallback "Diffuse"
}
