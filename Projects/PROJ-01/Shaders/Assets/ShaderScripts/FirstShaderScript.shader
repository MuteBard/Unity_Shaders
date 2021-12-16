Shader "Holistic/HelloShader" {
    Properties {
        _Emission ("Emission", Color) = (1,1,1,1)
        _Albedo ("Albedo", Color) = (1,1,1,1)
    }
    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert
            
            struct Input {
                float2 uvMainTex;
            };

            fixed4 _Emission;
            fixed4 _Albedo;

            void surf (Input IN, inout SurfaceOutput o){
                o.Emission = _Emission.rgb;
                o.Albedo = _Albedo.rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}