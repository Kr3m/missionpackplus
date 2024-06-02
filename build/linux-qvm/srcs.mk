QA_SRC = \
 g_main $(QADIR)/g_syscalls.asm \
 bg_misc bg_lib bg_promode bg_pmove bg_slidemove \
 q_math q_shared \
 ai_dmnet ai_dmq3 ai_team ai_main ai_chat ai_cmd ai_vcmd \
 g_active g_arenas g_bot g_client g_cmds g_combat g_items g_mem g_misc \
 g_missile g_mover g_rotation g_session g_spawn g_svcmds g_target g_team \
 g_trigger g_unlagged g_utils g_weapon \

CG_SRC = \
 cg_main $(CGDIR)/cg_syscalls.asm \
 cg_consolecmds cg_draw cg_drawtools cg_effects cg_ents cg_event cg_info \
 cg_localents cg_marks cg_newdraw cg_players cg_playerstate cg_predict \
 cg_scoreboard cg_servercmds cg_snapshot cg_view cg_weapons \
 ui_shared \
 bg_slidemove bg_promode bg_pmove bg_lib bg_misc \
 q_math q_shared \

UI_SRC = \
 ui_main $(UIDIR)/ui_syscalls.asm \
 ui_atoms ui_gameinfo ui_players ui_shared \
 bg_misc bg_lib \
 q_math q_shared \
