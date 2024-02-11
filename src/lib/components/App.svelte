<script>
	import { Canvas } from '@threlte/core';
	import Scene from './Scene.svelte';
	import { Pane, Slider } from 'svelte-tweakpane-ui';
	let sceneComponent;
</script>

<!-- <Pane>
	<Slider bind:value={repetitions} min={1} max={12} step={1} label="Repeats"></Slider>
</Pane> -->
<div
	class="fixed bottom-16 right-16 top-16 z-30 flex w-80 flex-col rounded-2xl bg-white bg-opacity-75 p-6 backdrop-blur-xl backdrop-brightness-150"
>
	<h1 class="mb-4 font-serif text-4xl">Kaleidoscope Shader</h1>
	<p class="opacity-50">
		I'm taking the SuperHi "Shaders for the Web" course. In the second part of this course, the
		instructor teaches us how to create this kaleidoscope shader from an image texture. I've adapted
		the tutorial to use Threlte for a more pleasant experience.
	</p>
	<button class="mt-auto w-full rounded-md bg-white bg-opacity-25 p-4 hover:bg-opacity-50"
		>Follow me</button
	>
</div>
<div class="fixed z-20 h-full w-full" on:click={() => sceneComponent.next()}>
	<Canvas>
		<Scene bind:this={sceneComponent} />
	</Canvas>
</div>
