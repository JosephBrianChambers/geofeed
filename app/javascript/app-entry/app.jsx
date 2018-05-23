import React from 'react'
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'

import LandingPage from './views/landing-page'
import LoginPage from './views/login-page'

const App = (props) => (
  <Router startingQuoteId={props.startingQuoteId}>
    <div>
      <Route path='/' component={LandingPage} />
      <Route path='/login/' component={LoginPage} />
    </div>
  </Router>
)

export default App
