import Axios from 'axios';

const axiosInstance = Axios.create({
  baseURL: 'http://localhost:3001/api/',
  timeout: 1000,
  headers: {'X-Custom-Header': 'foobar'}
});


const getCurrentUser = () => {
  return axiosInstance.get('/users')
};

export default { getCurrentUser }
