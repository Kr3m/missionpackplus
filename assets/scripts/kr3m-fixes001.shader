textures/evil8_floor/e8cretefloor02
{
	surfaceparm metalsteps
	{
		map $lightmap
		rgbGen identity
		tcGen lightmap
	}
	{
		map textures/evil8_floor/e8cretefloor02.jpg
		blendfunc filter
		rgbGen identity
	}
}

textures/evil8_floor/e8cretefloor01b
{
	surfaceparm metalsteps
	{
		map $lightmap
		rgbGen identity
		tcGen lightmap
	}
	{
		map textures/evil8_floor/e8cretefloor01b.jpg
		blendfunc filter
		rgbGen identity
	}
}

textures/evil8_floor/e8crete03fadedwarn
{
	surfaceparm metalsteps
	{
		map $lightmap
		rgbGen identity
		tcGen lightmap
	}
	{
		map textures/evil8_floor/e8crete03fadedwarn.jpg
		blendfunc filter
		rgbGen identity
	}
}

textures/skies/hellsky
{
	qer_editorimage textures/skies/hellsky.tga
	surfaceparm noimpact
	surfaceparm nomarks
	surfaceparm nolightmap
	surfaceparm sky
	q3map_sun 4 3 3 65 290 75
	q3map_surfacelight 50
	skyparms - 512 -
	{
		map textures/skies/hellsky.tga
		tcMod scroll 0.05 0
		tcMod scale 2 2
		depthWrite
	}
}
