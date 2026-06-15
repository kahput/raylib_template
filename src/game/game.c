#include <game_interface.h>
#include <stdbool.h>

#include <raylib.h>
#include <raymath.h>
#include <rlgl.h>
#include <stdlib.h>

typedef struct {
	bool initialized;
} GameState;

static GameState *state = NULL;

void game_frame(GameContext *context) {
	state = (GameState *)context->memory;

	if (state->initialized == false) {
		state->initialized = true;
	}

	// Draw
	BeginDrawing();
	ClearBackground(RAYWHITE);

    DrawText("hello world!", 10, 10, 32, BLACK);

	EndDrawing();
}

void game_unload(GameContext *context) {
	state = (GameState *)context->transient_memory;
}
