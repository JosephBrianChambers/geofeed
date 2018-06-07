import React from 'react'
import {
  BrowserRouter,
  Route,
  Switch,
} from 'react-router-dom'
import LayoutContainer from './views/layout-container'
import LandingPage from './views/landing-page'
import LoginPage from './views/login-page'
import UserMapPage from './views/user-map-page'

const App = (props) => (
  <BrowserRouter>
    <LayoutContainer>
      <Switch>
        <Route exact path='/' component={LandingPage} />
        <Route path='/login' component={LoginPage} />
        <Route path='/user_map_page' component={UserMapPage} />
      </Switch>
    </LayoutContainer>
  </BrowserRouter>
)

export default App
