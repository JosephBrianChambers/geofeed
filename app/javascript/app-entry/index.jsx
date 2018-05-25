import React from 'react'
import ReactDOM from 'react-dom'
import App from './app'
import { Provider } from "react-redux";
import configureStore from './state/store'

const provider = (
  <Provider store={configureStore(window.REDUX_INITIAL_DATA)}>
    <App />
  </Provider>
)

ReactDOM.render(provider, document.getElementById('app-anchor'))
