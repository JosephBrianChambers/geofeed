import Axios from 'axios';

const axiosInstance = Axios.create({
  baseURL: 'http://localhost:3001/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});


const login = (email, password) => {
  return axiosInstance.post('/auth/login', {
    email: email,
    password: password,
  })
};

export default { login }
