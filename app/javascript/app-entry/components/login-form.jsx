import React from 'react';
import AuthApi from '../apis/auth'

class LoginForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: '',
      password: '',
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
    this.setState({isInvalidCredentials: false})

    AuthApi.login(this.state.email, this.state.password)
    .catch((error) => {
      this.setState({isInvalidCredentials: true})
    }).then(function (response) {
      console.log(response);
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

export default LoginForm;
