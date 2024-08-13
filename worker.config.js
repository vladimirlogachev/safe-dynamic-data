import { defineConfig } from "vite";

import elmPlugin from "vite-plugin-elm";

import { resolve } from "path";

const elmProdSettings = {
  debug: false,
  optimize: true,
  nodeElmCompilerOptions: {},
};

export default defineConfig({
  publicDir: false,
  plugins: [elmPlugin(elmProdSettings)],
  build: {
    outDir: "./elm-worker",
    sourcemap: false,
    lib: {
      entry: resolve(__dirname, "./src/elm-worker.js"),
      name: "elm-worker",
      fileName: (format) => `elm-worker.${format}.js`,
    },
  },
});
