import React from 'react';
import { Link } from 'react-router-dom';
import LoginForm from './login-form';

const clickHandler = (e) => {
  e.preventDefault;

}

const LoginPage = (props) => (
  <div>
    <LoginForm />
  </div>
)

export default LoginPage
