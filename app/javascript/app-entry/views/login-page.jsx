import React from 'react';
import { withRouter } from 'react-router-dom';
import LoginForm from './components/login-form';

class LoginPage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {};

    this.handleOauthClick = this.handleOauthClick.bind(this);
  }

  handleOauthClick(oauthProvider) {

    return (event) => {
      window.location = window.location.origin + `/auth/${oauthProvider}`
      // this.props.history.push(`/auth/${oauthProvider}`)
      // debugger
    }
  }

  render() {
    return (
      <div>
        <LoginForm />
        <p>Or Login with your existing service..</p>
        <button onClick={this.handleOauthClick('instagram')}>Login with Instagram</button>
      </div>
    )
  }
}

export default withRouter(LoginPage)
