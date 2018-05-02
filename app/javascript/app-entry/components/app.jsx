import React from 'react'
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'
import LandingPage from './landing-page'

const App = (props) => (
  <Router startingQuoteId={props.startingQuoteId}>
    <div>
      <Route path='/' component={LandingPage}/>
    </div>
  </Router>
)

export default App
