powerups/spawnprotect
{
	deformVertexes wave 100 sin 3 0 0 0
	{
		map textures/effects/quadmap3.tga
		blendfunc GL_ONE GL_ONE
		tcGen environment
		tcmod rotate 30
		tcmod scroll 1 .1
	}
}

powerups/spawnProtectWeapon
{
	deformVertexes wave 100 sin 0.5 0 0 0
	{
		map textures/effects/quadmap3.tga
		blendfunc GL_ONE GL_ONE
		tcGen environment
		tcmod rotate 30
		tcmod scroll 1 .1
	}
}
