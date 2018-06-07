import React from 'react';
import { Link } from 'react-router-dom'
import { withRouter } from 'react-router-dom';
import styles from './layout-container-styles'

class LayoutContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    return (
      <div>
        <header className={styles.header}>
          <h2>Header</h2>
          <Link to="/login">Login</Link>
        </header>
        <main className={styles.main}>
          {this.props.children}
        </main>
        <footer className={styles.footer}>footer</footer>
      </div>
    );
  }
}

export default withRouter(LayoutContainer);
