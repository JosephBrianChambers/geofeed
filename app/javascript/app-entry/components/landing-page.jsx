import React from 'react'
import { Link } from 'react-router-dom'

const LandingPage = (props) => (
  <div>
    <header>
      <h2>Header</h2>
      <Link to="/login">
        Login
      </Link>
    </header>
    <main>main</main>
    <footer>footer</footer>
  </div>
)

export default LandingPage
