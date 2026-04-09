//shader by Kr3m

sprites/flagcarrier
{
	nomipmaps
	nopicmip
	{
		map sprites/flagcarrier.tga
		blendfunc blend
		rgbgen vertex
	}
}

sprites/flagcarrier_hit
{
	nomipmaps
	nopicmip
	{
		map sprites/flagcarrier_hit.tga
		blendfunc blend
	}
}


sprites/neutralflagcarrier
{
	nomipmaps
	nopicmip
	{
		map sprites/flagcarrier_neutral.tga
		blendfunc	GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbgen vertex
	}
}