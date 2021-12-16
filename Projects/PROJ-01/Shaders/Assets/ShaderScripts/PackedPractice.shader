Shader "Holistic/PackedPractice" {
    Properties {
        //Colors in the shader code range from 0 to 1
        _Albedo ("Albedo", Color) = (1,1,1,1)
    }
    SubShader {

        CGPROGRAM
            #pragma surface surf Lambert
            
            struct Input {
                float2 uvMainTex;
            };

            fixed4 _Albedo;

            void surf (Input IN, inout SurfaceOutput o){
                o.Albedo = _Albedo.rgb;
            }

        ENDCG
    }

    FallBack "Diffuse"
}