fullBright
{
	// use our supplied color...
	{
		map $whiteimage
		blendFunc GL_ONE GL_ZERO
		rgbGen entity
	}

	// ...and divide it by the current brightness
	{
		map $whiteimage
		blendFunc GL_DST_COLOR GL_ZERO
		rgbGen identityLighting
	}
}

fullBrightVertexLight
{
	{
		map $whiteimage
		blendFunc GL_ONE GL_ZERO
		rgbGen entity
	}
}
