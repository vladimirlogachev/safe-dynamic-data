import ElmWorker from "./worker?worker";

const worker = new ElmWorker();

const exampleData = `{
        "name": "John Doe",
        "age": 30,
        "dogName": "Rex",
        "isDogOwner": true
    }`;

worker.onmessage = function ({ data }) {
  console.log("Worker said:", data);
};

worker.postMessage({
  type: "input",
  value: exampleData,
});
