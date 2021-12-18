Shader "Holistic/BumpedEnvironment"
{
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0, 10)) = 1
        _bumpScale("Bump Scale", Range(0, 10)) = 1
        _myCube ("Cube Map", CUBE) = "white" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        sampler2D _myDiffuse;
        sampler2D _myBump;
        half _mySlider;
        half _bumpScale;
        samplerCUBE _myCube;

        struct Input {
            float2 uv_myDiffuse;
            float2 uv_myBump;


// Basically, while the error is happening, it's not going to let you use this world reflection data while
// you're trying to modify the normals because the normals are based on the world reflection data which
// means that you want to be able to modify the normals but not affect the world reflection data
// because they're kind of linked together.
// Now the way that you do that (and the clue is even in the error that you've been given) is that after the
// worldRefl you have to type in INTERNAL_DATA like this, so that it will use a different data set.

            float3 worldRefl; INTERNAL_DATA
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            // o.Albedo = texCUBE(_myCube, IN.worldRefl).rgb;
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse * _bumpScale).rgb;
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump * _bumpScale));
            o.Normal *= float3(_mySlider, _mySlider, 1);
            o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
      ENDCG
    }
    Fallback "Diffuse"
}
