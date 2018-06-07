import React from 'react';
import { Link } from 'react-router-dom'
import { withRouter } from 'react-router-dom';

class LayoutContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return (
      <div>
        <header>
          <h2>Header</h2>
          <Link to="/login">Login</Link>
        </header>
        <main>
          {this.props.children}
        </main>
        <footer>footer</footer>
      </div>
    );
  }
}

export default withRouter(LayoutContainer);
