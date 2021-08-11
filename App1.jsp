import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import { RecoilRoot } from "recoil";
import { recoilPersist } from 'recoil-persist' // import stay the same

const {
-  RecoilPersist,
-  updateState
+  persistAtom
} = recoilPersist(
-   ['count'], // no need for specifying atoms keys
    {
        key: 'recoil-persist', // configuration stay the same too
        storage: localStorage
    }
)

const counterState = atom({
  key: 'count',
  default: 0,
- persistence_UNSTABLE: { // Please remove persistence_UNSTABLE from atom definition
-   type: 'log',
- },
+ effects_UNSTABLE: [persistAtom], // Please add effects_UNSTABLE key to atom definition
})

function App() {
  const [count, setCount] = useRecoilState(counterState)
  return (
    <div>
      <h3>Counter: {count}</h3>
      <button onClick={() => setCount(count + 1)}>Increase</button>
      <button onClick={() => setCount(count - 1)}>Decrease</button>
    </div>
  )
}

ReactDOM.render(
  <React.StrictMode>
-   <RecoilRoot initializeState={({set}) => updateState({set})>
+   <RecoilRoot> // Please remove updateState function from initiallizeState
-     <RecoilPersist /> // and also remove RecoilPersist component
      <App />
    </RecoilRoot>
  </React.StrictMode>,
  document.getElementById('root')
);
