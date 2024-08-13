import app from "./elm-worker/elm-worker.es.js";

onmessage = function ({ data }) {
  const { type, value } = data;
  if (type === "input") {
    app.ports.input.send(value);
  }
};

app.ports.sendOutput.subscribe(function (x) {
  postMessage(x);
});
