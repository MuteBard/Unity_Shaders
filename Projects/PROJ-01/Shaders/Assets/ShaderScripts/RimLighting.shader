Shader "Holistic/RimLighting"
{
    Properties
    {
        _RimColor("Rim Color", Color) = (0,0.5,0.5,0)
        _RimThickness("Rim Thickness", Range(1.0,8.9)) = 1
        _Color1("Color", Color) = (1,1,1,1)
        _Color2("Color", Color) = (1,1,1,1)
        _Color3("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            float4 _RimColor;
            float _RimThickness;
            float3 _Color1;
            float3 _Color2;
            float3 _Color3;
            

            struct Input { 
                float3 viewDir;
                float3 worldPos;
            };

            void surf (Input IN, inout SurfaceOutput o){
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                // o.Emission = _RimColor.rgb * pow(rim, _RimThickness);
                o.Albedo = _Color1.rgb;
                // o.Emission = _RimColor.rgb * rim > 0.5 ? _Color2 :  rim > 0.3 ? _Color3 : _Color1.rgb;
                o.Emission = frac(IN.worldPos.y * 10 * 0.5) > 0.8 ? float3(0,0,0) :  _RimColor.rgb * rim > 0.5 ? _Color2 :  rim > 0.3 ? _Color3 : _Color1.rgb;
            }

        ENDCG
    }
    FallBack "Diffuse"
}
