import { defineConfig } from "vite";
import elmPlugin from "vite-plugin-elm";

const elmProdSettings = {
  debug: false,
  optimize: true,
  nodeElmCompilerOptions: {},
};

export default defineConfig({
  plugins: [elmPlugin(elmProdSettings)],
});
