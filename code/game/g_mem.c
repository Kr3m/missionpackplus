// Copyright (C) 1999-2000 Id Software, Inc.
//
//
// g_mem.c
//


#include "g_local.h"


#define POOLSIZE	(768 * 1024)

static char		memoryPool[POOLSIZE];
static size_t		allocPoint;

void *G_Alloc( size_t size ) {
	char	*p;

	if ( g_debugAlloc.integer ) {
		G_Printf( "G_Alloc of %u bytes (%u left)\n", size, POOLSIZE - allocPoint - ( ( size + 31 ) & ~31U ) );
	}

	if ( allocPoint + size > POOLSIZE ) {
		G_Error( "G_Alloc: failed on allocation of %u bytes", size );
		return NULL;
	}

	p = &memoryPool[allocPoint];

	allocPoint += ( size + 31 ) & ~31U;

	return p;
}

void G_InitMemory( void ) {
	allocPoint = 0;
}

void Svcmd_GameMem_f( void ) {
	G_Printf( "Game memory status: %u out of %u bytes allocated\n", allocPoint, POOLSIZE );
}
