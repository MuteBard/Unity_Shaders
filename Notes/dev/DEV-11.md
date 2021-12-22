# DEV-11, The Dot Product
#### Tags: [Dot Product]



## Why

    This operation will allow us more power over the manipulation of of vectors.

## The Dot product

    The dot product of two vectors, A and B is written

    a.b

    and can be calculated in two ways

    The first multiplies the length of each vector together with the cosine of the angle between them.

    The second multiplies each individual coordinate of one vector with the other and then adds them all

![](../images/DEV-11/DEV-11-A.png)

    In ShaderLab, how to compute it looks like this:

    half dotp = dot(IN.viewDir, o.Normal);

## Again Why do I care?

    Imagine you want to color pixels differently on certain parts of an object.
    The dot product is a key factor in producing effects such as rim lighting, outlining and anisotropic highlights. 
    
## Some effects

    rim lighting

![](../images/DEV-11/DEV-11-B.png)

    outlining

![](../images/DEV-11/DEV-11-C.png)

    anisotropic

![](../images/DEV-11/DEV-11-D.png)

## Diving deeper into the Dot product

    The dot product tells us if two vectors are pointing in the same direction, pointing int he opposite directions, are at 90 degrees or somewhere in between.
    When two vectors are normalized to their unit length of 1


    same

![](../images/DEV-11/DEV-11-E.png)

    opposite

![](../images/DEV-11/DEV-11-F.png)

    perpendicular

![](../images/DEV-11/DEV-11-G.png)


    If one of those vectors represents the normal on a polygon, then you can also deduce the side of the polygon the other vector is on

    For a positive dot product, the vector is on the same side.

![](../images/DEV-11/DEV-11-H.png)

    For a negative dot product, the vector is on the underside

![](../images/DEV-11/DEV-11-I.png)

    For a dot product of 0, it is lying on the surface.

![](../images/DEV-11/DEV-11-AA.png)


## WHat does this mean for me?

    We can build custom shaders based on the direction of the viewer relative to an object.
    The viewer is always perceiving the virtual environment from their position behind the computer screen, hence thats where the viewer direction comes from.
    You'll see this written as the viewDir in the shader input structure. 

![](../images/DEV-11/DEV-11-AB.png)

     Given the view direction and all the normals on the model, I can use a dot product to determine which sides of the mesh are facing toward the viewer and those that are facing away. But not only that, I can also tell how MUCH they are facing the viewer.

     Any normals that make a dot product with the view vector close to 1 will represent faces of the model that face (or sit quite perpendicular to) the viewer.

![](../images/DEV-11/DEV-11-AC.png)

![](../images/DEV-11/DEV-11-AD.png)

![](../images/DEV-11/DEV-11-AE.png)
