import React from 'react';
import { withRouter } from 'react-router-dom';
import appRoutes from '../../config/app-routes';
import { connect } from 'react-redux';
import AuthApi from '../../apis/auth'
import UserApi from '../../apis/user'
import { updateUser } from '../../state/ducks/user'


class LoginForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: '',
      password: '',
      isLoggingIn: false,
      isInvalidCredentials: false
    };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleSubmit(event) {
    event.preventDefault();
    this.setState({ isLoggingIn: true, isInvalidCredentials: false })

    AuthApi.login(this.state.email, this.state.password)
    .then((_) => {
      return UserApi.getCurrentUser()
    })
    .then((response) => {
      this.props.updateUser({ name: response.data.name })
      this.setState({ isLoggingIn: false })
      this.props.history.push(appRoutes.mapUserPage.path)
    })
    .catch((error) => {
      this.setState({ isLoggingIn: false, isInvalidCredentials: true })
    })
  }

  loginError() {
    return (
      <p>Email or Password are incorrect.</p>
    )
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Email:
          <input type="text" name="email" value={this.state.email} onChange={this.handleChange} />
        </label>

        <label>
          Password:
          <input type="text" name="password" value={this.state.password} onChange={this.handleChange} />
        </label>
        {this.state.isInvalidCredentials ? this.loginError() : null}
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

const mapStateToProps = (state) => ({
  isInvalidCredentials: state.user.isInvalidCredentials,
  isAuthenticating: state.user.isInvalidCredentials,
  isUserBeingFetched: state.user.isBeingFetched,
});

const mapDispatchToProps = (dispatch) => ({
  updateUser: (payload) => { dispatch(updateUser(payload)) },
})

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(LoginForm));
