//Quake Live support

textures/x/f2/redteam01
{
	cull none
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nomarks
	{
	  	map team_icon/stroggs_red.tga
		blendfunc GL_SRC_ALPHA GL_ONE
		rgbGen wave sin .2 .5 0 .2
	}
}

textures/x/f2/blueteam01
{
	cull none
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nomarks
	{
	  	map team_icon/pagans_blue.tga
		blendfunc GL_SRC_ALPHA GL_ONE
		rgbGen wave sin .2 .5 0 .2
	}
}

textures/x/f2/redteam02
{
    qer_editorimage team_icon/stroggs_red.tga
	cull none
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nomarks
	{
	  	map team_icon/stroggs_red.tga
		blendfunc GL_SRC_ALPHA GL_ONE
		rgbGen wave sin .5 .25 0 .2
	}
}

textures/x/f2/blueteam02
{
    qer_editorimage team_icon/pagans_blue.tga
	cull none
	surfaceparm nolightmap
	surfaceparm trans
	surfaceparm nomarks
	{
	  	map team_icon/pagans_blue.tga
		blendfunc GL_SRC_ALPHA GL_ONE
		rgbGen wave sin .5 .25 0 .2
	}
}

textures/x/f2/redteam03
{
    qer_editorimage team_icon/stroggs_red.tga
	qer_trans 0.4
	surfaceparm nolightmap
	surfaceparm pointlight
	surfaceparm nomarks
	surfaceparm trans
	cull none
	nopicmip
	polygonOffset
	{
	  	map team_icon/stroggs_red.tga
		blendfunc add
		rgbgen vertex
		depthWrite
	}
}

textures/x/f2/blueteam03
{
    qer_editorimage team_icon/pagans_blue.tga
	qer_trans 0.4
	surfaceparm nolightmap
	surfaceparm pointlight
	surfaceparm nomarks
	surfaceparm trans
	cull none
	nopicmip
	polygonOffset
	{
	  	map team_icon/pagans_blue.tga
		blendfunc add
		rgbgen vertex
		depthWrite
	}
}

textures/x/f/ctf_redflag
{
        tessSize 64
        deformVertexes wave 194 sin 0 3 0 .4
        deformVertexes normal .3 .2
        surfaceparm nomarks
        cull none

        {
		map textures/ctf_unified/banner01_red.tga
		rgbGen identity
	}
        {
		map textures/effects/blueflagmap.tga
                 tcGen environment
                tcmod scale 9 3
                tcmod scroll .1 .7

                blendFunc GL_ONE GL_ONE
                rgbGen identity
	}
        {
		map textures/ctf_unified/banner01_red.tga
                blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbGen identity
	}
        {
		map $lightmap
                blendFunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
        {

        	map textures/sfx/shadow.tga
                tcGen environment
                //blendFunc GL_ONE GL_ONE
                blendFunc GL_DST_COLOR GL_ZERO
               rgbGen identity
	}
}

textures/x/f/ctf_blueflag
{
        tessSize 64
        deformVertexes wave 194 sin 0 3 0 .4
        deformVertexes normal .5 .1
        surfaceparm nomarks
        cull none

        {
		map textures/ctf_unified/banner01_blue.tga
		rgbGen identity
	}
        {
		map textures/effects/redflagmap.tga
                tcGen environment
                tcmod scale 9 3
                tcmod scroll .1 .7

                blendFunc GL_ONE GL_ONE
                rgbGen identity
	}
        {
		map textures/ctf_unified/banner01_blue.tga
                blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbGen identity
	}
        {
		map $lightmap
                blendFunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
        {
        	map textures/sfx/shadow.tga
                tcGen environment
                //blendFunc GL_ONE GL_ONE
                blendFunc GL_DST_COLOR GL_ZERO
               rgbGen identity
	}
}

textures/x/f/ctf_redflag2
{
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .3 .2
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner06_red.tga
		rgbGen identity
	}
    {
		map textures/effects/blueflagmap.tga
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner06_red.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
       	map textures/sfx/shadow.tga
        tcGen environment 
        blendfunc filter
        rgbGen identity
	}
}

textures/x/f/ctf_blueflag2
{
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .5 .1
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner06_blue.tga
		rgbGen identity
	}
    {
		map textures/effects/redflagmap.tga
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner06_blue.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
      	map textures/sfx/shadow.tga
        tcGen environment 
        blendfunc filter
        rgbGen identity
	}
}

textures/x/f/ctf_redflag_nonsolid
{
	qer_editorImage textures/ctf_unified/banner01_red.tga
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .3 .2
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner01_red.tga
		rgbGen identity
	}
    {
		map textures/effects/blueflagmap.tga
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner01_red.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
      	map textures/sfx/shadow.tga
        tcGen environment
        blendfunc filter
        rgbGen identity
	}
}

textures/x/f/ctf_blueflag_nonsolid
{
	qer_editorImage textures/ctf_unified/banner01_blue.tga
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .5 .1
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner01_blue.tga
		rgbGen identity
	}
    {
		map textures/effects/redflagmap.tga
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner01_blue.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
      	map textures/sfx/shadow.tga
        tcGen environment
        blendfunc filter
        rgbGen identity
	}
}

textures/x/f/ctf_redflag2_still
{
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .5 .1
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner06_red.tga
		rgbGen identity
	}
    {
		map textures/effects/blueflagmap.tga
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner06_red.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
       	map textures/sfx/shadow.tga
        tcGen environment
        blendfunc filter
        rgbGen identity
	}
}

textures/x/f/ctf_blueflag2_still
{
    tessSize 64
    deformVertexes wave 194 sin 0 3 0 .4
    deformVertexes normal .5 .1
    surfaceparm nomarks
	surfaceparm nonsolid
    cull none
    {
		map textures/ctf_unified/banner06_blue.tga
		rgbGen identity
	}
    {
		map textures/effects/redflagmap.tga // Oddly backwards
        tcGen environment
        tcmod scale 9 3
        tcmod scroll .1 .7
        blendfunc add
        rgbGen identity
	}
    {
		map textures/ctf_unified/banner06_blue.tga
        blendfunc blend
		rgbGen identity
	}
    {
		map $lightmap
        blendfunc GL_DST_COLOR GL_ONE_MINUS_DST_ALPHA
		rgbGen identity
	}
    {
       	map textures/sfx/shadow.tga
        tcGen environment
        blendfunc filter
        rgbGen identity
	}
}

textures/xxxx2010jlctf3/redribbon
{
	surfaceparm nonsolid
	surfaceparm nomarks
	surfaceparm trans
	surfaceparm nolightmap
	cull none
	deformVertexes wave 32 sin 0 2 0 6
	deformVertexes wave 45 sin 0 2 0.5 6

	{
		map textures/ctf_unified/banner06_red.tga
		rgbGen lightingDiffuse
	}
}


textures/xxxx2010jlctf3/blueribbon
{
	surfaceparm nonsolid
	surfaceparm nomarks
	surfaceparm trans
	surfaceparm nolightmap
	cull none
	deformVertexes wave 32 sin 0 2 0 6
	deformVertexes wave 45 sin 0 2 0.5 6

	{
		map textures/ctf_unified/banner06_blue.tga
		rgbGen lightingDiffuse
	}
}
