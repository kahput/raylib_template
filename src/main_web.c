#include "common.h"
#include <game_interface.h>
static GameContext context;

#ifdef PLATFORM_WEB
	#include <raylib.h>
	#include <stdlib.h>

	#include <emscripten/emscripten.h>
void game_frame(GameContext *ctx);

static GameContext ctx = { 0 };

static void loop(void) {
	game_frame(&ctx);
}

int main(void) {
	ctx.memory_size = MiB(8);
	ctx.memory = calloc(1, ctx.memory_size);
	ctx.transient_memory_size = MiB(256);
	ctx.transient_memory = calloc(1, ctx.memory_size);
	InitWindow(1280, 720, "game");
	InitAudioDevice();
	emscripten_set_main_loop(loop, 0, 1);
}
#endif
