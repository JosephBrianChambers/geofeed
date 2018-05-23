import React from 'react'
import {
  BrowserRouter as Router,
  Route,
  Switch,
} from 'react-router-dom'

import LandingPage from './views/landing-page'
import LoginPage from './views/login-page'
import UserMapPage from './views/user-map-page'

const App = (props) => (
  <Router>
    <Switch>
      <Route path='/' component={LandingPage} />
      <Route path='/login/' component={LoginPage} />
      <Route path='/user_map_page' component={UserMapPage} />
    </Switch>
  </Router>
)

export default App
