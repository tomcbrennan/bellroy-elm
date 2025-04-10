// @ts-check
import { defineConfig } from 'astro/config'
import elm from 'astro-integration-elm'
import tailwindcss from '@tailwindcss/vite'

// https://astro.build/config
export default defineConfig({
	devToolbar: {
		enabled: false,
	},
	integrations: [elm()],
	vite: {
		plugins: [tailwindcss()],
	},
})
