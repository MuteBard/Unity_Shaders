Shader "Holistic/HelloShader" {
    Properties {
        _Emission ("Emission", Color) = (1,1,1,1)
        _Albedo ("Albedo", Color) = (1,1,1,1)
        _Normal ("Normal,", Color) = (1,1,1,1)
    }
    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert
            
            struct Input {
                float2 uvMainTex;
            };

            fixed4 _Emission;
            fixed4 _Albedo;
            fixed4 _Normal;

            void surf (Input IN, inout SurfaceOutput o){
                o.Emission = _Emission.rgb;
                o.Albedo = _Albedo.rgb;
                o.Normal = _Normal.rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}