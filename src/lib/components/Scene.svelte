<script>
	import { TextureLoader, Vector2 } from 'three';
	import { T, useLoader } from '@threlte/core';
	import fragmentShader from '$lib/fragment.glsl?raw';
	import vertexShader from '$lib/vertex.glsl?raw';
	import texture1 from '$lib/abstract.jpg';
	import texture2 from '$lib/texture.jpg';
	import texture3 from '$lib/nature.jpg';
	import { onMount } from 'svelte';
	import { windowSizeStore, mouseStore } from 'svelte-legos';
	import { tweened } from 'svelte/motion';
	import { quadOut } from 'svelte/easing';

	const size = windowSizeStore();
	const sizeUniform = new Vector2();
	$: sizeUniform.set($size.width, $size.height);
	const position = mouseStore();

	// Create a tweened store for the position with an initial value and configuration
	const positionTweened = tweened(
		{ x: 0, y: 0 },
		{
			duration: 400,
			easing: quadOut
		}
	);

	// Update the tweened position whenever the mouse position changes
	$: if ($position) {
		positionTweened.set($position);
	}

	// Create a new THREE.Vector2 for the uniform
	const positionUniform = new Vector2();

	// Update the uniform whenever the tweened position changes
	$: if ($positionTweened) {
		positionUniform.set($positionTweened.x, $positionTweened.y);
	}

	// $: console.log($size, sizeUniform, $position, positionUniform);
	// $: console.log(positionUniform, sizeUniform);

	const texturesArray = [
		useLoader(TextureLoader).load(texture1),
		useLoader(TextureLoader).load(texture2),
		useLoader(TextureLoader).load(texture3)
	];
	let activeTexture = 0;
	export function next() {
		console.log('next');
		if (activeTexture >= texturesArray.length - 1) {
			activeTexture = 0;
		} else {
			activeTexture = activeTexture + 1;
		}
	}
	$: texture = texturesArray[activeTexture];

	let time = 0.0;
	let near = 0.1;
	let far = 1000;

	$: console.log($texture);

	function animate() {
		requestAnimationFrame(animate);

		// Update the time uniform
		time += 0.05;
	}
	animate();
</script>

<!-- <T.PerspectiveCamera makeDefault position={[0, 0, 900]}></T.PerspectiveCamera> -->
<T.OrthographicCamera makeDefault position={[0, 0, 1000]}></T.OrthographicCamera>

{#if $texture}
	<T.Mesh position={[0, 0, 0]} rotation={[0, 0, 0]}>
		<T.PlaneGeometry args={[$size.width * 1.2, $size.height * 1.2]} />
		<T.ShaderMaterial
			{vertexShader}
			{fragmentShader}
			uniforms={{
				uTime: { value: 0.0 },
				uTexture: { value: $texture },
				uRepetitions: { value: 8 },
				uMouse: { value: positionUniform },
				uResolution: { value: sizeUniform }
			}}
			uniforms.uTime.value={time}
		></T.ShaderMaterial>
	</T.Mesh>
{/if}
