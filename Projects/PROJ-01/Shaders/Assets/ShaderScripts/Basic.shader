Shader "Holistic/BasicLambert"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _SpecColor("Specular Color", Color) = (1,1,1,1) //color of the light you'll see in the specular reflection
        _SpecSize("Specular Size", Range(0,1)) = 0.5 // Size of specular things, similar to the rim lighting exercise
        _Gloss("Gloss", Range(0,1)) = 0.5 //The power that you apply to your Specular
    }
    SubShader
    {
        Tags{
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf Lambert

        float4 _Color;
        // float4 _SpecColor; not needed since already defined internally
        half _SpecSize;
        fixed _Gloss;


        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o){
            o.Albedo = _Color.rgb;
            o.Specular = _SpecSize;
            o.Gloss = _Gloss;
        }
        ENDCG

    }
    FallBack "Diffuse"
}
