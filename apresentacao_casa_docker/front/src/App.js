import "./App.css";
import axios from "axios";
import { useState } from "react";

function App() {
  const [text, setText] = useState("");

  const getResponse = () => {
    axios("http://localhost:5000/hello").then((res) => {
      setText(res.data);
    });
  };

  return (
    <div className="App">
      <h1>Olá Front com Docker</h1>
      <button onClick={() => getResponse()}>Clique me</button>
      <h3>{text}</h3>
    </div>
  );
}

export default App;
