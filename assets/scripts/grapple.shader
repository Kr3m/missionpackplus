models/weapons2/grapple2/ball
{
	//novlcollapse
	nopicmip
	{
		map models/weapons2/grapple2/ball.jpg
		blendFunc GL_ONE GL_ZERO
		tcGen environment
		rgbGen lightingDiffuse
	}
}

models/weapons2/grapple2/spikes
{
	//novlcollapse
	nopicmip
	{
		map models/weapons2/grapple2/spikes.jpg
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		tcGen environment
		rgbGen lightingDiffuse
	}
}

grappleRope
{
	//novlcollapse
	nopicmip
	cull none
	{
		map models/weapons2/grapple2/grapplerope.tga
		blendfunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
	}
}
